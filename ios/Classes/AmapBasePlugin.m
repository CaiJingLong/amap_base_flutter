#import "AmapBasePlugin.h"
#import "AMapViewFactory.h"
#import "AMapNavi.h"

@implementation AmapBasePlugin

- (AMapNaviCompositeManager *)compositeManager {
    if (!_compositeManager) {
        _compositeManager = [[AMapNaviCompositeManager alloc] init];  // 初始化
    }
    return _compositeManager;
}

+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *naviChannel = [FlutterMethodChannel
            methodChannelWithName:@"me.yohom/amap_navi"
                  binaryMessenger:[registrar messenger]];

    [registrar addMethodCallDelegate:[[AmapBasePlugin alloc] init] channel:naviChannel];

    [registrar registerViewFactory:[AMapViewFactory alloc] withId:@"me.yohom/AMapView"];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    [self handleNavi:call result:result];
}

@end
