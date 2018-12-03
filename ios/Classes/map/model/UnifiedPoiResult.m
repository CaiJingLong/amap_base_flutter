//
// Created by Yohom Bao on 2018-12-03.
//

#import <AMapSearch/AMapSearchKit/AMapSearchObj.h>
#import "UnifiedPoiResult.h"
#import "UnifiedAMapOptions.h"
#import "NSArray+Rx.h"
#import "AMapGeoPoint+LatLng.h"


@implementation UnifiedPoiResult {

}
- (instancetype)initWithPoiResult:(AMapPOISearchResponse *)result {
    if ([super init]) {
        _pageCount = result.count;
        _pois = (NSArray <PoiItem> *) [result.pois map:^(AMapPOI *poi) {
            return [[PoiItem alloc] initWithAMapPOI:poi];
        }];
        _searchSuggestionCitys = (NSArray <SuggestionCity> *) [result.suggestion.cities map:^(AMapCity *amapCity) {
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
        _latLonPoint = [aMapPOI.location toLatLng];
        _enter = [aMapPOI.enterLocation toLatLng];
        _exit = [aMapPOI.exitLocation toLatLng];
        _parkingType = aMapPOI.parkingType;
        _photos = (NSArray <Photo> *) [aMapPOI.images map:^(AMapImage *image) {
            return [[Photo alloc] initWithAMapImage:image];
        }];
        _poiExtension = [[PoiExtension alloc] initWithAMapPOIExtension:aMapPOI.extensionInfo];
        _postcode = aMapPOI.postcode;
        _provinceCode = aMapPOI.pcode;
        _provinceName = aMapPOI.province;
        _shopID = aMapPOI.shopID;
        _snippet = aMapPOI.address;
        _subPois = (NSArray <SubPoiItem> *) [aMapPOI.subPOIs map:^(AMapSubPOI *subPOI) {
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
        _latLonPoint = [subPOI.location toLatLng];
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