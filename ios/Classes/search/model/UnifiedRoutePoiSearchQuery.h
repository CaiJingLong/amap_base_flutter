//
// Created by Yohom Bao on 2018-12-04.
//

#import <Foundation/Foundation.h>

@class AMapRoutePOISearchRequest;

@class AMapGeoPoint;

@interface UnifiedRoutePoiSearchQuery : NSObject
@property(nonatomic) AMapGeoPoint *from;
@property(nonatomic) AMapGeoPoint *to;
@property(nonatomic) NSInteger mode;
@property(nonatomic) NSInteger searchType;
@property(nonatomic) NSInteger range;
@property(nonatomic) NSArray <AMapGeoPoint *> *polylines;

- (AMapRoutePOISearchRequest *)toAMapRoutePOISearchRequestLine;

- (AMapRoutePOISearchRequest *)toAMapRoutePOISearchRequestPolygon;

@end