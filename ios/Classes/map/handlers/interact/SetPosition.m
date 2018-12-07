//
// Created by Yohom Bao on 2018-12-07.
//

#import <AMap3DMap/MAMapKit/MAMapView.h>
#import "SetPosition.h"
#import "JSONModelError.h"
#import "UnifiedAMapOptions.h"
#import "AMapSearchKit.h"
#import "AMapViewFactory.h"


@implementation SetPosition {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)with:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    NSString *target = (NSString *) paramDic[@"target"];
    CGFloat zoom = [paramDic[@"zoom"] floatValue];
    CGFloat tilt = [paramDic[@"tilt"] floatValue];

    JSONModelError *error;
    LatLng *position = [[LatLng alloc] initWithString:target error:&error];

    [_mapView setCenterCoordinate:[position toCLLocationCoordinate2D] animated:true];
    _mapView.zoomLevel = zoom;
    _mapView.rotationDegree = tilt;

    result(success);
}

@end