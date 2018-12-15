package me.yohom.amapbase

import me.yohom.amapbase.map.handler.calculatetool.ConvertCoordinate
import me.yohom.amapbase.map.handler.createmap.*
import me.yohom.amapbase.map.handler.draw.AddMarker
import me.yohom.amapbase.map.handler.draw.AddMarkers
import me.yohom.amapbase.map.handler.draw.AddPolyline
import me.yohom.amapbase.map.handler.draw.ClearMarker
import me.yohom.amapbase.map.handler.interact.*
import me.yohom.amapbase.navi.handler.StartNavi
import me.yohom.amapbase.search.handler.fetchdata.*
import me.yohom.amapbase.search.handler.routeplan.CalculateDriveRoute

import me.yohom.amapbase.location.handler.Init
import me.yohom.amapbase.location.handler.StartLocate
import me.yohom.amapbase.location.handler.StopLocate

/**
 * 地图功能集合
 */
val MAP_METHOD_HANDLER: Map<String, MapMethodHandler> = mapOf(
        "map#setMyLocationStyle" to SetMyLocationStyle,
        "map#setUiSettings" to SetUiSettings,
        "marker#addMarker" to AddMarker,
        "marker#addMarkers" to AddMarkers,
        "marker#clear" to ClearMarker,
        "map#showIndoorMap" to ShowIndoorMap,
        "map#setMapType" to SetMapType,
        "map#setLanguage" to SetLanguage,
        "map#clear" to ClearMap,
        "map#setZoomLevel" to SetZoomLevel,
        "map#setPosition" to SetPosition,
        "map#setMapStatusLimits" to SetMapStatusLimits,
        "tool#convertCoordinate" to ConvertCoordinate,
        "offline#openOfflineManager" to OpenOfflineManager,
        "map#addPolyline" to AddPolyline,
        "map#zoomToSpan" to ZoomToSpan,
        "map#changeLatLng" to ChangeLatLng
)

/**
 * 搜索功能集合
 */
val SEARCH_METHOD_HANDLER: Map<String, SearchMethodHandler> = mapOf(
        "search#calculateDriveRoute" to CalculateDriveRoute,
        "search#searchPoi" to SearchPoiKeyword,
        "search#searchPoiBound" to SearchPoiBound,
        "search#searchPoiPolygon" to SearchPoiPolygon,
        "search#searchPoiId" to SearchPoiId,
        "search#searchRoutePoiLine" to SearchRoutePoiLine,
        "search#searchRoutePoiPolygon" to SearchRoutePoiPolygon,
        "search#searchGeocode" to SearchGeocode
)

/**
 * 导航功能集合
 */
val NAVI_METHOD_HANDLER: Map<String, NaviMethodHandler> = mapOf(
        "navi#startNavi" to StartNavi
)

/**
 * 定位功能集合
 */
val LOCATION_METHOD_HANDLER: Map<String, LocationMethodHandler> = mapOf(
        "location#init" to Init,
        "location#startLocate" to StartLocate,
        "location#stopLocate" to StopLocate
)
