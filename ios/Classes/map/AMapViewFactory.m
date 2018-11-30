//
// Created by Yohom Bao on 2018/11/25.
//

#import <AMapSearch/AMapSearchKit/AMapSearchObj.h>
#import <AMapSearch/AMapSearchKit/AMapSearchAPI.h>
#import "AMapViewFactory.h"
#import "MAMapView.h"
#import "UnifiedAMapOptions.h"
#import "AMapBasePlugin.h"
#import "UnifiedMyLocationStyle.h"
#import "UnifiedUiSettings.h"
#import "RoutePlanParam.h"
#import "NSArray+Rx.h"
#import "MANaviAnnotation.h"
#import "MANaviRoute.h"
#import "CommonUtility.h"

static NSString *mapChannelName = @"me.yohom/map";

@implementation AMapViewFactory {
}

- (NSObject <FlutterMessageCodec> *)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject <FlutterPlatformView> *)createWithFrame:(CGRect)frame
                                     viewIdentifier:(int64_t)viewId
                                          arguments:(id _Nullable)args {
    JSONModelError *error;
    UnifiedAMapOptions *options = [[UnifiedAMapOptions alloc] initWithString:(NSString *) args error:&error];

    AMapView *view = [[AMapView alloc] initWithFrame:frame
                                             options:options
                                      viewIdentifier:viewId];
    [view setup];
    return view;
}

@end

@implementation AMapView {
    CGRect _frame;
    int64_t _viewId;
    UnifiedAMapOptions *_options;
    FlutterMethodChannel *_channel;
    MAMapView *_mapView;
    FlutterResult _result;
    AMapSearchAPI *_search;
    MANaviRoute *_overlay;
    RoutePlanParam *_routePlanParam;
}

- (instancetype)initWithFrame:(CGRect)frame
                      options:(UnifiedAMapOptions *)options
               viewIdentifier:(int64_t)viewId {
    if ([super init]) {
        _frame = frame;
        _viewId = viewId;
        _options = options;
    }
    return self;
}

- (UIView *)view {
    _mapView = [[MAMapView alloc] initWithFrame:_frame];
    return _mapView;
}

- (void)setup {

    //region 初始化地图配置, 跟android一样, 不能在view方法里设置, 不然地图会卡住不动, android端是直接把AMapOptions赋值到MapView就可以了
    // 尽可能地统一android端的api了, ios这边的配置选项多很多, 后期再观察吧
    // 因为android端的mapType从1开始, 所以这里减去1
    _mapView.mapType = (MAMapType) (_options.mapType - 1);
    _mapView.showsScale = _options.scaleControlsEnabled;
    _mapView.zoomEnabled = _options.zoomGesturesEnabled;
    _mapView.showsCompass = _options.compassEnabled;
    _mapView.scrollEnabled = _options.scrollGesturesEnabled;
    _mapView.cameraDegree = _options.camera.tilt;
    _mapView.rotateEnabled = _options.rotateGesturesEnabled;
    _mapView.centerCoordinate = (CLLocationCoordinate2D) {_options.camera.target.latitude, _options.camera.target.longitude};
    _mapView.zoomLevel = _options.camera.zoom;
    // fixme: logo位置设置无效
    CGPoint logoPosition = CGPointMake(0, _mapView.bounds.size.height);
    if (_options.logoPosition == 0) { // 左下角
        logoPosition = CGPointMake(0, _mapView.bounds.size.height);
    } else if (_options.logoPosition == 1) { // 底部中央
        logoPosition = CGPointMake(_mapView.bounds.size.width / 2, _mapView.bounds.size.height);
    } else if (_options.logoPosition == 2) { // 底部右侧
        logoPosition = CGPointMake(_mapView.bounds.size.width, _mapView.bounds.size.height);
    }
    _mapView.logoCenter = logoPosition;
    //endregion

    _channel = [FlutterMethodChannel methodChannelWithName:[NSString stringWithFormat:@"%@%lld", mapChannelName, _viewId]
                                           binaryMessenger:[AMapBasePlugin registrar].messenger];
    __weak __typeof__(self) weakSelf = self;
    [_channel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        _result = result;
        if (weakSelf) {
            [weakSelf handleMethodCall:call result:result];
        }
    }];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;
    if ([@"map#setMyLocationStyle" isEqualToString:call.method]) {
        NSString *styleJson = (NSString *) paramDic[@"myLocationStyle"];

        NSLog(@"方法setMyLocationStyle ios端参数: styleJson -> %@", styleJson);
        JSONModelError *error;
        [[[UnifiedMyLocationStyle alloc] initWithString:styleJson error:&error] applyTo:_mapView];

        NSLog(@"JSONModelError: %@", error.description);
    } else if ([@"map#setUiSettings" isEqualToString:call.method]) {
        NSString *uiSettingsJson = (NSString *) paramDic[@"uiSettings"];

        NSLog(@"方法setUiSettings ios端参数: uiSettingsJson -> %@", uiSettingsJson);
        JSONModelError *error;
        [[[UnifiedUiSettings alloc] initWithString:uiSettingsJson error:&error] applyTo:_mapView];

        NSLog(@"JSONModelError: %@", error.description);
    } else if ([@"map#calculateDriveRoute" isEqualToString:call.method]) {
        NSString *routePlanParamJson = (NSString *) paramDic[@"routePlanParam"];

        NSLog(@"方法calculateDriveRoute ios端参数: routePlanParamJson -> %@", routePlanParamJson);
        JSONModelError *error;
        _routePlanParam = [[RoutePlanParam alloc] initWithString:routePlanParamJson error:&error];
        NSLog(@"JSONModelError: %@", error.description);

        // 设置delegate, 渲染overlay和annotation的时候需要
        _mapView.delegate = self;

        // 开始搜索路线
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;

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

        NSLog(@"AMapDrivingRouteSearchRequest: %@", routeQuery.formattedDescription);
        [_search AMapDrivingRouteSearch:routeQuery];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

/* 路径规划搜索回调. */
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response {
    if (response.route.paths.count == 0) {
        return _result(@"没有规划出合适的路线");
    }

    AMapPath *path = response.route.paths[0];
    _overlay = [MANaviRoute naviRouteForPath:path
                                withNaviType:MANaviAnnotationTypeDrive
                                 showTraffic:YES
                                  startPoint:[AMapGeoPoint locationWithLatitude:_routePlanParam.from.latitude
                                                                      longitude:_routePlanParam.from.longitude]
                                    endPoint:[AMapGeoPoint locationWithLatitude:_routePlanParam.to.latitude
                                                                      longitude:_routePlanParam.to.longitude]];
    [_overlay addToMapView:_mapView];

    [_mapView setVisibleMapRect:[CommonUtility mapRectForOverlays:_overlay.routePolylines]
                    edgePadding:UIEdgeInsetsMake(20, 20, 20, 20)
                       animated:YES];
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    if (_result != nil) {
        _result([NSString stringWithFormat:@"路线规划失败, 错误码: %d", error.code]);
    }
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay {
    if ([overlay isKindOfClass:[LineDashPolyline class]]) {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *) overlay).polyline];
        polylineRenderer.lineWidth = 8;
        polylineRenderer.lineDashType = kMALineDashTypeSquare;
        polylineRenderer.strokeColor = [UIColor redColor];

        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MANaviPolyline class]]) {
        MANaviPolyline *naviPolyline = (MANaviPolyline *) overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];

        polylineRenderer.lineWidth = 8;

        if (naviPolyline.type == MANaviAnnotationTypeWalking) {
            polylineRenderer.strokeColor = _overlay.walkingColor;
        } else if (naviPolyline.type == MANaviAnnotationTypeRailway) {
            polylineRenderer.strokeColor = _overlay.railwayColor;
        } else {
            polylineRenderer.strokeColor = _overlay.routeColor;
        }

        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MAMultiPolyline class]]) {
        MAMultiColoredPolylineRenderer *polylineRenderer = [[MAMultiColoredPolylineRenderer alloc] initWithMultiPolyline:overlay];

        polylineRenderer.lineWidth = 10;
        polylineRenderer.strokeColors = [_overlay.multiPolylineColors copy];

        return polylineRenderer;
    }

    return nil;
}
@end
