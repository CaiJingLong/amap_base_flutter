//
// Created by Yohom Bao on 2018-12-06.
//

#import <CoreLocation/CoreLocation.h>
#import "NSObject+Permission.h"


@implementation NSObject (Permission)

- (void)checkPermission {
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];

    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
            [locationManager requestWhenInUseAuthorization];
            break;
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
            // Disable location features
            [locationManager requestWhenInUseAuthorization];
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            break;
    }
}

@end