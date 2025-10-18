#import <RNShortcuts.h>

#if __has_include("RNShortcuts-Bridging-Header.h")
#import "RNShortcuts-Bridging-Header.h"
#else
#import "react-native-shortcuts/RNShortcuts-Bridging-Header.h"
#endif

#if __has_include("react_native_shortcuts-Swift.h")
#import "react_native_shortcuts-Swift.h"
#else
#import "react_native_shortcuts/react_native_shortcuts-Swift.h"
#endif

@implementation RNShortcuts

RCT_EXPORT_MODULE()

RNShortcutsImpl *rnShortcutsImpl = [RNShortcutsImpl shared];

static RNShortcuts *sharedInstance = nil;

- (instancetype)init {
    self = [super init];
    if (self) {
        sharedInstance = self;
    }
    return self;
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"onShortcutUsed"];
}

#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const facebook::react::ObjCTurboModule::InitParams &)params {
    return std::make_shared<facebook::react::NativeShortcutsSpecJSI>(params);
}
#endif

#ifdef RCT_NEW_ARCH_ENABLED
- (NSDictionary *)convertShortcutParamsToDictionary:(JS::NativeShortcuts::ShortcutParamsType &)params {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict[@"id"] = params.id_() ?: @"";
    dict[@"title"] = params.title() ?: @"";
    dict[@"subTitle"] = params.subTitle() ?: @"";
    dict[@"longLabel"] = params.longLabel() ?: @"";
    dict[@"symbolName"] = params.symbolName() ?: @"";
    dict[@"iconName"] = params.iconName() ?: @"";

    return [dict copy];
}
#endif

#ifdef RCT_NEW_ARCH_ENABLED
- (void)addShortcut:(JS::NativeShortcuts::ShortcutParamsType &)params resolve:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject {
    NSDictionary *mutableParams = [self convertShortcutParamsToDictionary:params];

    [rnShortcutsImpl addShortcut:mutableParams withResolve:resolve withReject:reject];
}

#else
RCT_EXPORT_METHOD(addShortcut:(nonnull NSDictionary *)params resolve:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject) {

    [rnShortcutsImpl addShortcut:params withResolve:resolve withReject:reject];
}
#endif

RCT_EXPORT_METHOD(getInitialShortcutId:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject) {
    return [rnShortcutsImpl getInitialShortcutId: resolve withReject: reject];
}

RCT_EXPORT_METHOD(getShortcutById:(nonnull NSString *)id resolve:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject) {
    [rnShortcutsImpl getShortcutById: id withResolve: resolve withReject: reject];
}

RCT_EXPORT_METHOD(isShortcutExists:(nonnull NSString *)id resolve:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject) {
    [rnShortcutsImpl isShortcutExists: id withResolve: resolve withReject: reject];
}

RCT_EXPORT_METHOD(isShortcutSupported:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject) {
    [rnShortcutsImpl isShortcutSupported: resolve withReject: reject];
}

RCT_EXPORT_METHOD(removeAllShortcuts:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject) {
    [rnShortcutsImpl removeAllShortcuts: resolve withReject: reject];
}

RCT_EXPORT_METHOD(removeShortcut:(nonnull NSString *)id resolve:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject) {
    [rnShortcutsImpl removeShortcut: id withResolve: resolve withReject: reject];
}

#ifdef RCT_NEW_ARCH_ENABLED
- (void)updateShortcut:(JS::NativeShortcuts::ShortcutParamsType &)params resolve:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject {
    NSDictionary *mutableParams = [self convertShortcutParamsToDictionary:params];

    [rnShortcutsImpl updateShortcut:mutableParams withResolve:resolve withReject:reject];
}

#else
RCT_EXPORT_METHOD(updateShortcut:(nonnull NSDictionary *)params resolve:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject) {
    [rnShortcutsImpl updateShortcut:params withResolve:resolve withReject:reject];
}
#endif

+ (void)handleShortcutItem:(nonnull UIApplicationShortcutItem *)shortcutItem {
    RNShortcutsImpl.shortcutItemType = shortcutItem.type;
    if (sharedInstance) {
        [sharedInstance sendEventWithName:@"onShortcutUsed" body:shortcutItem.type];
    }
}

@end

