#import "AppMarketPlugin.h"
#if __has_include(<app_market/app_market-Swift.h>)
#import <app_market/app_market-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "app_market-Swift.h"
#endif

@implementation AppMarketPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAppMarketPlugin registerWithRegistrar:registrar];
}
@end
