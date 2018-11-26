#import "AmapBasePlugin.h"
#import "AMapViewFactory.h"
#import "AMapNavi.h"

@implementation AmapBasePlugin

+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    [registrar setupNaviChannel];
    [registrar registerViewFactory:[AMapViewFactory alloc] withId:@"me.yohom/AMapView"];
}

@end
