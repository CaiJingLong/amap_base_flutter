package me.yohom.amapbase.map.model

import com.amap.api.maps.model.LatLng

class RoutePlanParam(
        val from: LatLng,
        val to: LatLng,
        val mode: Int,
        val passedByPoints: List<LatLng>?,
        val avoidPolygons: List<List<LatLng>>?,
        val avoidRoad: String?
) {
    override fun toString(): String {
        return "RoutePlanParam(from=$from, to=$to, mode=$mode, passedByPoints=$passedByPoints, avoidPolygons=$avoidPolygons, avoidRoad='$avoidRoad')"
    }
}