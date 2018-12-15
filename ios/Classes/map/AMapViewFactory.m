//
// Created by Yohom Bao on 2018/11/25.
//

#import "AMapViewFactory.h"
#import "MAMapView.h"
#import "MapModels.h"
#import "AMapBasePlugin.h"
#import "UnifiedAssets.h"
#import "ClearMap.h"
#import "MJExtension.h"
#import "NSString+Color.h"
#import "FunctionRegistry.h"

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
    UnifiedAMapOptions *options = [UnifiedAMapOptions mj_objectWithKeyValues:(NSString *) args];

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
        // 设置delegate, 渲染overlay和annotation的时候需要
        self->_mapView.delegate = self;

        NSObject <MapMethodHandler> *handler = [MapFunctionRegistry mapMethodHandler][call.method];
        if (handler) {
            [[handler initWith:self->_mapView] onMethodCall:call :result];
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
        _sink([annotation.markerOptions mj_JSONString]);
    }
}

/// 渲染overlay回调
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay {
    // 绘制折线
    if ([overlay isKindOfClass:[PolylineOverlay class]]) {
        PolylineOverlay *polyline =(PolylineOverlay *)overlay;

        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:polyline];

        UnifiedPolylineOptions *options = [polyline options];

        polylineRenderer.lineWidth = (CGFloat) (options.width * 0.5); // 相同的值, Android的线比iOS的粗
        polylineRenderer.strokeColor = [options.color hexStringToColor];
        polylineRenderer.lineJoinType = (MALineJoinType) options.lineJoinType;
        polylineRenderer.lineCapType = (MALineCapType) options.lineCapType;
        if (options.isDottedLine) {
            polylineRenderer.lineDashType = (MALineDashType) ((MALineCapType) options.dottedLineType + 1);
        } else {
            polylineRenderer.lineDashType = kMALineDashTypeNone;
        }

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

        if ([annotation isKindOfClass:[MarkerAnnotation class]]) {
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
            annotationView.frame = CGRectMake(annotationView.center.x + size.width / 2, annotationView.center.y, 36, 36);
            annotationView.centerOffset = CGPointMake(0, -18);
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
