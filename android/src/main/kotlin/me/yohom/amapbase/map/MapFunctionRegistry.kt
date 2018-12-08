package me.yohom.amapbase.map

import me.yohom.amapbase.map.handlers.calculatetool.ConvertCoordinate
import me.yohom.amapbase.map.handlers.createmap.*
import me.yohom.amapbase.map.handlers.draw.AddMarker
import me.yohom.amapbase.map.handlers.draw.AddMarkers
import me.yohom.amapbase.map.handlers.draw.ClearMarker
import me.yohom.amapbase.map.handlers.fetchdata.*
import me.yohom.amapbase.map.handlers.interact.SetMapStatusLimits
import me.yohom.amapbase.map.handlers.interact.SetPosition
import me.yohom.amapbase.map.handlers.interact.SetZoomLevel
import me.yohom.amapbase.map.handlers.routeplan.CalculateDriveRoute

val MAP_METHOD_HANDLER: Map<String, MapMethodHandler> = mapOf(
        "map#setMyLocationStyle" to SetMyLocationStyle,
        "map#setUiSettings" to SetUiSettings,
        "map#calculateDriveRoute" to CalculateDriveRoute,
        "marker#addMarker" to AddMarker,
        "marker#addMarkers" to AddMarkers,
        "marker#clear" to ClearMarker,
        "map#showIndoorMap" to ShowIndoorMap,
        "map#setMapType" to SetMapType,
        "map#setLanguage" to SetLanguage,
        "map#clear" to ClearMap,
        "map#searchPoi" to SearchPoi,
        "map#searchPoiBound" to SearchPoiBound,
        "map#searchPoiPolygon" to SearchPoiPolygon,
        "map#searchPoiId" to SearchPoiId,
        "map#searchRoutePoiLine" to SearchRoutePoiLine,
        "map#searchRoutePoiPolygon" to SearchRoutePoiPolygon,
        "map#setZoomLevel" to SetZoomLevel,
        "map#setPosition" to SetPosition,
        "map#setMapStatusLimits" to SetMapStatusLimits,
        "tool#convertCoordinate" to ConvertCoordinate
)
