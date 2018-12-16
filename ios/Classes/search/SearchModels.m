//
// Created by Yohom Bao on 2018-12-16.
//

#import "SearchModels.h"
#import "AMapSearchObj.h"
#import "NSArray+Rx.h"
#import "NSString+GeoPoint.h"
#import "MJExtension.h"


//region RoutePlanParam
@implementation RoutePlanParam {

}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.from=%@", self.from];
    [description appendFormat:@", self.to=%@", self.to];
    [description appendFormat:@", self.mode=%i", self.mode];
    [description appendFormat:@", self.passedByPoints=%@", self.passedByPoints];
    [description appendFormat:@", self.avoidPolygons=%@", self.avoidPolygons];
    [description appendFormat:@", self.avoidRoad=%p", self.avoidRoad];
    [description appendString:@">"];
    return description;
}

@end
//endregion


//region UnifiedDriveRouteResult
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
        _polyline = [step.polyline stringToAMapGeoPoint];
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
        _polyline = [tmc.polyline stringToAMapGeoPoint];
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
//endregion


//region UnifiedGeocodeResult
@implementation UnifiedGeocodeResult {

}

- (instancetype)initWithAMapGeocodeSearchResponse:(AMapGeocodeSearchResponse *)response {
    self = [super init];
    if (self) {
        _geocodeAddressList = [response.geocodes map:^(AMapGeocode* geocode) {
            return [[UnifiedGeocodeAddress alloc] initWithAMapGeocode:geocode];
        }];
    }

    return self;
}

@end

@implementation UnifiedGeocodeAddress {

}
- (instancetype)initWithAMapGeocode:(AMapGeocode *)geocode {
    self = [super init];
    if (self) {
        _formatAddress = geocode.formattedAddress;
        _province = geocode.province;
        _city = geocode.city;
        _adcode = geocode.adcode;
        _district = geocode.district;
        _township = geocode.township;
        _neighborhood = geocode.neighborhood;
        _building = geocode.building;
        _level = geocode.level;
        _latLng = geocode.location;
    }

    return self;
}

@end

@implementation UnifiedGeocodeQuery {

}
@end
//endregion


//region UnifiedPoiResult
@implementation UnifiedPoiResult {

}
- (instancetype)initWithPoiResult:(AMapPOISearchResponse *)result {
    if ([super init]) {
        _pageCount = result.count;
        _pois = [result.pois map:^(AMapPOI *poi) {
            return [[PoiItem alloc] initWithAMapPOI:poi];
        }];
        _searchSuggestionCitys = [result.suggestion.cities map:^(AMapCity *amapCity) {
            return [[SuggestionCity alloc] initWithAMapSuggestion:amapCity];
        }];
        _searchSuggestionKeywords = result.suggestion.keywords;
    }
    return self;
}

@end

@implementation PoiItem {

}
- (instancetype)initWithAMapPOI:(AMapPOI *)aMapPOI {
    if ([super init]) {
        _poiId = aMapPOI.uid;
        _adCode = aMapPOI.adcode;
        _adName = aMapPOI.district;
        _businessArea = aMapPOI.businessArea;
        _cityCode = aMapPOI.citycode;
        _cityName = aMapPOI.city;
        _direction = aMapPOI.direction;
        _distance = aMapPOI.distance;
        _email = aMapPOI.email;
        _indoorData = [[IndoorData alloc] initWithAMapIndoorData:aMapPOI.indoorData];
        _isIndoorMap = aMapPOI.hasIndoorMap;
        _latLonPoint = aMapPOI.location;
        _enter = aMapPOI.enterLocation;
        _exit = aMapPOI.exitLocation;
        _parkingType = aMapPOI.parkingType;
        _photos = [aMapPOI.images map:^(AMapImage *image) {
            return [[Photo alloc] initWithAMapImage:image];
        }];
        _poiExtension = [[PoiExtension alloc] initWithAMapPOIExtension:aMapPOI.extensionInfo];
        _postcode = aMapPOI.postcode;
        _provinceCode = aMapPOI.pcode;
        _provinceName = aMapPOI.province;
        _shopID = aMapPOI.shopID;
        _snippet = aMapPOI.address;
        _subPois = [aMapPOI.subPOIs map:^(AMapSubPOI *subPOI) {
            return [[SubPoiItem alloc] initWithSubPoi:subPOI];
        }];
        _tel = aMapPOI.tel;
        _title = aMapPOI.name;
        _typeCode = aMapPOI.typecode;
        _typeDes = aMapPOI.type;
        _website = aMapPOI.website;
        _gridCode = aMapPOI.gridcode;
    }
    return self;
}

@end

@implementation SuggestionCity {

}
- (instancetype)initWithAMapSuggestion:(AMapCity *)suggestion {
    if ([super init]) {
        _cityName = suggestion.city;
        _cityCode = suggestion.citycode;
        _adCode = suggestion.adcode;
        _suggestionNum = suggestion.num;
        _districts = suggestion.districts;
    }
    return self;
}

@end

@implementation SubPoiItem {

}
- (instancetype)initWithSubPoi:(AMapSubPOI *)subPOI {
    if ([super init]) {
        _poiId = subPOI.uid;
        _title = subPOI.name;
        _subName = subPOI.sname;
        _distance = subPOI.distance;
        _latLonPoint = subPOI.location;
        _snippet = subPOI.address;
        _subTypeDes = subPOI.subtype;
    }
    return self;
}

@end

@implementation PoiExtension {

}
- (instancetype)initWithAMapPOIExtension:(AMapPOIExtension *)poiExtension {
    if ([super init]) {
        _opentime = poiExtension.openTime;
        _rating = [NSString stringWithFormat:@"%f", poiExtension.rating];
        _cost = poiExtension.cost;
    }
    return self;
}

@end

@implementation Photo {

}
- (instancetype)initWithAMapImage:(AMapImage *)image {
    if ([super init]) {
        _title = image.title;
        _url = image.url;
    }
    return self;
}

@end

@implementation IndoorData {

}
- (instancetype)initWithAMapIndoorData:(AMapIndoorData *)indoorData {
    if ([super init]) {
        _floor = indoorData.floor;
        _floorName = indoorData.floorName;
        _poiId = indoorData.pid;
    }
    return self;
}

@end
//endregion


//region UnifiedPoiSearchQuery
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
//endregion


//region UnifiedRoutePoiSearchQuery
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
//endregion


//region UnifiedRoutePOISearchResult
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
//endregion


//region UnifiedSearchBound
@implementation UnifiedSearchBound {

}
@end
//endregion
