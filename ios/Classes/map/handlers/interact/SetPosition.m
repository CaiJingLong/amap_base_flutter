//
// Created by Yohom Bao on 2018-12-07.
//

#import "SetPosition.h"
#import "UnifiedAMapOptions.h"
#import "AMapSearchKit.h"
#import "AMapViewFactory.h"
#import "MJExtension.h"


@implementation SetPosition {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    NSString *target = (NSString *) paramDic[@"target"];
    CGFloat zoom = [paramDic[@"zoom"] floatValue];
    CGFloat tilt = [paramDic[@"tilt"] floatValue];

    LatLng *position = [LatLng mj_objectWithKeyValues:target];

    [_mapView setCenterCoordinate:[position toCLLocationCoordinate2D] animated:true];
    _mapView.zoomLevel = zoom;
    _mapView.rotationDegree = tilt;

    result(success);
}

@end
