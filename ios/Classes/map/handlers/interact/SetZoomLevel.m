//
// Created by Yohom Bao on 2018-12-07.
//

#import <AMap3DMap/MAMapKit/MAMapView.h>
#import "SetZoomLevel.h"
#import "AMapSearchKit.h"
#import "AMapViewFactory.h"


@implementation SetZoomLevel {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)with:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    CGFloat zoomLevel = [paramDic[@"zoomLevel"] floatValue];

    _mapView.zoomLevel = zoomLevel;

    result(success);
}

@end