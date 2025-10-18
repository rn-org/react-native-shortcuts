import { type TurboModule } from 'react-native';
export interface ShortcutResponseType {
    id: string;
    title: string;
    subTitle?: string;
    longLabel?: string;
}
export interface ShortcutParamsType extends ShortcutResponseType {
    symbolName?: string;
    iconName?: string;
}
export interface Spec extends TurboModule {
    addShortcut(params: ShortcutParamsType): Promise<ShortcutResponseType>;
    updateShortcut(params: ShortcutParamsType): Promise<ShortcutResponseType>;
    removeShortcut(id: string): Promise<boolean>;
    removeAllShortcuts(): Promise<boolean>;
    getShortcutById(id: string): Promise<ShortcutResponseType>;
    isShortcutExists(id: string): Promise<boolean>;
    isShortcutSupported(): Promise<boolean>;
    getInitialShortcutId(): Promise<string>;
    addListener: (eventType: string) => void;
    removeListeners: (count: number) => void;
}
declare const _default: Spec;
export default _default;
//# sourceMappingURL=NativeShortcuts.d.ts.map