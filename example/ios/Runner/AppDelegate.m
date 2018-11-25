#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "AMapServices.h"

@implementation AppDelegate

- (BOOL)          application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    [AMapServices sharedServices].apiKey =@"9154ddba741dc1e383716405f1ba1c5c";

    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
