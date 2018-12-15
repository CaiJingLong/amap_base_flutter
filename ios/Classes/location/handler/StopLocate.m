//
// Created by Yohom Bao on 2018-12-15.
//

#import <AMapLocation/AMapLocationKit/AMapLocationManager.h>
#import "StopLocate.h"
#import "Init.h"


@implementation StopLocate {

}
- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    AMapLocationManager *locationManager = [Init locationManager];
    [locationManager stopUpdatingLocation];
}

@end