#import "AMapBasePlugin.h"
#import "NSObject+Navi.h"
#import "AMapSearchKit.h"
#import "AMapViewFactory.h"

static NSObject <FlutterPluginRegistrar> *_registrar;

@implementation AMapBasePlugin

+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    [AMapServices sharedServices].enableHTTPS = YES;
    _registrar = registrar;

    [registrar setupNaviChannel];
    [registrar registerViewFactory:[[AMapViewFactory alloc] init]
                            withId:@"me.yohom/AMapView"];
}

+ (NSObject <FlutterPluginRegistrar> *)registrar {
    return _registrar;
}

@end
