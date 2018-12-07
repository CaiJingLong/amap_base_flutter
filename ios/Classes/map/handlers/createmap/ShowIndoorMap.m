//
// Created by Yohom Bao on 2018-12-07.
//

#import <AMap3DMap/MAMapKit/MAMapView.h>
#import "ShowIndoorMap.h"
#import "AMapSearchKit.h"
#import "AMapViewFactory.h"


@implementation ShowIndoorMap {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)with:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    BOOL enabled = (BOOL) paramDic[@"showIndoorMap"];

    NSLog(@"方法map#showIndoorMap android端参数: enabled -> %d", enabled);

    _mapView.showsIndoorMap = enabled;

    result(success);
}

@end