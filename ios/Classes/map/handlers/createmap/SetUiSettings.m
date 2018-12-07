//
// Created by Yohom Bao on 2018-12-07.
//

#import "SetUiSettings.h"
#import "JSONModelError.h"
#import "UnifiedUiSettings.h"
#import "AMapSearchKit.h"
#import "AMapViewFactory.h"


@implementation SetUiSettings {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    NSString *uiSettingsJson = (NSString *) paramDic[@"uiSettings"];

    NSLog(@"方法setUiSettings ios端参数: uiSettingsJson -> %@", uiSettingsJson);
    JSONModelError *error;
    [[[UnifiedUiSettings alloc] initWithString:uiSettingsJson error:&error] applyTo:_mapView];

    NSLog(@"JSONModelError: %@", error.description);

    result(success);

}

@end