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
#import "Misc.h"
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
#import "SearchPoiKeyword.h"
#import "SearchPoiBound.h"
#import "SearchPoiPolygon.h"
#import "SearchPoiId.h"
#import "SearchRoutePoiLine.h"
#import "SearchRoutePoiPolygon.h"
#import "ClearMarker.h"
#import "SetZoomLevel.h"
#import "SetPosition.h"
#import "SetMapStatusLimits.h"
#import "SetUiSettings.h"
#import "MapFunctionRegistry.h"

static NSString *mapChannelName = @"me.yohom/map";
static NSString *markerClickedChannelName = @"me.yohom/marker_clicked";

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
    FlutterMethodChannel *_methodChannel;
    FlutterEventChannel *_markerClickedEventChannel;
    FlutterEventSink _sink;
    MAMapView *_mapView;
    MANaviRoute *_overlay;
}

- (instancetype)initWithFrame:(CGRect)frame
                      options:(UnifiedAMapOptions *)options
               viewIdentifier:(int64_t)viewId {
    self = [super init];
    if (self) {
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
    // 设置delegate, 渲染overlay和annotation的时候需要
    _mapView.delegate = self;

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
    [_methodChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        NSObject <MapMethodHandler> *handler = [MapFunctionRegistry mapMethodHandler][call.method];
        if (handler) {
            [[handler initWith:_mapView] onMethodCall:call :result];
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];

    _markerClickedEventChannel = [FlutterEventChannel eventChannelWithName:[NSString stringWithFormat:@"%@%lld", markerClickedChannelName, _viewId]
                                                           binaryMessenger:[AMapBasePlugin registrar].messenger];
    [_markerClickedEventChannel setStreamHandler:self];
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
