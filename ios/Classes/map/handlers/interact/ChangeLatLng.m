//
// Created by Yohom Bao on 2018-12-13.
//

#import "MAMapView.h"
#import "ChangeLatLng.h"
#import "MapModels.h"
#import "MJExtension.h"
#import "AMapViewFactory.h"


@implementation ChangeLatLng {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    NSString *targetJson = (NSString *) paramDic[@"target"];

    LatLng *target = [LatLng mj_objectWithKeyValues:targetJson];

    [_mapView setCenterCoordinate:[target toCLLocationCoordinate2D] animated:YES];

    result(success);
}

@end