//
// Created by Yohom Bao on 2018-12-13.
//

#import "ZoomToSpan.h"
#import "UnifiedAMapOptions.h"
#import "MJExtension.h"
#import "Misc.h"


@implementation ZoomToSpan {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    NSString *boundJson = (NSString *) paramDic[@"bound"];

    NSArray <LatLng *> *latLngArray = [LatLng mj_objectArrayWithKeyValuesArray:boundJson];

    NSUInteger count = latLngArray.count;

    CLLocationCoordinate2D commonPolylineCoords[count];
    for (NSUInteger i = 0; i < count; ++i) {
        commonPolylineCoords[i] = [latLngArray[i] toCLLocationCoordinate2D];
    }

    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:count];
    [_mapView showOverlays:@[polyline] edgePadding:UIEdgeInsetsMake(50, 50, 50, 50) animated:YES];
}

@end