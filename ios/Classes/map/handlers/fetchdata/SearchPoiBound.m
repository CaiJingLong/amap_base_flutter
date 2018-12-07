//
// Created by Yohom Bao on 2018-12-07.
//

#import "SearchPoiBound.h"
#import "JSONModelError.h"
#import "UnifiedPoiSearchQuery.h"
#import "UnifiedPoiResult.h"


@implementation SearchPoiBound {
    MAMapView *_mapView;
    AMapSearchAPI *_search;
    FlutterResult _result;
}
- (NSObject <MapMethodHandler> *)with:(MAMapView *)mapView {
    _mapView = mapView;
    // 搜索api回调设置
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    _result = result;

    NSDictionary *paramDic = call.arguments;

    NSString *query = (NSString *) paramDic[@"query"];

    NSLog(@"方法map#searchPoiBound ios端参数: query -> %@", query);

    JSONModelError *error;
    UnifiedPoiSearchQuery *request = [[UnifiedPoiSearchQuery alloc] initWithString:query error:&error];
    NSLog(@"JSONModelError: %@", error.description);

    [_search AMapPOIAroundSearch:[request toAMapPOIAroundSearchRequest]];
}

/// poi搜索回调
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    if (response.pois.count == 0) {
        return;
    }

    _result([[[UnifiedPoiResult alloc] initWithPoiResult:response] toJSONString]);
}

@end