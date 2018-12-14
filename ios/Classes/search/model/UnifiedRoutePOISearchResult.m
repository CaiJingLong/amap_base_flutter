//
// Created by Yohom Bao on 2018-12-04.
//

#import "UnifiedRoutePOISearchResult.h"
#import "NSArray+Rx.h"
#import "AMapCommonObj.h"
#import "AMapSearchKit.h"


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
        _point = aMapPOI.location;
        _distance = aMapPOI.distance;
        _duration = 0;
    }
    return self;
}

@end
