package me.yohom.amapbase

import me.yohom.amapbase.search.*

/**
 * 地图功能集合
 */
val MAP_METHOD_HANDLER: Map<String, MapMethodHandler> = mapOf(
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
)

/**
 * 定位功能集合
 */
val LOCATION_METHOD_HANDLER: Map<String, LocationMethodHandler> = mapOf()
