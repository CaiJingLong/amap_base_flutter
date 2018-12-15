//
// Created by Yohom Bao on 2018-12-15.
//

#import <Foundation/Foundation.h>

@class CLLocation;
@class AMapLocationReGeocode;


@interface UnifiedAMapLocation : NSObject

- (instancetype)initWithLocation:(CLLocation *)location withRegoecode:(AMapLocationReGeocode *)regoecode withError:(NSError *)error;

@property(nonatomic) CLLocationAccuracy accuracy;
@property(nonatomic) NSString *adCode;
@property(nonatomic) NSString *address;
@property(nonatomic) CLLocationDistance altitude;
@property(nonatomic) NSString *aoiName;
@property(nonatomic) CGFloat bearing;
@property(nonatomic) NSString *buildingId;
@property(nonatomic) NSString *city;
@property(nonatomic) NSString *cityCode;
@property(nonatomic) NSString *coordType;
@property(nonatomic) NSString *country;
@property(nonatomic) NSString *district;
@property(nonatomic) NSInteger errorCode;
@property(nonatomic) NSString *errorInfo;
@property(nonatomic) NSInteger floor;
@property(nonatomic) NSInteger gpsAccuracyStatus;
@property(nonatomic) BOOL isFixLastLocation;
@property(nonatomic) BOOL isMock;
@property(nonatomic) BOOL isOffset;
@property(nonatomic) CLLocationDegrees latitude;
@property(nonatomic) NSString *locationDetail;
@property(nonatomic) NSString *locationQualityReport;
@property(nonatomic) NSInteger locationType;
@property(nonatomic) CLLocationDegrees longitude;
@property(nonatomic) NSString *poiName;
@property(nonatomic) NSString *provider;
@property(nonatomic) NSString *province;
@property(nonatomic) NSInteger satellites;
@property(nonatomic) CLLocationSpeed speed;
@property(nonatomic) NSString *street;
@property(nonatomic) NSString *streetNum;
@property(nonatomic) NSInteger trustedLevel;

@end