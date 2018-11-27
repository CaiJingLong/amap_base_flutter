//
// Created by Yohom Bao on 2018/11/25.
//

#import "AMapViewFactory.h"
#import "MAMapView.h"
#import "AMapServices.h"
#import "AMapOptions.h"
#import "AmapBasePlugin.h"

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
    AMapOptions *options = [[AMapOptions alloc] initWithString:(NSString *) args error:&error];

    AMapView *view = [[AMapView alloc] initWithFrame:frame options:options viewIdentifier:viewId];
    [view setup];
    return view;
}

@end

@implementation AMapView {
    CGRect _frame;
    int64_t _viewId;
    AMapOptions *_options;
    FlutterMethodChannel *_channel;
}

- (instancetype)initWithFrame:(CGRect)frame
                      options:(AMapOptions *)options
               viewIdentifier:(int64_t)viewId {
    if ([super init]) {
        _frame = frame;
        _viewId = viewId;
        _options = options;
    }
    return self;
}

- (void)setup {
    [self setupMapChannel];
}

- (void)setupMapChannel {
    _channel = [FlutterMethodChannel methodChannelWithName:[NSString stringWithFormat:@"%@%lld", mapChannelName, _viewId]
                                           binaryMessenger:[AmapBasePlugin registrar].messenger];
    __weak __typeof__(self) weakSelf = self;
    [_channel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        if (weakSelf) {
//            [weakSelf onMethodCall:call result:result];
        }
    }];
}

- (UIView *)view {
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:_frame];
    // 尽可能地统一android端的api了, ios这边的配置选项多很多, 后期再观察吧
    // 因为android端的mapType从1开始, 所以这里减去1
    mapView.mapType = (MAMapType) (_options.mapType - 1);
    mapView.showsScale = _options.scaleControlsEnabled;
    mapView.zoomEnabled = _options.zoomControlsEnabled || _options.zoomGesturesEnabled;
    mapView.showsCompass = _options.compassEnabled;
    mapView.scrollEnabled = _options.scrollGesturesEnabled;
    mapView.cameraDegree = _options.camera.tilt;
    mapView.rotateEnabled = _options.rotateGesturesEnabled;
    mapView.centerCoordinate = (CLLocationCoordinate2D) {_options.camera.target.latitude, _options.camera.target.longitude};
    mapView.zoomLevel = _options.camera.zoom;
    // fixme: logo位置设置无效
    CGPoint logoPosition = CGPointMake(0, mapView.bounds.size.height);
    if (_options.logoPosition == 0) { // 左下角
        logoPosition = CGPointMake(0, mapView.bounds.size.height);
    } else if (_options.logoPosition == 1) { // 底部中央
        logoPosition = CGPointMake(mapView.bounds.size.width / 2, mapView.bounds.size.height);
    } else if (_options.logoPosition == 2) { // 底部右侧
        logoPosition = CGPointMake(mapView.bounds.size.width, mapView.bounds.size.height);
    }
    mapView.logoCenter = logoPosition;
    return mapView;
}

@end