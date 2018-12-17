//
// Created by Yohom Bao on 2018-12-15.
//

#import "AMapLocationManager.h"
#import "LocationModels.h"


@implementation UnifiedAMapLocation {

}

- (instancetype)initWithLocation:(CLLocation *)location withRegoecode:(AMapLocationReGeocode *)regoecode withError:(NSError *)error {
    self = [super init];
    if (self) {
//        _accuracy = location.a;
//        _locationDetail = regoecode.z;
//        _locationType = location.a;
//        _bearing = location.a;
//        _gpsAccuracyStatus = lo;
//        _provider = a;
//        _streetNum = regoecode.str;
        _accuracy = location.horizontalAccuracy;
        _altitude = location.altitude;
        _floor = location.floor.level;
        _latitude = location.coordinate.latitude;
        _longitude = location.coordinate.longitude;
        _speed = location.speed;

        if (error) {
            _errorCode = error.code;
            _errorInfo = error.localizedDescription;
        }

        if (regoecode) {
            _adCode = regoecode.adcode;
            _address = regoecode.formattedAddress;
            _aoiName = regoecode.AOIName;
            _buildingId = regoecode.building;
            _city = regoecode.city;
            _cityCode = regoecode.citycode;
            _district = regoecode.district;
            _poiName = regoecode.POIName;
            _province = regoecode.province;
            _street = regoecode.street;
        }
    }

    return self;
}

@end


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