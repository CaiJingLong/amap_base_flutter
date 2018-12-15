//
// Created by Yohom Bao on 2018-12-07.
//

#import "MapModels.h"
#import "AddMarkers.h"
#import "AMapViewFactory.h"
#import "MJExtension.h"


@implementation AddMarkers {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    NSString *moveToCenter = (NSString *) paramDic[@"moveToCenter"];
    NSString *optionsListJson = (NSString *) paramDic[@"markerOptionsList"];
    BOOL clear = (BOOL) paramDic[@"clear"];

    NSLog(@"方法marker#addMarkers ios端参数: optionsListJson -> %@", optionsListJson);
    if (clear) [_mapView removeAnnotations:_mapView.annotations];

    NSArray *rawOptionsList = [NSJSONSerialization JSONObjectWithData:[optionsListJson dataUsingEncoding:NSUTF8StringEncoding]
                                                              options:kNilOptions
                                                                error:nil];
    NSMutableArray<MarkerAnnotation *> *optionList = [NSMutableArray array];

    for (NSUInteger i = 0; i < rawOptionsList.count; ++i) {
        UnifiedMarkerOptions *options = [UnifiedMarkerOptions mj_objectWithKeyValues:rawOptionsList[i]];
        MarkerAnnotation *annotation = [[MarkerAnnotation alloc] init];
        annotation.coordinate = [options.position toCLLocationCoordinate2D];
        annotation.title = options.title;
        annotation.subtitle = options.snippet;
        annotation.markerOptions = options;

        [optionList addObject:annotation];
    }

    [_mapView addAnnotations:optionList];
    if (moveToCenter) {
        [_mapView showAnnotations:optionList animated:YES];
    }

    result(success);
}

@end
