//
// Created by Yohom Bao on 2018-12-03.
//

#import "UnifiedSearchBound.h"
#import "NSArray+Rx.h"
#import "UnifiedPoiSearchQuery.h"
#import "MJExtension.h"
#import "AMapSearchKit.h"


@implementation UnifiedPoiSearchQuery {

}
- (AMapPOIKeywordsSearchRequest *)toAMapPOIKeywordsSearchRequest {
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.types = _category;
    if (_distanceSort) {
        request.sortrule = 0;
    } else {
        request.sortrule = 1;
    }
    request.offset = _pageSize;
    request.page = _pageNum;
    request.building = _building;
    request.requireExtension = _requireExtension;
    request.requireSubPOIs = _requireSubPois;
    request.keywords = _query;
    request.city = _city;
    request.cityLimit = _cityLimit;
    request.location = _location;
    return request;
}

- (AMapPOIAroundSearchRequest *)toAMapPOIAroundSearchRequest {
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.types = _category;
    if (_distanceSort) {
        request.sortrule = 0;
    } else {
        request.sortrule = 1;
    }
    request.offset = _pageSize;
    request.page = _pageNum;
    request.building = _building;
    request.requireExtension = _requireExtension;
    request.requireSubPOIs = _requireSubPois;
    request.keywords = _query;
    request.city = _city;
    request.location = _location;
    request.radius = _searchBound.range;
    return request;
}

- (AMapPOIPolygonSearchRequest *)toAMapPOIPolygonSearchRequest {
    AMapPOIPolygonSearchRequest *request = [[AMapPOIPolygonSearchRequest alloc] init];
    request.types = _category;
    if (_distanceSort) {
        request.sortrule = 0;
    } else {
        request.sortrule = 1;
    }
    request.offset = _pageSize;
    request.page = _pageNum;
    request.building = _building;
    request.requireExtension = _requireExtension;
    request.requireSubPOIs = _requireSubPois;
    request.keywords = _query;

    NSArray <AMapGeoPoint *> *polygonList = [_searchBound.polyGonList map:^(NSDictionary *location) {
        return [AMapGeoPoint mj_objectWithKeyValues:location];
    }];
    request.polygon = [AMapGeoPolygon polygonWithPoints:polygonList];
    return request;
}


@end
