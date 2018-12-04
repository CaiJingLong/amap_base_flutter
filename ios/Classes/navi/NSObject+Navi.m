//
// Created by Yohom Bao on 2018/11/25.
//

#import <AMapNavi/AMapNaviKit/AMapNaviCompositeUserConfig.h>
#import <AMapNavi/AMapNaviKit/AMapNaviCompositeManager.h>
#import "NSObject+Navi.h"

NSString *naviChannelName = @"me.yohom/amap_navi";
NSString *startNavi = @"startNavi";
NSString *setKey = @"setKey";

@implementation NSObject (AMapNavi)

- (void)setupNaviChannel {
    FlutterMethodChannel *naviChannel = [FlutterMethodChannel
            methodChannelWithName:naviChannelName
                  binaryMessenger:[self messenger]];

    [naviChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        if ([startNavi isEqualToString:call.method]) {
            if ([AMapServices sharedServices].apiKey == nil) {
                result(@"未设置key");
            }
            NSDictionary *paramDic = call.arguments;
            CGFloat lat = [paramDic[@"lat"] floatValue];
            CGFloat lon = [paramDic[@"lon"] floatValue];
            NSLog(@"lat: %f, lon: %f", lat, lon);
            AMapNaviCompositeUserConfig *config = [[AMapNaviCompositeUserConfig alloc] init];
            [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd
                               location:[AMapNaviPoint locationWithLatitude:lat longitude:lon]
                                   name:@""
                                  POIId:nil];
            [[[AMapNaviCompositeManager alloc] init] presentRoutePlanViewControllerWithOptions:config];
        } else if ([setKey isEqualToString:call.method]) {
            NSString *key = call.arguments[@"key"];
            [AMapServices sharedServices].apiKey = key;
            result(@"key设置成功");
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
}

@end
