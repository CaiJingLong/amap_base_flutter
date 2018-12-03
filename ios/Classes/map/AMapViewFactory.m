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
#import "UnifiedAssets.h"
#import "UnifiedMarkerOptions.h"
#import "MarkerAnnotation.h"
#import "MarkerAnnotation.h"
#import "UnifiedAMapPOIKeywordsSearchRequest.h"
#import "UnifiedPoiResult.h"

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
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //endregion

    _channel = [FlutterMethodChannel methodChannelWithName:[NSString stringWithFormat:@"%@%lld", mapChannelName, _viewId]
                                           binaryMessenger:[AMapBasePlugin registrar].messenger];
    __weak __typeof__(self) weakSelf = self;
    [_channel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        self->_result = result;
        if (weakSelf) {
            [weakSelf handleMethodCall:call result:result];
        }
    }];

    // 搜索api回调设置
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    // 设置delegate, 渲染overlay和annotation的时候需要
    _mapView.delegate = self;

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
    } else if ([@"marker#addMarker" isEqualToString:call.method]) {
        NSString *optionsJson = (NSString *) paramDic[@"markerOptions"];

        NSLog(@"方法marker#addMarker ios端参数: optionsJson -> %@", optionsJson);
        JSONModelError *error;
        UnifiedMarkerOptions *markerOptions = [[UnifiedMarkerOptions alloc] initWithString:optionsJson error:&error];
        NSLog(@"JSONModelError: %@", error.description);

        MarkerAnnotation *annotation = [[MarkerAnnotation alloc] init];
        annotation.coordinate = [markerOptions.position toCLLocationCoordinate2D];
        annotation.title = markerOptions.title;
        annotation.subtitle = markerOptions.snippet;
        annotation.markerOptions = markerOptions;

        [_mapView addAnnotation:annotation];
    } else if ([@"marker#addMarkers" isEqualToString:call.method]) {
        NSString *moveToCenter = (NSString *) paramDic[@"moveToCenter"];
        NSString *optionsListJson = (NSString *) paramDic[@"markerOptionsList"];
        NSString *clear = (BOOL) paramDic[@"clear"];

        NSLog(@"方法marker#addMarkers ios端参数: optionsListJson -> %@", optionsListJson);
        if (clear) [_mapView removeAnnotations:_mapView.annotations];

        NSArray *rawOptionsList = [NSJSONSerialization JSONObjectWithData:[optionsListJson dataUsingEncoding:NSUTF8StringEncoding]
                                                                  options:kNilOptions
                                                                    error:nil];
        NSMutableArray<MarkerAnnotation *> *optionList = [NSMutableArray array];

        for (NSUInteger i = 0; i < rawOptionsList.count; ++i) {
            JSONModelError *error;

            UnifiedMarkerOptions *options = [[UnifiedMarkerOptions alloc] initWithDictionary:rawOptionsList[i] error:&error];
            MarkerAnnotation *annotation = [[MarkerAnnotation alloc] init];
            annotation.coordinate = [options.position toCLLocationCoordinate2D];
            annotation.title = options.title;
            annotation.subtitle = options.snippet;
            annotation.markerOptions = options;

            NSLog(@"JSONModelError: %@", error.description);
            [optionList addObject:annotation];
        }

        [_mapView addAnnotations:optionList];
        if (moveToCenter) {
            [_mapView showAnnotations:optionList animated:YES];
        }
    } else if ([@"map#showIndoorMap" isEqualToString:call.method]) {
        BOOL enabled = (BOOL) paramDic[@"showIndoorMap"];

        NSLog(@"方法map#showIndoorMap android端参数: enabled -> %d", enabled);

        _mapView.showsIndoorMap = enabled;
    } else if ([@"map#setMapType" isEqualToString:call.method]) {
        // 由于iOS端是从0开始算的, 所以这里减去1
        NSInteger mapType = (NSInteger) paramDic[@"mapType"] - 1;

        NSLog(@"方法map#setMapType ios端参数: mapType -> %d", mapType);

        [_mapView setMapType:mapType];
    } else if ([@"map#setLanguage" isEqualToString:call.method]) {
        // 由于iOS端是从0开始算的, 所以这里减去1
        NSString *language = (NSString *) paramDic[@"language"];

        NSLog(@"方法map#setLanguage ios端参数: language -> %@", language);

        [_mapView performSelector:NSSelectorFromString(@"setMapLanguage:") withObject:language];
    } else if ([@"map#searchPoi" isEqualToString:call.method]) {
        NSString *query = (NSString *) paramDic[@"query"];

        NSLog(@"方法map#searchPoi ios端参数: query -> %@", query);

        JSONModelError *error;
        UnifiedAMapPOIKeywordsSearchRequest *request = [[UnifiedAMapPOIKeywordsSearchRequest alloc] initWithString:query error:&error];
        NSLog(@"JSONModelError: %@", error.description);

        [_search AMapPOIKeywordsSearch:[request toAMapPOIKeywordsSearchRequest]];
    } else if ([@"marker#clear" isEqualToString:call.method]) {
        [_mapView removeAnnotations:_mapView.annotations];
    } else if ([@"map#clear" isEqualToString:call.method]) {
        [_mapView removeOverlays:_mapView.overlays];
        [_mapView removeAnnotations:_mapView.annotations];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

#pragma AMapSearchDelegate

/* 路径规划搜索回调. */
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

    UnifiedPoiResult *resultPoi = [[UnifiedPoiResult alloc] initWithPoiResult:response];
    NSString *resultString = [resultPoi toJSONString];
    NSLog(@"RESULT: %@", resultString);
    _result([[[UnifiedPoiResult alloc] initWithPoiResult:response] toJSONString]);
}

#pragma MAMapViewDelegate

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
                    annotationView.image = [UIImage imageWithContentsOfFile:[UnifiedAssets getAssetPath:@"images/railway_station.png"]];
                    break;
                case MANaviAnnotationTypeBus:
                    annotationView.image = [UIImage imageWithContentsOfFile:[UnifiedAssets getAssetPath:@"images/bus.png"]];
                    break;
                case MANaviAnnotationTypeDrive:
                    annotationView.image = [UIImage imageWithContentsOfFile:[UnifiedAssets getAssetPath:@"images/car.png"]];
                    break;
                case MANaviAnnotationTypeWalking:
                    annotationView.image = [UIImage imageWithContentsOfFile:[UnifiedAssets getAssetPath:@"images/man.png"]];
                    break;
                default:
                    break;
            }
        } else if ([annotation isKindOfClass:[MarkerAnnotation class]]) {
            UnifiedMarkerOptions *options = ((MarkerAnnotation *) annotation).markerOptions;
            annotationView.zIndex = (NSInteger) options.zIndex;
            if (options.icon != nil) {
                annotationView.image = [UIImage imageWithContentsOfFile:[UnifiedAssets getAssetPath:options.icon]];
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
                annotationView.image = [UIImage imageWithContentsOfFile:[UnifiedAssets getAssetPath:@"images/amap_start.png"]];
            } else if ([[annotation title] isEqualToString:@"终点"]) {
                annotationView.image = [UIImage imageWithContentsOfFile:[UnifiedAssets getAssetPath:@"images/amap_end.png"]];
            }
        }

        if (annotationView.imageView != nil) {
            CGSize size = annotationView.imageView.frame.size;
            annotationView.frame = CGRectMake(annotationView.center.x + size.width / 2, annotationView.center.y, 36, 36);
            annotationView.centerOffset = CGPointMake(0, -18);
        }

        return annotationView;
    }

    return nil;
}

@end
