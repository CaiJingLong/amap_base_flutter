//
// Created by Yohom Bao on 2018-12-04.
//

#import <AMapSearch/AMapSearchKit/AMapSearchObj.h>
#import <AMapSearch/AMapSearchKit/AMapCommonObj.h>
#import "UnifiedRoutePOISearchResult.h"
#import "UnifiedAMapOptions.h"
#import "NSArray+Rx.h"
#import "AMapGeoPoint+LatLng.h"


@implementation UnifiedRoutePOISearchResult {

}
- (instancetype)initWithAMapRoutePOISearchResponse:(AMapRoutePOISearchResponse *)result {
    if ([self init]) {
        _query = nil;
        _routePoiList = [result.pois map:^(AMapPOI *poi) {
            return [[UnifiedRoutePOIItem alloc] initWithAMapPOI:poi];
        }];
    }
    return self;
}

@end

@implementation UnifiedRoutePOIItem {

}
- (instancetype)initWithAMapPOI:(AMapPOI *)aMapPOI {
    if ([self init]) {
        _id = aMapPOI.uid;
        _title = aMapPOI.name;
        _point = [aMapPOI.location toLatLng];
        _distance = aMapPOI.distance;
        _duration = 0;
    }
    return self;
}

@end