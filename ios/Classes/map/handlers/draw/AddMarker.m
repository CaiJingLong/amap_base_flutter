//
// Created by Yohom Bao on 2018-12-07.
//

#import "AddMarker.h"
#import "UnifiedMarkerOptions.h"
#import "MarkerAnnotation.h"
#import "AMapViewFactory.h"
#import "MJExtension.h"


@implementation AddMarker {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    NSString *optionsJson = (NSString *) paramDic[@"markerOptions"];

    NSLog(@"方法marker#addMarker ios端参数: optionsJson -> %@", optionsJson);
    UnifiedMarkerOptions *markerOptions = [UnifiedMarkerOptions mj_objectWithKeyValues:optionsJson];

    MarkerAnnotation *annotation = [[MarkerAnnotation alloc] init];
    annotation.coordinate = [markerOptions.position toCLLocationCoordinate2D];
    annotation.title = markerOptions.title;
    annotation.subtitle = markerOptions.snippet;
    annotation.markerOptions = markerOptions;

    [_mapView addAnnotation:annotation];

    result(success);
}

@end
