#import "AMapBasePlugin.h"
#import "AMapSearchKit.h"
#import "NSObject+Navi.h"
#import "AMapViewFactory.h"

static NSObject <FlutterPluginRegistrar> *_registrar;

@implementation AMapBasePlugin

+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    [AMapServices sharedServices].enableHTTPS = YES;
    _registrar = registrar;

    FlutterMethodChannel *naviChannel = [FlutterMethodChannel
            methodChannelWithName:@"me.yohom/amap_base"
                  binaryMessenger:[registrar messenger]];

    [naviChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        if ([@"setKey" isEqualToString:call.method]) {
            NSString *key = call.arguments[@"key"];
            [AMapServices sharedServices].apiKey = key;
            result(@"key设置成功");
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];

    [_registrar setupNaviChannel];
    [_registrar registerViewFactory:[[AMapViewFactory alloc] init]
                            withId:@"me.yohom/AMapView"];
}

+ (NSObject <FlutterPluginRegistrar> *)registrar {
    return _registrar;
}

@end
