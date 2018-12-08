//
// Created by Yohom Bao on 2018-12-07.
//

#import "ClearMap.h"
#import "AMapSearchKit.h"
#import "AMapViewFactory.h"


@implementation ClearMap {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    [_mapView removeOverlays:_mapView.overlays];
    [_mapView removeAnnotations:_mapView.annotations];

    result(success);
}

@end