//
// Created by Yohom Bao on 2018/11/25.
//

#import "AMapNavi.h"

@implementation AmapBasePlugin (AMapNavi)

- (void)handleNavi:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([@"startNavi" isEqualToString:call.method]) {
        NSDictionary *paramDic = call.arguments;
        CGFloat lat = [paramDic[@"lat"] floatValue];
        CGFloat lon = [paramDic[@"lon"] floatValue];
        AMapNaviCompositeUserConfig *config = [[AMapNaviCompositeUserConfig alloc] init];
        [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd
                           location:[AMapNaviPoint locationWithLatitude:lat longitude:lon]
                               name:@""
                              POIId:nil];
        [self.compositeManager presentRoutePlanViewControllerWithOptions:config];
    } else if ([@"setKey" isEqualToString:call.method]) {
        NSString *key = call.arguments[@"key"];
        [AMapServices sharedServices].apiKey = key;
        result(@"key设置成功");
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end