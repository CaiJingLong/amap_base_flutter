package me.yohom.amapbase.map.model

import com.amap.api.maps.model.LatLng

class RoutePlanParam(
        /// 起点
        val from: LatLng,
        /// 终点
        val to: LatLng,
        /// 计算路径的模式，可选，默认为速度优先=0
        val mode: Int,
        /// 途经点，可选
        val passedByPoints: List<LatLng>?,
        /// 避让区域，可选，支持32个避让区域，每个区域最多可有16个顶点。如果是四边形则有4个坐标点，如果是五边形则有5个坐标点
        val avoidPolygons: List<List<LatLng>>?,
        /// 避让道路，只支持一条避让道路，避让区域和避让道路同时设置，只有避让道路生效
        val avoidRoad: String?
) {
    override fun toString(): String {
        return "RoutePlanParam(from=$from, to=$to, mode=$mode, passedByPoints=$passedByPoints, avoidPolygons=$avoidPolygons, avoidRoad='$avoidRoad')"
    }
}