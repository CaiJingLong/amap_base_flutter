//
// Created by Yohom Bao on 2018-12-10.
//

#import "AddPolyline.h"
#import "UnifiedPolylineOptions.h"
#import "MJExtension.h"
#import "UnifiedAMapOptions.h"
#import "PolylineOverlay.h"
#import "AMapViewFactory.h"


@implementation AddPolyline {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSString *optionsJson = (NSString *) call.arguments[@"options"];

    NSLog(@"map#addPolyline ios端参数: optionsJson -> %@", optionsJson);

    UnifiedPolylineOptions *options = [UnifiedPolylineOptions initWithJson:optionsJson];

    NSUInteger count = options.latLngList.count;

    CLLocationCoordinate2D commonPolylineCoords[count];
    for (NSUInteger i = 0; i < count; ++i) {
        commonPolylineCoords[i] = [options.latLngList[i] toCLLocationCoordinate2D];
    }

    PolylineOverlay *polyline = [PolylineOverlay polylineWithCoordinates:commonPolylineCoords count:options.latLngList.count];
    polyline.options = options;
    [_mapView addOverlay:polyline];

    result(success);
}

@end
