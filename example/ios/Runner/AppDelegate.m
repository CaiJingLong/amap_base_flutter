#include "AppDelegate.h"
#import "AMapServices.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  [AMapServices sharedServices].apiKey = @"9154ddba741dc1e383716405f1ba1c5c";
  // [AMapServices sharedServices].apiKey =@"27d2a355f61d0985edc095adb330788b";

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
