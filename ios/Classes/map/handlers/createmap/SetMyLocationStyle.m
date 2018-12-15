//
// Created by Yohom Bao on 2018-12-07.
//

#import "SetMyLocationStyle.h"
#import "MapModels.h"
#import "AMapViewFactory.h"
#import "MJExtension.h"

@implementation SetMyLocationStyle {
    MAMapView *_mapView;
}

- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    NSString *styleJson = (NSString *) paramDic[@"myLocationStyle"];

    NSLog(@"方法setMyLocationStyle ios端参数: styleJson -> %@", styleJson);
    [[UnifiedMyLocationStyle mj_objectWithKeyValues:styleJson] applyTo:_mapView];

    result(success);
}

@end