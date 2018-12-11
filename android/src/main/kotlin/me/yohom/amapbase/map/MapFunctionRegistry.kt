package me.yohom.amapbase.map

import me.yohom.amapbase.map.handler.calculatetool.ConvertCoordinate
import me.yohom.amapbase.map.handler.createmap.*
import me.yohom.amapbase.map.handler.draw.AddMarker
import me.yohom.amapbase.map.handler.draw.AddMarkers
import me.yohom.amapbase.map.handler.draw.AddPolyline
import me.yohom.amapbase.map.handler.draw.ClearMarker
import me.yohom.amapbase.map.handler.interact.SetMapStatusLimits
import me.yohom.amapbase.map.handler.interact.SetPosition
import me.yohom.amapbase.map.handler.interact.SetZoomLevel

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
        "map#addPolyline" to AddPolyline
)
