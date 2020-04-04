#import "FlutterUpgradePlugin.h"
#if __has_include(<flutter_upgrade/flutter_upgrade-Swift.h>)
#import <flutter_upgrade/flutter_upgrade-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_upgrade-Swift.h"
#endif

@implementation FlutterUpgradePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterUpgradePlugin registerWithRegistrar:registrar];
}
@end
