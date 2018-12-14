//
// Created by Yohom Bao on 2018-12-12.
//

#import <Foundation/Foundation.h>

@class AMapGeoPoint;
@class AMapRouteSearchResponse;
@class AMapPath;
@class AMapStep;
@class AMapCity;
@class AMapDistrict;
@class AMapTMC;
@class UnifiedDrivePathResult;
@class UnifiedDriveStepResult;
@class UnifiedRouteSearchCityResult;
@class UnifiedTMCResult;
@class UnifiedDistrictResult;


@interface UnifiedDriveRouteResult : NSObject

- (instancetype)initWithAMapRouteSearchResponse:(AMapRouteSearchResponse *)response;

@property(nonatomic) AMapGeoPoint *startPos;
@property(nonatomic) AMapGeoPoint *targetPos;
@property(nonatomic) CGFloat taxiCost;
@property(nonatomic) NSArray <UnifiedDrivePathResult *> *paths;
@end

@interface UnifiedDrivePathResult : NSObject

- (instancetype)initWithAMapPath:(AMapPath *)path;

@property(nonatomic) NSString *strategy;
@property(nonatomic) CGFloat tolls;
@property(nonatomic) CGFloat tollDistance;
@property(nonatomic) NSInteger totalTrafficlights;
@property(nonatomic) NSArray <UnifiedDriveStepResult *> *steps;
@property(nonatomic) NSInteger restriction;

@end

@interface UnifiedDriveStepResult : NSObject

- (instancetype)initWithAMapStep:(AMapStep *)step;

@property(nonatomic) NSString *instruction;
@property(nonatomic) NSString *orientation;
@property(nonatomic) NSString *road;
@property(nonatomic) CGFloat distance;
@property(nonatomic) CGFloat tolls;
@property(nonatomic) CGFloat tollDistance;
@property(nonatomic) NSString *tollRoad;
@property(nonatomic) CGFloat duration;
@property(nonatomic) NSArray <AMapGeoPoint *> *polyline;
@property(nonatomic) NSString *action;
@property(nonatomic) NSString *assistantAction;
@property(nonatomic) NSArray<UnifiedRouteSearchCityResult *> *routeSearchCityList;
@property(nonatomic) NSArray <UnifiedTMCResult *> *TMCs;
@end

@interface UnifiedRouteSearchCityResult : NSObject

- (instancetype)initWithAMapCity:(AMapCity *)step;

@property(nonatomic) NSArray <UnifiedDistrictResult *> *districts;
@end

@interface UnifiedTMCResult : NSObject

- (instancetype)initWithAMapTMC:(AMapTMC *)tmc;

@property(nonatomic) NSInteger distance;
@property(nonatomic) NSString *status;
@property(nonatomic) NSArray <AMapGeoPoint *> *polyline;
@end

@interface UnifiedDistrictResult : NSObject

- (instancetype)initWithAMapDistrict:(AMapDistrict *)district;

@property(nonatomic) NSString *districtName;
@property(nonatomic) NSString *districtAdcode;
@end