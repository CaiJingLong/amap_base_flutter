#import "AMapBasePlugin.h"
#import "AMapSearchKit.h"
#import "NSObject+Navi.h"
#import "AMapViewFactory.h"
#import "MapMethodHandler.h"
#import "MapFunctionRegistry.h"

static NSObject <FlutterPluginRegistrar> *_registrar;

@implementation AMapBasePlugin

+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    [AMapServices sharedServices].enableHTTPS = YES;
    _registrar = registrar;

    FlutterMethodChannel *setKeyChannel = [FlutterMethodChannel
            methodChannelWithName:@"me.yohom/amap_base"
                  binaryMessenger:[registrar messenger]];

    [setKeyChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        if ([@"setKey" isEqualToString:call.method]) {
            NSString *key = call.arguments[@"key"];
            [AMapServices sharedServices].apiKey = key;
            result(@"key设置成功");
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];

    FlutterMethodChannel *toolChannel = [FlutterMethodChannel
            methodChannelWithName:@"me.yohom/tool"
                  binaryMessenger:[registrar messenger]];

    [toolChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        NSObject <MapMethodHandler> *handler = [MapFunctionRegistry mapMethodHandler][call.method];
        if (handler) {
            [[handler init] onMethodCall:call :result];
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];

    FlutterMethodChannel *offlineChannel = [FlutterMethodChannel
            methodChannelWithName:@"me.yohom/offline"
                  binaryMessenger:[registrar messenger]];

    [offlineChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        NSObject <MapMethodHandler> *handler = [MapFunctionRegistry mapMethodHandler][call.method];
        if (handler) {
            [[handler init] onMethodCall:call :result];
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
