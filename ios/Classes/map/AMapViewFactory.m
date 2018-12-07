//
// Created by Yohom Bao on 2018/11/25.
//

#import <AMapSearch/AMapSearchKit/AMapSearchObj.h>
#import <AMapSearch/AMapSearchKit/AMapSearchAPI.h>
#import <Foundation/Foundation.h>
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
#import "UnifiedAssets.h"
#import "UnifiedMarkerOptions.h"
#import "MarkerAnnotation.h"
#import "MarkerAnnotation.h"
#import "UnifiedPoiSearchQuery.h"
#import "UnifiedPoiResult.h"
#import "UnifiedRoutePoiSearchQuery.h"
#import "UnifiedRoutePOISearchResult.h"
#import "NSObject+Permission.h"
#import "ClearMap.h"
#import "SetMyLocationStyle.h"
#import "CalculateDriveRoute.h"
#import "AddMarker.h"
#import "AddMarkers.h"
#import "ShowIndoorMap.h"
#import "SetMapType.h"
#import "SetLanguage.h"
#import "SearchPoi.h"
#import "SearchPoiBound.h"
#import "SearchPoiPolygon.h"
#import "SearchPoiId.h"
#import "SearchRoutePoiLine.h"
#import "SearchRoutePoiPolygon.h"
#import "ClearMarker.h"
#import "SetZoomLevel.h"
#import "SetPosition.h"
#import "SetMapStatusLimits.h"

static NSString *mapChannelName = @"me.yohom/map";
static NSString *markerClickedChannelName = @"me.yohom/marker_clicked";

NSDictionary<NSString *, NSObject <MapMethodHandler> *> *MAP_METHOD_HANDLER;

@implementation AMapViewFactory {
}

- (NSObject <FlutterMessageCodec> *)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject <FlutterPlatformView> *)createWithFrame:(CGRect)frame
                                     viewIdentifier:(int64_t)viewId
                                          arguments:(id _Nullable)args {
    // 发现加了也只会在第一次才会请求, 后续就不会再请求了, 就用系统的请求对话框吧
//    [self checkPermission];

    MAP_METHOD_HANDLER = @{
            @"map#clear": [[ClearMap alloc] init],
            @"map#setMyLocationStyle": [[SetMyLocationStyle alloc] init],
            @"map#calculateDriveRoute": [[CalculateDriveRoute alloc] init],
            @"marker#addMarker": [[AddMarker alloc] init],
            @"marker#addMarkers": [[AddMarkers alloc] init],
            @"map#showIndoorMap": [[ShowIndoorMap alloc] init],
            @"map#setMapType": [[SetMapType alloc] init],
            @"map#setLanguage": [[SetLanguage alloc] init],
            @"map#searchPoi": [[SearchPoi alloc] init],
            @"map#searchPoiBound": [[SearchPoiBound alloc] init],
            @"map#searchPoiPolygon": [[SearchPoiPolygon alloc] init],
            @"map#searchPoiId": [[SearchPoiId alloc] init],
            @"map#searchRoutePoiLine": [[SearchRoutePoiLine alloc] init],
            @"map#searchRoutePoiPolygon": [[SearchRoutePoiPolygon alloc] init],
            @"marker#clear": [[ClearMarker alloc] init],
            @"map#setZoomLevel": [[SetZoomLevel alloc] init],
            @"map#setPosition": [[SetPosition alloc] init],
            @"map#setMapStatusLimits": [[SetMapStatusLimits alloc] init],
    };

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
    FlutterMethodChannel *_methodChannel;
    FlutterEventChannel *_markerClickedEventChannel;
    FlutterEventSink _sink;
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
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //endregion

    _methodChannel = [FlutterMethodChannel methodChannelWithName:[NSString stringWithFormat:@"%@%lld", mapChannelName, _viewId]
                                                 binaryMessenger:[AMapBasePlugin registrar].messenger];
    __weak __typeof__(self) weakSelf = self;
    [_methodChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        self->_result = result;
        if (weakSelf) {
            [weakSelf handleMethodCall:call result:result];
        }
    }];

    _markerClickedEventChannel = [FlutterEventChannel eventChannelWithName:[NSString stringWithFormat:@"%@%lld", markerClickedChannelName, _viewId]
                                                           binaryMessenger:[AMapBasePlugin registrar].messenger];
    [_markerClickedEventChannel setStreamHandler:self];

    // 搜索api回调设置
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    // 设置delegate, 渲染overlay和annotation的时候需要
    _mapView.delegate = self;

    NSObject <MapMethodHandler> *handler = MAP_METHOD_HANDLER[call.method];
    if (handler) {
        [[handler with:_mapView] onMethodCall:call :result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

#pragma AMapSearchDelegate

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

    [_mapView addAnnotation:startAnnotation];
    [_mapView addAnnotation:destinationAnnotation];

    // 添加中间的路径
    AMapPath *path = response.route.paths[0];
    _overlay = [MANaviRoute naviRouteForPath:path
                                withNaviType:MANaviAnnotationTypeDrive
                                 showTraffic:YES
                                  startPoint:[AMapGeoPoint locationWithLatitude:_routePlanParam.from.latitude
                                                                      longitude:_routePlanParam.from.longitude]
                                    endPoint:[AMapGeoPoint locationWithLatitude:_routePlanParam.to.latitude
                                                                      longitude:_routePlanParam.to.longitude]];
    [_overlay addToMapView:_mapView];

    // 收缩地图到路径范围
    [_mapView setVisibleMapRect:[CommonUtility mapRectForOverlays:_overlay.routePolylines]
                    edgePadding:UIEdgeInsetsMake(20, 20, 20, 20)
                       animated:YES];

    _result(success);
}

/// 路线规划失败回调
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    if (_result != nil) {
        _result([NSString stringWithFormat:@"路线规划失败, 错误码: %ld", (long) error.code]);
    }
}

/// poi搜索回调
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    if (response.pois.count == 0) {
        return;
    }

    _result([[[UnifiedPoiResult alloc] initWithPoiResult:response] toJSONString]);
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

#pragma MAMapViewDelegate

/// 点击annotation回调
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    if ([view.annotation isKindOfClass:[MarkerAnnotation class]]) {
        MarkerAnnotation *annotation = (MarkerAnnotation *) view.annotation;
        _sink([annotation.markerOptions toJSONString]);
    }
}

/// 渲染overlay回调
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

/// 渲染annotation, 就是Android中的marker
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        return nil;
    }

    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *routePlanningCellIdentifier = @"RoutePlanningCellIdentifier";

        MAAnnotationView *annotationView = [_mapView dequeueReusableAnnotationViewWithIdentifier:routePlanningCellIdentifier];
        if (annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:routePlanningCellIdentifier];
        }

        if ([annotation isKindOfClass:[MANaviAnnotation class]]) {
            switch (((MANaviAnnotation *) annotation).type) {
                case MANaviAnnotationTypeRailway:
                    annotationView.image = [UIImage imageWithContentsOfFile:[UnifiedAssets getDefaultAssetPath:@"images/railway_station.png"]];
                    break;
                case MANaviAnnotationTypeBus:
                    annotationView.image = [UIImage imageWithContentsOfFile:[UnifiedAssets getDefaultAssetPath:@"images/bus.png"]];
                    break;
                case MANaviAnnotationTypeDrive:
                    annotationView.image = [UIImage imageWithContentsOfFile:[UnifiedAssets getDefaultAssetPath:@"images/car.png"]];
                    break;
                case MANaviAnnotationTypeWalking:
                    annotationView.image = [UIImage imageWithContentsOfFile:[UnifiedAssets getDefaultAssetPath:@"images/man.png"]];
                    break;
                default:
                    break;
            }
        } else if ([annotation isKindOfClass:[MarkerAnnotation class]]) {
            UnifiedMarkerOptions *options = ((MarkerAnnotation *) annotation).markerOptions;
            annotationView.zIndex = (NSInteger) options.zIndex;
            if (options.icon != nil) {
                annotationView.image = [UIImage imageWithContentsOfFile:[UnifiedAssets getAssetPath:options.icon]];
            } else {
                annotationView.image = [UIImage imageWithContentsOfFile:[UnifiedAssets getDefaultAssetPath:@"images/default_marker.png"]];
            }
            annotationView.centerOffset = CGPointMake(options.anchorU, options.anchorV);
            annotationView.calloutOffset = CGPointMake(options.infoWindowOffsetX, options.infoWindowOffsetY);
            annotationView.draggable = options.draggable;
            annotationView.canShowCallout = options.infoWindowEnable;
            annotationView.enabled = options.enabled;
            annotationView.highlighted = options.highlighted;
            annotationView.selected = options.selected;
        } else {
            if ([[annotation title] isEqualToString:@"起点"]) {
                annotationView.image = [UIImage imageWithContentsOfFile:[UnifiedAssets getDefaultAssetPath:@"images/amap_start.png"]];
            } else if ([[annotation title] isEqualToString:@"终点"]) {
                annotationView.image = [UIImage imageWithContentsOfFile:[UnifiedAssets getDefaultAssetPath:@"images/amap_end.png"]];
            }
        }

        if (annotationView.image != nil) {
            CGSize size = annotationView.imageView.frame.size;
            annotationView.frame = CGRectMake(annotationView.center.x + size.width / 2, annotationView.center.y, 24, 24);
            annotationView.centerOffset = CGPointMake(0, -12);
        }

        return annotationView;
    }

    return nil;
}

#pragma FlutterStreamHandler

- (FlutterError *_Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(FlutterEventSink)events {
    _sink = events;
    return nil;
}

- (FlutterError *_Nullable)onCancelWithArguments:(id _Nullable)arguments {
    return nil;
}


@end
