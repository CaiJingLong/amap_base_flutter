package me.yohom.amapbase

import me.yohom.amapbase.map.*

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
)

/**
 * 导航功能集合
 */
val NAVI_METHOD_HANDLER: Map<String, NaviMethodHandler> = mapOf(
)

/**
 * 定位功能集合
 */
val LOCATION_METHOD_HANDLER: Map<String, LocationMethodHandler> = mapOf()
