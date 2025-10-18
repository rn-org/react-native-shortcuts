"use strict";

import { Platform, NativeEventEmitter, NativeModules } from 'react-native';
const RNShortcutsModule = require("./NativeShortcuts").default ?? NativeModules.RNShortcuts;
const LINKING_ERROR = `The package '@rn-org/react-native-shortcuts' doesn't seem to be linked. Make sure: \n\n` + Platform.select({
  ios: "- You have run 'pod install'\n",
  default: ''
}) + '- You rebuilt the app after installing the package\n' + '- You are not using Expo Go\n';
const RNShortcuts = RNShortcutsModule ? RNShortcutsModule : new Proxy({}, {
  get() {
    throw new Error(LINKING_ERROR);
  }
});
const emitterModule = Platform.select({
  ios: RNShortcuts,
  android: null
});
const shortcutsEventEmitter = new NativeEventEmitter(emitterModule);
async function addShortcut(params) {
  if (!params.id || !params.title) {
    return Promise.reject('Invalid request parameters');
  }
  return RNShortcuts.addShortcut(params);
}
async function updateShortcut(params) {
  if (!params.id || !params.title) {
    return Promise.reject('Invalid request parameters');
  }
  return RNShortcuts.updateShortcut(params);
}
async function removeShortcut(id) {
  if (!id) {
    return Promise.reject('Invalid id');
  }
  return RNShortcuts.removeShortcut(id);
}
async function removeAllShortcuts() {
  return RNShortcuts.removeAllShortcuts();
}
async function getShortcutById(id) {
  if (!id) {
    return Promise.reject('Invalid id');
  }
  return RNShortcuts.getShortcutById(id);
}
async function isShortcutExists(id) {
  if (!id) {
    return Promise.reject('Invalid id');
  }
  return RNShortcuts.isShortcutExists(id);
}
async function isShortcutSupported() {
  return RNShortcuts.isShortcutSupported();
}
async function getInitialShortcutId() {
  return RNShortcuts.getInitialShortcutId();
}
function addOnShortcutUsedListener(callback) {
  return shortcutsEventEmitter.addListener('onShortcutUsed', callback);
}
export default {
  addShortcut,
  updateShortcut,
  removeShortcut,
  removeAllShortcuts,
  getShortcutById,
  isShortcutExists,
  isShortcutSupported,
  getInitialShortcutId,
  addOnShortcutUsedListener
};
//# sourceMappingURL=index.js.map