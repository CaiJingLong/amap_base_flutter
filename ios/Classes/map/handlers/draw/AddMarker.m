//
// Created by Yohom Bao on 2018-12-07.
//

#import <JSONModel/JSONModelError.h>
#import <AMap3DMap/MAMapKit/MAMapView.h>
#import "AddMarker.h"
#import "UnifiedMarkerOptions.h"
#import "MarkerAnnotation.h"
#import "AMapSearchKit.h"
#import "AMapViewFactory.h"


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
    JSONModelError *error;
    UnifiedMarkerOptions *markerOptions = [[UnifiedMarkerOptions alloc] initWithString:optionsJson error:&error];
    NSLog(@"JSONModelError: %@", error.description);

    MarkerAnnotation *annotation = [[MarkerAnnotation alloc] init];
    annotation.coordinate = [markerOptions.position toCLLocationCoordinate2D];
    annotation.title = markerOptions.title;
    annotation.subtitle = markerOptions.snippet;
    annotation.markerOptions = markerOptions;

    [_mapView addAnnotation:annotation];

    result(success);
}

@end