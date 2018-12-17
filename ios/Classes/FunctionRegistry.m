//
// Created by Yohom Bao on 2018-12-12.
//

#import "FunctionRegistry.h"
#import "IMethodHandler.h"
#import "LocationHandlers.h"
#import "SearchHandlers.h"
#import "MapHandlers.h"
#import "NaviHandlers.h"

static NSDictionary<NSString *, NSObject <MapMethodHandler> *> *_mapDictionary;

@implementation MapFunctionRegistry {
}

+ (NSDictionary<NSString *, NSObject <MapMethodHandler> *> *)mapMethodHandler {
    if (!_mapDictionary) {
        _mapDictionary = @{
                @"map#clear": [ClearMap alloc],
                @"map#setMyLocationStyle": [SetMyLocationStyle alloc],
                @"map#setUiSettings": [SetUiSettings alloc],
                @"marker#addMarker": [AddMarker alloc],
                @"marker#addMarkers": [AddMarkers alloc],
                @"map#showIndoorMap": [ShowIndoorMap alloc],
                @"map#setMapType": [SetMapType alloc],
                @"map#setLanguage": [SetLanguage alloc],
                @"marker#clear": [ClearMarker alloc],
                @"map#setZoomLevel": [SetZoomLevel alloc],
                @"map#setPosition": [SetPosition alloc],
                @"map#setMapStatusLimits": [SetMapStatusLimits alloc],
                @"tool#convertCoordinate": [ConvertCoordinate alloc],
                @"offline#openOfflineManager": [OpenOfflineManager alloc],
                @"map#addPolyline": [AddPolyline alloc],
                @"map#zoomToSpan": [ZoomToSpan alloc],
                @"map#changeLatLng": [ChangeLatLng alloc],
        };
    }
    return _mapDictionary;
}

@end

static NSDictionary<NSString *, NSObject <SearchMethodHandler> *> *_searchDictionary;

@implementation SearchFunctionRegistry {

}
+ (NSDictionary<NSString *, NSObject <SearchMethodHandler> *> *)searchMethodHandler {
    if (!_searchDictionary) {
        _searchDictionary = @{
                @"search#calculateDriveRoute": [CalculateDriveRoute alloc],
                @"search#searchPoi": [SearchPoiKeyword alloc],
                @"search#searchPoiBound": [SearchPoiBound alloc],
                @"search#searchPoiPolygon": [SearchPoiPolygon alloc],
                @"search#searchPoiId": [SearchPoiId alloc],
                @"search#searchRoutePoiLine": [SearchRoutePoiLine alloc],
                @"search#searchRoutePoiPolygon": [SearchRoutePoiPolygon alloc],
                @"search#searchGeocode": [SearchGeocode alloc],
        };
    }
    return _searchDictionary;
}

@end

static NSDictionary<NSString *, NSObject <NaviMethodHandler> *> *_naviDictionary;

@implementation NaviFunctionRegistry {

}
+ (NSDictionary<NSString *, NSObject <NaviMethodHandler> *> *)naviMethodHandler {
    if (!_naviDictionary) {
        _naviDictionary = @{
                @"navi#startNavi": [StartNavi alloc],
        };
    }
    return _naviDictionary;
}

@end

static NSDictionary<NSString *, NSObject <LocationMethodHandler> *> *_locationDictionary;

@implementation LocationFunctionRegistry {

}
+ (NSDictionary<NSString *, NSObject <LocationMethodHandler> *> *)locationMethodHandler {
    if (!_locationDictionary) {
        _locationDictionary = @{
                @"location#init": [Init alloc],
                @"location#startLocate": [StartLocate alloc],
                @"location#stopLocate": [StopLocate alloc],
        };
    }
    return _locationDictionary;
}

@end
