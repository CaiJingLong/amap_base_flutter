//
// Created by Yohom Bao on 2018-12-07.
//

#import "SetMapType.h"
#import "AMapViewFactory.h"


@implementation SetMapType {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    // 由于iOS端是从0开始算的, 所以这里减去1
    NSInteger mapType = [paramDic[@"mapType"] integerValue] - 1;

    NSLog(@"方法map#setMapType ios端参数: mapType -> %d", mapType);

    [_mapView setMapType:(MAMapType) mapType];

    result(success);
}

@end
