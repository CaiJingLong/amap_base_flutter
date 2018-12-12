//
// Created by Yohom Bao on 2018-12-12.
//

#import "UnifiedRouteOverlay.h"
#import "UnifiedAMapOptions.h"
#import "MJExtension.h"
#import "AMapCommonObj.h"


@implementation UnifiedRouteOverlay {

}
+ (instancetype)initWithJson:(NSString *)json {
    [UnifiedRouteOverlay mj_setupObjectClassInArray:^NSDictionary * {
        return @{@"passby": @"LatLng"};
    }];
    [UnifiedDrivePath mj_setupObjectClassInArray:^NSDictionary * {
        return @{@"steps": @"UnifiedDriveStep"};
    }];
    [UnifiedDriveStep mj_setupObjectClassInArray:^NSDictionary * {
        return @{
                @"routeSearchCityList": @"UnifiedRouteSearchCity",
                @"TMCs": @"UnifiedTMC",
                @"polyline": @"LatLng",
        };
    }];
    [UnifiedRouteSearchCity mj_setupObjectClassInArray:^NSDictionary * {
        return @{@"districts": @"UnifiedDistrict"};
    }];
    [UnifiedTMC mj_setupObjectClassInArray:^NSDictionary * {
        return @{@"polyline": @"LatLng"};
    }];
    return [UnifiedRouteOverlay mj_objectWithKeyValues:json];
}

@end

@implementation UnifiedDrivePath {

}


@end

@implementation UnifiedDriveStep {

}

@end

@implementation UnifiedRouteSearchCity {

}

@end

@implementation UnifiedTMC {

}

@end

@implementation UnifiedDistrict {

}
@end