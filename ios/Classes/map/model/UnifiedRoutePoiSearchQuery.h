//
// Created by Yohom Bao on 2018-12-04.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol LatLng;
@class LatLng;@class AMapRoutePOISearchRequest;

@interface UnifiedRoutePoiSearchQuery : JSONModel
@property(nonatomic) LatLng *from;
@property(nonatomic) LatLng *to;
@property(nonatomic) NSInteger mode;
@property(nonatomic) NSInteger searchType;
@property(nonatomic) NSInteger range;
@property(nonatomic) NSArray <LatLng, Optional> *polylines;

- (AMapRoutePOISearchRequest*)toAMapRoutePOISearchRequestLine;

- (AMapRoutePOISearchRequest*)toAMapRoutePOISearchRequestPolygon;

@end