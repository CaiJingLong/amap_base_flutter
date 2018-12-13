//
// Created by Yohom Bao on 2018-12-07.
//

#import "IMethodHandler.h"
#import "CalculateDriveRoute.h"
#import "RoutePlanParam.h"
#import "UnifiedAMapOptions.h"
#import "NSArray+Rx.h"
#import "MAPointAnnotation.h"
#import "AMapViewFactory.h"
#import "MJExtension.h"
#import "UnifiedDriveRouteResult.h"


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
