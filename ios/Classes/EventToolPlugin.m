#import "EventToolPlugin.h"
#import <event_tool/event_tool-Swift.h>

@implementation EventToolPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEventToolPlugin registerWithRegistrar:registrar];
}
@end
