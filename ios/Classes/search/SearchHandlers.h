//
// Created by Yohom Bao on 2018-12-16.
//

#import <Foundation/Foundation.h>
#import "IMethodHandler.h"
#import "AMapSearchAPI.h"


@interface SearchGeocode : NSObject<SearchMethodHandler, AMapSearchDelegate>
@end

@interface SearchPoiBound : NSObject<SearchMethodHandler, AMapSearchDelegate>
@end

@interface SearchPoiId : NSObject<SearchMethodHandler, AMapSearchDelegate>
@end

@interface SearchPoiKeyword : NSObject<SearchMethodHandler, AMapSearchDelegate>
@end

@interface SearchPoiPolygon : NSObject<SearchMethodHandler, AMapSearchDelegate>
@end

@interface SearchRoutePoiLine : NSObject<SearchMethodHandler, AMapSearchDelegate>
@end

@interface SearchRoutePoiPolygon : NSObject<SearchMethodHandler, AMapSearchDelegate>
@end

@interface CalculateDriveRoute : NSObject<SearchMethodHandler, AMapSearchDelegate>
@end