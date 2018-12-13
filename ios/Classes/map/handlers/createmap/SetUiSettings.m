//
// Created by Yohom Bao on 2018-12-07.
//

#import "SetUiSettings.h"
#import "UnifiedUiSettings.h"
#import "AMapViewFactory.h"
#import "MJExtension.h"


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
    [[UnifiedUiSettings mj_objectWithKeyValues:uiSettingsJson] applyTo:_mapView];

    result(success);

}

@end