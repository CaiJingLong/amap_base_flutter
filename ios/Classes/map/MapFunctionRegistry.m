//
// Created by Yohom Bao on 2018-12-08.
//

#import "MapFunctionRegistry.h"
#import "MapMethodHandler.h"
#import "ClearMap.h"
#import "SetMyLocationStyle.h"
#import "SetUiSettings.h"
#import "AMapSearchKit.h"
#import "CalculateDriveRoute.h"
#import "AddMarker.h"
#import "AddMarkers.h"
#import "ShowIndoorMap.h"
#import "SetMapType.h"
#import "SetLanguage.h"
#import "SearchPoiKeyword.h"
#import "SearchPoiBound.h"
#import "SearchPoiPolygon.h"
#import "SearchPoiId.h"
#import "SearchRoutePoiLine.h"
#import "SearchRoutePoiPolygon.h"
#import "ClearMarker.h"
#import "SetZoomLevel.h"
#import "SetPosition.h"
#import "SetMapStatusLimits.h"

static NSDictionary<NSString *, NSObject <MapMethodHandler> *> *_map;

@implementation MapFunctionRegistry {
}

+ (NSDictionary<NSString *, NSObject <MapMethodHandler> *> *)mapMethodHandler {
    if (!_map) {
        _map = @{
                @"map#clear": [ClearMap alloc],
                @"map#setMyLocationStyle": [SetMyLocationStyle alloc],
                @"map#setUiSettings": [SetUiSettings alloc],
                @"map#calculateDriveRoute": [CalculateDriveRoute alloc],
                @"marker#addMarker": [AddMarker alloc],
                @"marker#addMarkers": [AddMarkers alloc],
                @"map#showIndoorMap": [ShowIndoorMap alloc],
                @"map#setMapType": [SetMapType alloc],
                @"map#setLanguage": [SetLanguage alloc],
                @"map#searchPoi": [SearchPoiKeyword alloc],
                @"map#searchPoiBound": [SearchPoiBound alloc],
                @"map#searchPoiPolygon": [SearchPoiPolygon alloc],
                @"map#searchPoiId": [SearchPoiId alloc],
                @"map#searchRoutePoiLine": [SearchRoutePoiLine alloc],
                @"map#searchRoutePoiPolygon": [SearchRoutePoiPolygon alloc],
                @"marker#clear": [ClearMarker alloc],
                @"map#setZoomLevel": [SetZoomLevel alloc],
                @"map#setPosition": [SetPosition alloc],
                @"map#setMapStatusLimits": [SetMapStatusLimits alloc],
        };
    }
    return _map;
}

@end