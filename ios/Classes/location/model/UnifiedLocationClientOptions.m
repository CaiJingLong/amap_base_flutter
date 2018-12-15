//
// Created by Yohom Bao on 2018-12-15.
//

#import <AMapLocation/AMapLocationKit/AMapLocationManager.h>
#import "UnifiedLocationClientOptions.h"


@implementation UnifiedLocationClientOptions {

}
- (void)applyTo:(AMapLocationManager *)locationManager {
    locationManager.distanceFilter = _distanceFilter;
    if (_locationMode == 0) {
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    } else if (_locationMode == 1) {
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    } else if (_locationMode == 2) {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    } else {
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    }
    locationManager.pausesLocationUpdatesAutomatically = _pausesLocationUpdatesAutomatically;
    locationManager.allowsBackgroundLocationUpdates = _allowsBackgroundLocationUpdates;
    locationManager.locationTimeout = _locationTimeout;
    locationManager.reGeocodeTimeout = _reGeocodeTimeout;
    locationManager.locatingWithReGeocode = _locatingWithReGeocode;
    locationManager.reGeocodeLanguage = _geoLanguage;
    locationManager.detectRiskOfFakeLocation = _detectRiskOfFakeLocation;
}

@end