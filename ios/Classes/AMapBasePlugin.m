#import "AMapBasePlugin.h"

static NSObject <FlutterPluginRegistrar> *_registrar;

@implementation AMapBasePlugin

+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    [AMapServices sharedServices].enableHTTPS = YES;
    _registrar = registrar;
}

+ (NSObject <FlutterPluginRegistrar> *)registrar {
    return _registrar;
}

@end
