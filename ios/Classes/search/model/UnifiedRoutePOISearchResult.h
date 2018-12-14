//
// Created by Yohom Bao on 2018-12-04.
//

#import <Foundation/Foundation.h>

@class AMapRoutePOISearchResponse;

@class UnifiedRoutePOIItem;
@class AMapPOI;
@class AMapGeoPoint;

@interface UnifiedRoutePOISearchResult : NSObject

- (instancetype)initWithAMapRoutePOISearchResponse:(AMapRoutePOISearchResponse *)result;

@property(nonatomic) NSArray <UnifiedRoutePOIItem*> *routePoiList;
@property(nonatomic) NSString *query;
@end

@interface UnifiedRoutePOIItem : NSObject

- (instancetype)initWithAMapPOI:(AMapPOI *)aMapPOI;

@property(nonatomic) NSString *id;
@property(nonatomic) NSString *title;
@property(nonatomic) AMapGeoPoint *point;
@property(nonatomic) NSInteger distance;
@property(nonatomic) NSInteger duration;

@end