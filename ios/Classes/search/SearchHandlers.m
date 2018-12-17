//
// Created by Yohom Bao on 2018-12-16.
//

#import "SearchHandlers.h"
#import "Misc.h"
#import "MJExtension.h"
#import "SearchModels.h"


@implementation SearchGeocode {
    AMapSearchAPI *_search;
    FlutterResult _result;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 搜索api回调设置
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }

    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    _result = result;

    NSDictionary *paramDic = call.arguments;

    NSString *name = (NSString *) paramDic[@"name"];
    NSString *city = (NSString *) paramDic[@"city"];

    NSLog(@"search#searchGeocode ios端参数: name -> %@, city -> %@", name, city);

    AMapGeocodeSearchRequest *request = [[AMapGeocodeSearchRequest alloc] init];
    request.address = name;
    request.city = city;

    [_search AMapGeocodeSearch:request];
}

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response {
    if (response.geocodes.count == 0) {
        _result([FlutterError errorWithCode:@"搜索不到结果"
                                    message:@"搜索不到结果"
                                    details:nil]);
        return;
    }

    _result([[[UnifiedGeocodeResult alloc] initWithAMapGeocodeSearchResponse:response] mj_JSONString]);
}

/// 搜索失败回调
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    NSLog(@"搜索失败回调");
    _result([FlutterError errorWithCode:[NSString stringWithFormat:@"%d", error.code]
                                message:[Misc toAMapErrorDesc:error.code]
                                details:nil]);
}

@end

@implementation SearchPoiBound {
    AMapSearchAPI *_search;
    FlutterResult _result;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 搜索api回调设置
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }

    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    _result = result;

    NSDictionary *paramDic = call.arguments;

    NSString *query = (NSString *) paramDic[@"query"];

    NSLog(@"方法map#searchPoiBound ios端参数: query -> %@", query);

    UnifiedPoiSearchQuery *request = [UnifiedPoiSearchQuery mj_objectWithKeyValues:query];

    [_search AMapPOIAroundSearch:[request toAMapPOIAroundSearchRequest]];
}

/// poi搜索回调
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    NSLog(@"poi搜索回调");
    _result([[[UnifiedPoiResult alloc] initWithPoiResult:response] mj_JSONString]);
}

/// 搜索失败回调
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    NSLog(@"搜索失败回调");
    _result([FlutterError errorWithCode:[NSString stringWithFormat:@"%d", error.code]
                                message:[Misc toAMapErrorDesc:error.code]
                                details:nil]);
}
@end

@implementation SearchPoiId {
    AMapSearchAPI *_search;
    FlutterResult _result;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 搜索api回调设置
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }

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
    NSLog(@"poi搜索回调");
    _result([[[UnifiedPoiResult alloc] initWithPoiResult:response] mj_JSONString]);
}

/// 搜索失败回调
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    NSLog(@"搜索失败回调");
    _result([FlutterError errorWithCode:[NSString stringWithFormat:@"%d", error.code]
                                message:[Misc toAMapErrorDesc:error.code]
                                details:nil]);
}
@end

@implementation SearchPoiKeyword {
    AMapSearchAPI *_search;
    FlutterResult _result;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        // 搜索api回调设置
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }

    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    _result = result;

    NSDictionary *paramDic = call.arguments;

    NSString *query = (NSString *) paramDic[@"query"];

    NSLog(@"方法map#searchPoi ios端参数: query -> %@", query);
    UnifiedPoiSearchQuery *request = [UnifiedPoiSearchQuery mj_objectWithKeyValues:query];

    [_search AMapPOIKeywordsSearch:[request toAMapPOIKeywordsSearchRequest]];
}

/// poi搜索回调
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    NSLog(@"poi搜索回调");
    _result([[[UnifiedPoiResult alloc] initWithPoiResult:response] mj_JSONString]);
}

/// 搜索失败回调
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    NSLog(@"搜索失败回调");
    _result([FlutterError errorWithCode:[NSString stringWithFormat:@"%d", error.code]
                                message:[Misc toAMapErrorDesc:error.code]
                                details:nil]);
}
@end

@implementation SearchPoiPolygon {
    AMapSearchAPI *_search;
    FlutterResult _result;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 搜索api回调设置
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }

    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    _result = result;

    NSDictionary *paramDic = call.arguments;

    NSString *query = (NSString *) paramDic[@"query"];

    NSLog(@"方法map#searchPoiPolygon ios端参数: query -> %@", query);

    UnifiedPoiSearchQuery *request = [UnifiedPoiSearchQuery mj_objectWithKeyValues:query];

    [_search AMapPOIPolygonSearch:[request toAMapPOIPolygonSearchRequest]];
}

/// poi搜索回调
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    NSLog(@"poi搜索回调");
    _result([[[UnifiedPoiResult alloc] initWithPoiResult:response] mj_JSONString]);
}

/// 搜索失败回调
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    NSLog(@"搜索失败回调");
    _result([FlutterError errorWithCode:[NSString stringWithFormat:@"%d", error.code]
                                message:[Misc toAMapErrorDesc:error.code]
                                details:nil]);
}

@end

@implementation SearchRoutePoiLine {
    AMapSearchAPI *_search;
    FlutterResult _result;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 搜索api回调设置
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }

    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    _result = result;

    NSDictionary *paramDic = call.arguments;

    NSString *query = (NSString *) paramDic[@"query"];

    NSLog(@"方法map#searchRoutePoiLine ios端参数: query -> %@", query);

    UnifiedRoutePoiSearchQuery *request = [UnifiedRoutePoiSearchQuery mj_objectWithKeyValues:query];

    [_search AMapRoutePOISearch:[request toAMapRoutePOISearchRequestLine]];
}

/// 沿途搜索回调
- (void)onRoutePOISearchDone:(AMapRoutePOISearchRequest *)request response:(AMapRoutePOISearchResponse *)response {
    NSLog(@"poi搜索回调");
    _result([[[UnifiedRoutePOISearchResult alloc] initWithAMapRoutePOISearchResponse:response] mj_JSONString]);
}

/// 搜索失败回调
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    NSLog(@"搜索失败回调");
    _result([FlutterError errorWithCode:[NSString stringWithFormat:@"%d", error.code]
                                message:[Misc toAMapErrorDesc:error.code]
                                details:nil]);
}

@end

@implementation SearchRoutePoiPolygon {
    AMapSearchAPI *_search;
    FlutterResult _result;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 搜索api回调设置
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }

    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    _result = result;

    NSDictionary *paramDic = call.arguments;

    NSString *query = (NSString *) paramDic[@"query"];

    NSLog(@"方法map#searchRoutePoiLine ios端参数: query -> %@", query);

    UnifiedRoutePoiSearchQuery *request = [UnifiedRoutePoiSearchQuery mj_objectWithKeyValues:query];

    [_search AMapRoutePOISearch:[request toAMapRoutePOISearchRequestPolygon]];
}

/// 沿途搜索回调
- (void)onRoutePOISearchDone:(AMapRoutePOISearchRequest *)request response:(AMapRoutePOISearchResponse *)response {
    NSLog(@"poi搜索回调");
    _result([[[UnifiedRoutePOISearchResult alloc] initWithAMapRoutePOISearchResponse:response] mj_JSONString]);
}

/// 搜索失败回调
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    NSLog(@"搜索失败回调");
    _result([FlutterError errorWithCode:[NSString stringWithFormat:@"%d", error.code]
                                message:[Misc toAMapErrorDesc:error.code]
                                details:nil]);
}

@end

@implementation CalculateDriveRoute {
    RoutePlanParam *_routePlanParam;
    AMapSearchAPI *_search;
    FlutterResult _result;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 搜索api回调设置
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }

    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    _result = result;

    NSDictionary *paramDic = call.arguments;

    NSString *routePlanParamJson = (NSString *) paramDic[@"routePlanParam"];

    NSLog(@"方法calculateDriveRoute ios端参数: routePlanParamJson -> %@", routePlanParamJson);

    _routePlanParam = [RoutePlanParam mj_objectWithKeyValues:routePlanParamJson];

    // 路线请求参数构造
    AMapDrivingRouteSearchRequest *routeQuery = [[AMapDrivingRouteSearchRequest alloc] init];
    routeQuery.origin = _routePlanParam.from;
    routeQuery.destination = _routePlanParam.to;
    routeQuery.strategy = _routePlanParam.mode;
    routeQuery.waypoints = _routePlanParam.passedByPoints;
    routeQuery.avoidpolygons = _routePlanParam.avoidPolygons;
    routeQuery.avoidroad = _routePlanParam.avoidRoad;
    routeQuery.requireExtension = YES;

    [_search AMapDrivingRouteSearch:routeQuery];
}

/// 路径规划搜索回调.
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response {
    if (response.route.paths.count == 0) {
        return _result(@"没有规划出合适的路线");
    }

    _result([[[UnifiedDriveRouteResult alloc] initWithAMapRouteSearchResponse:response] mj_JSONString]);
}

/// 路线规划失败回调
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    if (_result != nil) {
        _result([NSString stringWithFormat:@"路线规划失败, 错误码: %ld", (long) error.code]);
    }
}

@end
