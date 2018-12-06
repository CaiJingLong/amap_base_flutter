#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "AMapServices.h"

@implementation AppDelegate

- (BOOL)          application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    [AMapServices sharedServices].apiKey =@"27d2a355f61d0985edc095adb330788b";

    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
