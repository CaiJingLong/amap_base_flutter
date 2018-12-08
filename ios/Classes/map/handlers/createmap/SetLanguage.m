//
// Created by Yohom Bao on 2018-12-07.
//

#import <AMap3DMap/MAMapKit/MAMapView.h>
#import "SetLanguage.h"
#import "AMapSearchKit.h"
#import "AMapViewFactory.h"


@implementation SetLanguage {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    // 由于iOS端是从0开始算的, 所以这里减去1
    NSString *language = (NSString *) paramDic[@"language"];

    NSLog(@"方法map#setLanguage ios端参数: language -> %@", language);

    [_mapView performSelector:NSSelectorFromString(@"setMapLanguage:") withObject:language];

    result(success);
}

@end