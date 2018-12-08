//
// Created by Yohom Bao on 2018-12-04.
//

#import <Foundation/Foundation.h>

@class LatLng;
@class AMapRoutePOISearchRequest;

@interface UnifiedRoutePoiSearchQuery : NSObject
@property(nonatomic) LatLng *from;
@property(nonatomic) LatLng *to;
@property(nonatomic) NSInteger mode;
@property(nonatomic) NSInteger searchType;
@property(nonatomic) NSInteger range;
@property(nonatomic) NSArray <LatLng *> *polylines;

- (AMapRoutePOISearchRequest *)toAMapRoutePOISearchRequestLine;

- (AMapRoutePOISearchRequest *)toAMapRoutePOISearchRequestPolygon;

@end