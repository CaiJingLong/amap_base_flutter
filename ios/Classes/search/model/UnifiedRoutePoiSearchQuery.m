//
// Created by Yohom Bao on 2018-12-04.
//

#import "NSArray+Rx.h"
#import "MJExtension.h"
#import "UnifiedRoutePoiSearchQuery.h"
#import "AMapSearchKit.h"

@implementation UnifiedRoutePoiSearchQuery {

}
- (AMapRoutePOISearchRequest *)toAMapRoutePOISearchRequestLine {
    AMapRoutePOISearchRequest *result = [[AMapRoutePOISearchRequest alloc] init];
    result.origin = _from;
    result.destination = _to;
    result.strategy = _mode;
    result.searchType = (AMapRoutePOISearchType) _searchType;
    result.range = _range;
    return result;
}

- (AMapRoutePOISearchRequest *)toAMapRoutePOISearchRequestPolygon {
    AMapRoutePOISearchRequest *result = [[AMapRoutePOISearchRequest alloc] init];
    result.origin = _from;
    result.destination = _to;
    result.strategy = _mode;
    result.searchType = (AMapRoutePOISearchType) _searchType;
    result.range = _range;
    result.polyline = [_polylines map:^(NSDictionary *location) {
        return [AMapGeoPoint mj_objectWithKeyValues:location];
    }];
    return result;
}


@end
