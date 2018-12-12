//
// Created by Yohom Bao on 2018-12-12.
//

#import "UnifiedDriveRouteResult.h"
#import "AMapSearchKit.h"
#import "NSArray+Rx.h"


@implementation UnifiedDriveRouteResult {

}
- (instancetype)initWithAMapRouteSearchResponse:(AMapRouteSearchResponse *)response {
    if ([self init]) {
        _startPos = response.route.origin;
        _targetPos = response.route.destination;
        _taxiCost = response.route.taxiCost;
        _paths = [response.route.paths map:^(AMapPath *path) {
            return [[UnifiedDrivePathResult alloc] initWithAMapPath:path];
        }];
    }
    return self;
}

@end


@implementation UnifiedDrivePathResult {
}

- (instancetype)initWithAMapPath:(AMapPath *)path {
    if ([self init]) {
        _strategy = path.strategy;
        _tolls = path.tolls;
        _tollDistance = path.tollDistance;
        _totalTrafficlights = path.totalTrafficLights;
        _steps = [path.steps map:^(AMapStep *step) {
            return [[UnifiedDriveStepResult alloc] initWithAMapStep:step];
        }];
        _restriction = path.restriction;
    }
    return self;
}

@end

@implementation UnifiedDriveStepResult {

}
- (instancetype)initWithAMapStep:(AMapStep *)step {
    if ([self init]) {
        _instruction = step.instruction;
        _orientation = step.orientation;
        _road = step.road;
        _distance = step.distance;
        _duration = step.duration;
        _polyline = step.polyline;
        _action = step.action;
        _assistantAction = step.assistantAction;
        _tolls = step.tolls;
        _tollDistance = step.tollDistance;
        _tollRoad = step.tollRoad;
        _routeSearchCityList = [step.cities map:^(AMapCity *city) {
            return [[UnifiedRouteSearchCityResult alloc] initWithAMapCity:city];
        }];
        _TMCs = [step.tmcs map:^(AMapTMC *tmc) {
            return [[UnifiedTMCResult alloc] initWithAMapTMC:tmc];
        }];
    }
    return self;
}

@end

@implementation UnifiedRouteSearchCityResult {

}
- (instancetype)initWithAMapCity:(AMapCity *)step {
    if ([self init]) {
        _districts = [step.districts map:^(AMapDistrict *district) {
            return [[UnifiedDistrictResult alloc] initWithAMapDistrict:district];
        }];
    }
    return self;
}

@end

@implementation UnifiedTMCResult {

}
- (instancetype)initWithAMapTMC:(AMapTMC *)tmc {
    if ([self init]) {
        _distance = tmc.distance;
        _status = tmc.status;
        _polyline = tmc.polyline;
    }
    return self;
}

@end

@implementation UnifiedDistrictResult {

}
- (instancetype)initWithAMapDistrict:(AMapDistrict *)district {
    if ([self init]) {
        _districtName = district.name;
        _districtAdcode = district.adcode;
    }
    return self;
}

@end