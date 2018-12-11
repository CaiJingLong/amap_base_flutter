//
// Created by Yohom Bao on 2018-12-11.
//

#import "SearchFunctionRegistry.h"
#import "SearchMethodHandler.h"
#import "SearchRoutePoiPolygon.h"
#import "CalculateDriveRoute.h"
#import "SearchPoiKeyword.h"
#import "SearchPoiBound.h"
#import "SearchPoiPolygon.h"
#import "SearchPoiId.h"
#import "SearchRoutePoiLine.h"


static NSDictionary<NSString *, NSObject <SearchMethodHandler> *> *_map;

@implementation SearchFunctionRegistry {

}
+ (NSDictionary<NSString *, NSObject <SearchMethodHandler> *> *)searchMethodHandler {
    if (!_map) {
        _map = @{
                @"search#calculateDriveRoute": [CalculateDriveRoute alloc],
                @"search#searchPoi": [SearchPoiKeyword alloc],
                @"search#searchPoiBound": [SearchPoiBound alloc],
                @"search#searchPoiPolygon": [SearchPoiPolygon alloc],
                @"search#searchPoiId": [SearchPoiId alloc],
                @"search#searchRoutePoiLine": [SearchRoutePoiLine alloc],
                @"search#searchRoutePoiPolygon": [SearchRoutePoiPolygon alloc],
        };
    }
    return _map;
}

@end