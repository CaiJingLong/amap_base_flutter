#import "AmapBasePlugin.h"

@implementation AmapBasePlugin

- (AMapNaviCompositeManager *)compositeManager {
    if (!_compositeManager) {
        _compositeManager = [[AMapNaviCompositeManager alloc] init];  // 初始化
    }
    return _compositeManager;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"me.yohom/amap_navi"
                                     binaryMessenger:[registrar messenger]];
    AmapBasePlugin* instance = [[AmapBasePlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"startNavi" isEqualToString:call.method]) {
        NSDictionary* paramDic = call.arguments;
        CGFloat lat = [paramDic[@"lat"] doubleValue];
        CGFloat lon = [paramDic[@"lon"] doubleValue];
        AMapNaviCompositeUserConfig* config = [[AMapNaviCompositeUserConfig alloc] init];
        [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd
                           location:[AMapNaviPoint locationWithLatitude:lat longitude:lon]
                               name:@""
                              POIId:nil];
        [self.compositeManager presentRoutePlanViewControllerWithOptions:config];
    } else if([@"setKey" isEqualToString:call.method]) {
        NSString* key = call.arguments[@"key"];
        [AMapServices sharedServices].apiKey = key;
        result(@"key设置成功");
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
