//
// Created by Yohom Bao on 2018-12-07.
//

#import "IMethodHandler.h"
#import "CalculateDriveRoute.h"
#import "RoutePlanParam.h"
#import "UnifiedAMapOptions.h"
#import "NSArray+Rx.h"
#import "MAPointAnnotation.h"
#import "MANaviRoute.h"
#import "AMapViewFactory.h"
#import "MJExtension.h"


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
    routeQuery.origin = [_routePlanParam.from toAMapGeoPoint];
    routeQuery.destination = [_routePlanParam.to toAMapGeoPoint];
    routeQuery.strategy = _routePlanParam.mode;
    routeQuery.waypoints = [_routePlanParam.passedByPoints map:^(id it) {
        return [it toAMapGeoPoint];
    }];
    routeQuery.avoidpolygons = [_routePlanParam.avoidPolygons map:^(id list) {
        return [list map:^(id it) {
            return [it toAMapGeoPoint];
        }];
    }];
    routeQuery.avoidroad = _routePlanParam.avoidRoad;
    routeQuery.requireExtension = YES;

    [_search AMapDrivingRouteSearch:routeQuery];
}

/// 路径规划搜索回调.
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response {
    if (response.route.paths.count == 0) {
        return _result(@"没有规划出合适的路线");
    }

    // 添加起终点
    MAPointAnnotation *startAnnotation = [[MAPointAnnotation alloc] init];
    startAnnotation.coordinate = [_routePlanParam.from toCLLocationCoordinate2D];
    startAnnotation.title = @"起点";

    MAPointAnnotation *destinationAnnotation = [[MAPointAnnotation alloc] init];
    destinationAnnotation.coordinate = [_routePlanParam.to toCLLocationCoordinate2D];
    destinationAnnotation.title = @"终点";

//    [_mapView addAnnotation:startAnnotation];
//    [_mapView addAnnotation:destinationAnnotation];
//
//    // 添加中间的路径
//    AMapPath *path = response.route.paths[0];
//    _overlay = [MANaviRoute naviRouteForPath:path
//                                withNaviType:MANaviAnnotationTypeDrive
//                                 showTraffic:YES
//                                  startPoint:[_routePlanParam.from toAMapGeoPoint]
//                                    endPoint:[_routePlanParam.to toAMapGeoPoint]];
//    [_overlay addToMapView:_mapView];
//
//    // 收缩地图到路径范围
//    [_mapView setVisibleMapRect:[Misc mapRectForOverlays:_overlay.routePolylines]
//                    edgePadding:UIEdgeInsetsMake(20, 20, 20, 20)
//                       animated:YES];

    _result(success);
}

/// 路线规划失败回调
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    if (_result != nil) {
        _result([NSString stringWithFormat:@"路线规划失败, 错误码: %ld", (long) error.code]);
    }
}

@end
