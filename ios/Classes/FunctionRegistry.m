//
// Created by Yohom Bao on 2018-12-12.
//

#import "FunctionRegistry.h"
#import "IMethodHandler.h"
#import "CalculateDriveRoute.h"
#import "SearchPoiKeyword.h"
#import "SearchPoiBound.h"
#import "SearchPoiPolygon.h"
#import "SearchPoiId.h"
#import "SearchRoutePoiLine.h"
#import "SearchRoutePoiPolygon.h"
#import "ClearMap.h"
#import "SetMyLocationStyle.h"
#import "SetUiSettings.h"
#import "AddMarker.h"
#import "AddMarkers.h"
#import "ShowIndoorMap.h"
#import "SetMapType.h"
#import "SetLanguage.h"
#import "ClearMarker.h"
#import "SetZoomLevel.h"
#import "SetPosition.h"
#import "SetMapStatusLimits.h"
#import "ConvertCoordinate.h"
#import "OpenOfflineManager.h"
#import "AddPolyline.h"


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
        };
    }
    return _searchDictionary;
}

@end