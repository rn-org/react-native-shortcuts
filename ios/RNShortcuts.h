#import <React/RCTEventEmitter.h>

#ifdef RCT_NEW_ARCH_ENABLED
#import <shortcuts/shortcuts.h>
#else
#import <React/RCTBridgeModule.h>
#endif

NS_ASSUME_NONNULL_BEGIN

#ifdef RCT_NEW_ARCH_ENABLED
@interface RNShortcuts : RCTEventEmitter <NativeShortcutsSpec>
#else
@interface RNShortcuts : RCTEventEmitter <RCTBridgeModule>
#endif

+ (void)handleShortcutItem:(UIApplicationShortcutItem *)shortcutItem;

@end

NS_ASSUME_NONNULL_END

