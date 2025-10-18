import { type EventSubscription } from 'react-native';
import { type ShortcutParamsType, type ShortcutResponseType } from './NativeShortcuts';
declare function addShortcut(params: ShortcutParamsType): Promise<ShortcutResponseType>;
declare function updateShortcut(params: ShortcutParamsType): Promise<ShortcutResponseType>;
declare function removeShortcut(id: string): Promise<boolean>;
declare function removeAllShortcuts(): Promise<boolean>;
declare function getShortcutById(id: string): Promise<ShortcutResponseType>;
declare function isShortcutExists(id: string): Promise<boolean>;
declare function isShortcutSupported(): Promise<boolean>;
declare function getInitialShortcutId(): Promise<string>;
declare function addOnShortcutUsedListener(callback: (id: string) => void): EventSubscription;
declare const _default: {
    addShortcut: typeof addShortcut;
    updateShortcut: typeof updateShortcut;
    removeShortcut: typeof removeShortcut;
    removeAllShortcuts: typeof removeAllShortcuts;
    getShortcutById: typeof getShortcutById;
    isShortcutExists: typeof isShortcutExists;
    isShortcutSupported: typeof isShortcutSupported;
    getInitialShortcutId: typeof getInitialShortcutId;
    addOnShortcutUsedListener: typeof addOnShortcutUsedListener;
};
export default _default;
//# sourceMappingURL=index.d.ts.map