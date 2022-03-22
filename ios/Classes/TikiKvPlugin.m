#import "TikiKvPlugin.h"
#if __has_include(<tiki_kv/tiki_kv-Swift.h>)
#import <tiki_kv/tiki_kv-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "tiki_kv-Swift.h"
#endif

@implementation TikiKvPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTikiKvPlugin registerWithRegistrar:registrar];
}
@end
