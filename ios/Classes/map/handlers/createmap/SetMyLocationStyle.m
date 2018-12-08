//
// Created by Yohom Bao on 2018-12-07.
//

#import "SetMyLocationStyle.h"
#import "JSONModelError.h"
#import "UnifiedMyLocationStyle.h"
#import "AMapSearchKit.h"
#import "AMapViewFactory.h"
#import "Misc.h"


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
    JSONModelError *error;
    [[[UnifiedMyLocationStyle alloc] initWithString:styleJson error:&error] applyTo:_mapView];

    [Misc handlerArgumentError:error result:result];

    result(success);
}

@end