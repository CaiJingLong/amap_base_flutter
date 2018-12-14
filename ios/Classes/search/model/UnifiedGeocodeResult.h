//
// Created by Yohom Bao on 2018-12-14.
//

#import <Foundation/Foundation.h>

@class AMapGeoPoint;
@class UnifiedGeocodeQuery;
@class UnifiedGeocodeAddress;
@class AMapGeocodeSearchResponse;
@class AMapGeocode;

@interface UnifiedGeocodeResult : NSObject

- (instancetype)initWithAMapGeocodeSearchResponse:(AMapGeocodeSearchResponse *)response;

@property(nonatomic) UnifiedGeocodeQuery *geocodeQuery;
@property(nonatomic) NSArray <UnifiedGeocodeAddress *> *geocodeAddressList;
@end

@interface UnifiedGeocodeAddress : NSObject

- (instancetype)initWithAMapGeocode:(AMapGeocode *)geocode;

@property(nonatomic) NSString *formatAddress;
@property(nonatomic) NSString *province;
@property(nonatomic) NSString *city;
@property(nonatomic) NSString *district;
@property(nonatomic) NSString *township;
@property(nonatomic) NSString *neighborhood;
@property(nonatomic) NSString *building;
@property(nonatomic) NSString *adcode;
@property(nonatomic) AMapGeoPoint *latLng;
@property(nonatomic) NSString *level;
@end

@interface UnifiedGeocodeQuery : NSObject
@property(nonatomic) NSString *locationName;
@property(nonatomic) NSString *city;
@end
