#import "AMapBasePlugin.h"
#import "AMapSearchKit.h"
#import "NSObject+Navi.h"
#import "AMapViewFactory.h"

static NSObject <FlutterPluginRegistrar> *_registrar;

@implementation AMapBasePlugin

+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    [AMapServices sharedServices].enableHTTPS = YES;
    _registrar = registrar;

    [_registrar setupNaviChannel];
    [registrar registerViewFactory:[[AMapViewFactory alloc] init]
                            withId:@"me.yohom/AMapView"];
}

+ (NSObject <FlutterPluginRegistrar> *)registrar {
    return _registrar;
}

@end
