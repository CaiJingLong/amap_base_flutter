//
// Created by Yohom Bao on 2018-12-07.
//

#import <AMap3DMap/MAMapKit/MAMapView.h>
#import "SetMapStatusLimits.h"
#import "JSONModelError.h"
#import "UnifiedAMapOptions.h"
#import "MAGeometry.h"
#import "AMapSearchKit.h"
#import "AMapViewFactory.h"


@implementation SetMapStatusLimits {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    NSString *center = (NSString *) paramDic[@"center"];
    CGFloat deltaLat = [paramDic[@"deltaLat"] floatValue];
    CGFloat deltaLng = [paramDic[@"deltaLng"] floatValue];

    NSLog(@"方法map#setMapStatusLimits ios端参数: center -> %@, deltaLat -> %f, deltaLng -> %f", center, deltaLat, deltaLng);

    JSONModelError *error;
    LatLng *centerPosition = [[LatLng alloc] initWithString:center error:&error];

    [_mapView setLimitRegion:MACoordinateRegionMake(
            [centerPosition toCLLocationCoordinate2D],
            MACoordinateSpanMake(deltaLat, deltaLng))
    ];

    result(success);
}

@end