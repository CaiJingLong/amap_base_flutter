//
// Created by Yohom Bao on 2018-12-12.
//

#import <Foundation/Foundation.h>

@class LatLng;
@class UnifiedDrivePath;
@class UnifiedDriveStep;
@class UnifiedDistrict;
@class UnifiedTMC;
@class UnifiedRouteSearchCity;


@interface UnifiedRouteOverlay : NSObject
@property(nonatomic) NSString *type;
@property(nonatomic) LatLng *from;
@property(nonatomic) LatLng *to;
@property(nonatomic) NSArray<LatLng *> *passby;
@property(nonatomic) UnifiedDrivePath *drivePath;
@end

@interface UnifiedDrivePath : NSObject
@property(nonatomic) NSString *strategy;
@property(nonatomic) CGFloat tolls;
@property(nonatomic) CGFloat tollDistance;
@property(nonatomic) NSInteger totalTrafficlights;
@property(nonatomic) NSArray <UnifiedDriveStep *> *steps;
@property(nonatomic) NSInteger restriction;

@end

@interface UnifiedDriveStep : NSObject
@property(nonatomic) NSString *instruction;
@property(nonatomic) NSString *orientation;
@property(nonatomic) NSString *road;
@property(nonatomic) CGFloat distance;
@property(nonatomic) CGFloat tolls;
@property(nonatomic) CGFloat tollDistance;
@property(nonatomic) NSString *tollRoad;
@property(nonatomic) CGFloat duration;
@property(nonatomic) NSArray <LatLng *> *polyline;
@property(nonatomic) NSString *action;
@property(nonatomic) NSString *assistantAction;
@property(nonatomic) NSArray<UnifiedRouteSearchCity *> *routeSearchCityList;
@property(nonatomic) NSArray <UnifiedTMC *> *TMCs;
@end

@interface UnifiedRouteSearchCity : NSObject
@property(nonatomic) NSArray <UnifiedDistrict *> *districts;
@end

@interface UnifiedTMC : NSObject
@property(nonatomic) NSInteger distance;
@property(nonatomic) NSString *status;
@property(nonatomic) NSArray <LatLng *> *polyline;
@end

@interface UnifiedDistrict : NSObject
@property(nonatomic) NSString *districtName;
@property(nonatomic) NSString *districtAdcode;
@end