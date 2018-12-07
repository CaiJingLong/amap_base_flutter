//
// Created by Yohom Bao on 2018-12-07.
//

#import "SearchPoiId.h"
#import "JSONModelError.h"
#import "UnifiedPoiSearchQuery.h"
#import "UnifiedPoiResult.h"


@implementation SearchPoiId {
    MAMapView *_mapView;
    AMapSearchAPI *_search;
    FlutterResult _result;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;

    // 搜索api回调设置
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    _result = result;

    NSDictionary *paramDic = call.arguments;
    NSString *id = (NSString *) paramDic[@"id"];

    NSLog(@"方法map#searchPoiId ios端参数: id -> %@", id);

    AMapPOIIDSearchRequest *request = [[AMapPOIIDSearchRequest alloc] init];
    request.uid = id;
    request.requireExtension = YES;
    [_search AMapPOIIDSearch:request];
}

/// poi搜索回调
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    NSLog(@"poi搜索回调 SearchPoiId");
    if (response.pois.count == 0) {
        _result(@"没有找到POI");
        return;
    }

    _result([[[UnifiedPoiResult alloc] initWithPoiResult:response] toJSONString]);
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    _result(error);
}
@end