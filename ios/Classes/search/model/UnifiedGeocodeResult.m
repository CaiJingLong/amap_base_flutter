//
// Created by Yohom Bao on 2018-12-14.
//

#import "UnifiedGeocodeResult.h"
#import "AMapCommonObj.h"
#import "AMapSearchKit.h"
#import "NSArray+Rx.h"


@implementation UnifiedGeocodeResult {

}

- (instancetype)initWithAMapGeocodeSearchResponse:(AMapGeocodeSearchResponse *)response {
    self = [super init];
    if (self) {
        _geocodeAddressList = [response.geocodes map:^(AMapGeocode* geocode) {
           return [[UnifiedGeocodeAddress alloc] initWithAMapGeocode:geocode];
        }];
    }

    return self;
}

@end

@implementation UnifiedGeocodeAddress {

}
- (instancetype)initWithAMapGeocode:(AMapGeocode *)geocode {
    self = [super init];
    if (self) {
        _formatAddress = geocode.formattedAddress;
        _province = geocode.province;
        _city = geocode.city;
        _adcode = geocode.adcode;
        _district = geocode.district;
        _township = geocode.township;
        _neighborhood = geocode.neighborhood;
        _building = geocode.building;
        _level = geocode.level;
        _latLng = geocode.location;
    }

    return self;
}

@end

@implementation UnifiedGeocodeQuery {

}
@end