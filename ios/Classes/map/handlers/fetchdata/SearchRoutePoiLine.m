//
// Created by Yohom Bao on 2018-12-07.
//

#import "SearchRoutePoiLine.h"
#import "JSONModelError.h"
#import "UnifiedRoutePoiSearchQuery.h"
#import "UnifiedRoutePOISearchResult.h"


@implementation SearchRoutePoiLine {
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

    NSLog(@"方法map#searchRoutePoiLine ios端参数: query -> %@", query);

    JSONModelError *error;
    UnifiedRoutePoiSearchQuery *request = [[UnifiedRoutePoiSearchQuery alloc] initWithString:query error:&error];
    NSLog(@"JSONModelError: %@", error.description);

    [_search AMapRoutePOISearch:[request toAMapRoutePOISearchRequestLine]];
}

/// 沿途搜索回调
- (void)onRoutePOISearchDone:(AMapRoutePOISearchRequest *)request response:(AMapRoutePOISearchResponse *)response {
    if (response.pois.count == 0) {
        return;
    }

//    UnifiedRoutePOISearchResult *result = [[UnifiedRoutePOISearchResult alloc] initWithAMapRoutePOISearchResponse:response];
//    NSString *resultString = [result toJSONString];
//    NSLog(@"RESULT: %@", resultString);
    _result([[[UnifiedRoutePOISearchResult alloc] initWithAMapRoutePOISearchResponse:response] toJSONString]);
}

@end