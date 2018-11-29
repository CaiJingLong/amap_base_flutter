//
// Created by Yohom Bao on 2018/11/25.
//

#import "AMapViewFactory.h"
#import "MAMapView.h"
#import "UnifiedAMapOptions.h"
#import "AMapBasePlugin.h"
#import "UnifiedMyLocationStyle.h"
#import "UnifiedUiSettings.h"

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
        if (weakSelf) {
            [weakSelf handleMethodCall:call result:result];
        }
    }];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;
    if ([@"map#setMyLocationEnabled" isEqualToString:call.method]) {
        BOOL enabled = (BOOL) paramDic[@"enabled"];
        NSString *styleJson = (NSString *) paramDic[@"myLocationStyle"];
        
        NSLog(@"方法setMyLocationEnabled ios端参数: enabled -> %d, styleJson -> %@", enabled, styleJson);
        JSONModelError *error;
        UnifiedMyLocationStyle *style = [[UnifiedMyLocationStyle alloc] initWithString:styleJson error:&error];
        
        NSLog(@"JSONModelError: %@", error.description);
        NSLog(@"UnifiedMyLocationStyle: %@", style.description);
        _mapView.showsUserLocation = style.showMyLocation;
        if (_mapView.showsUserLocation) {
            _mapView.userTrackingMode = MAUserTrackingModeFollow;
        }
        [_mapView updateUserLocationRepresentation:[style toMAUserLocationRepresentation]];
    } else if ([@"map#setUiSettings" isEqualToString:call.method]) {
        NSString *uiSettingsJson = (NSString *) paramDic[@"uiSettings"];
        
        NSLog(@"方法setUiSettings ios端参数: _uiSettings -> %@", uiSettingsJson);
        JSONModelError *error;
        [[[UnifiedUiSettings alloc] initWithString:uiSettingsJson error:&error] applyTo:_mapView];
        
        NSLog(@"JSONModelError: %@", error.description);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (UIView *)view {
    _mapView = [[MAMapView alloc] initWithFrame:_frame];
    return _mapView;
}

@end
