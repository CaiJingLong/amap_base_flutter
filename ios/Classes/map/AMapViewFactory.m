//
// Created by Yohom Bao on 2018/11/25.
//

#import "AMapViewFactory.h"
#import "MAMapView.h"
#import "AMapServices.h"
#import "AMapOptionsLike.h"

@implementation AMapViewFactory {
}

- (NSObject <FlutterMessageCodec> *)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject <FlutterPlatformView> *)createWithFrame:(CGRect)frame
                                     viewIdentifier:(int64_t)viewId
                                          arguments:(id _Nullable)args {
    [AMapServices sharedServices].enableHTTPS = YES;

    JSONModelError *error;
    AMapOptionsLike *options = [[AMapOptionsLike alloc] initWithString:(NSString *) args error:&error];

    NSLog(@"options: %@", options.description);

    return [[AMapView alloc] initWithOptions:options];
}

@end

@implementation AMapView {
    AMapOptionsLike *_options;
}

- (instancetype)initWithOptions:(AMapOptionsLike *)options {
    _options = options;
    return self;
}

- (UIView *)view {
    MAMapView *mapView = [[MAMapView alloc] init];
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
    return mapView;
}

@end