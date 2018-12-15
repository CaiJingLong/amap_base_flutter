//
// Created by Yohom Bao on 2018-12-15.
//

#import <AMapLocation/AMapLocationKit/AMapLocationManager.h>
#import "Init.h"

static AMapLocationManager *_locationManager;

@implementation Init {
}

+ (AMapLocationManager *)locationManager {
    if (_locationManager) {
        return _locationManager;
    } else {
        _locationManager = [[AMapLocationManager alloc] init];
        return _locationManager;
    }
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    result(@"成功");
}

@end