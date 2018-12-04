//
// Created by Yohom Bao on 2018-12-04.
//

#import <AMapSearch/AMapSearchKit/AMapSearchObj.h>
#import "UnifiedAMapRoutePOISearchRequest.h"
#import "UnifiedAMapOptions.h"
#import "NSArray+Rx.h"


@implementation UnifiedRoutePoiSearchQuery {

}
- (AMapRoutePOISearchRequest *)toAMapRoutePOISearchRequestLine {
    AMapRoutePOISearchRequest *result = [[AMapRoutePOISearchRequest alloc] init];
    result.origin = [_from toAMapGeoPoint];
    result.destination = [_to toAMapGeoPoint];
    result.strategy = _mode;
    result.searchType = _searchType;
    result.range = _range;
    return result;
}

- (AMapRoutePOISearchRequest *)toAMapRoutePOISearchRequestPolygon {
    AMapRoutePOISearchRequest *result = [[AMapRoutePOISearchRequest alloc] init];
    result.origin = [_from toAMapGeoPoint];
    result.destination = [_to toAMapGeoPoint];
    result.strategy = _mode;
    result.searchType = _searchType;
    result.range = _range;
    result.polyline = [_polylines map:^(LatLng *location) {
        return [location toAMapGeoPoint];
    }];
    return result;
}


@end