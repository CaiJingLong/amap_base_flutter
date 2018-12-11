//
// Created by Yohom Bao on 2018/11/25.
//

#import "AMapServices.h"
#import "AMapNaviCompositeManager.h"
#import "AMapNaviCompositeUserConfig.h"
#import "NSObject+Navi.h"

NSString *naviChannelName = @"me.yohom/amap_navi";

@implementation NSObject (AMapNavi)

- (void)setupNaviChannel {
    FlutterMethodChannel *naviChannel = [FlutterMethodChannel
            methodChannelWithName:naviChannelName
                  binaryMessenger:[self messenger]];

    [naviChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        if ([@"startNavi" isEqualToString:call.method]) {
            if ([AMapServices sharedServices].apiKey == nil) {
                result([FlutterError errorWithCode:@"未设置key"
                                           message:@"未设置key"
                                           details:@"未设置key"]);
            }
            NSDictionary *paramDic = call.arguments;
            CGFloat lat = [paramDic[@"lat"] floatValue];
            CGFloat lon = [paramDic[@"lon"] floatValue];
            // iOS端只支持驾车导航
            // > 通过设置起点、途径点（最多支持三个）、终点直接调起路径规划页面；支持通过设置页面调起类型选择方式，当前默认仅可选择驾车导航模式。
            // 参考 https://lbs.amap.com/api/ios-navi-sdk/guide/navi-component/use-navi-component
            NSInteger naviType = [paramDic[@"naviType"] integerValue];

            NSLog(@"lat: %f, lon: %f", lat, lon);
            AMapNaviCompositeUserConfig *config = [[AMapNaviCompositeUserConfig alloc] init];
            [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd
                               location:[AMapNaviPoint locationWithLatitude:lat longitude:lon]
                                   name:@""
                                  POIId:nil];
            [[[AMapNaviCompositeManager alloc] init] presentRoutePlanViewControllerWithOptions:config];
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
}

@end
