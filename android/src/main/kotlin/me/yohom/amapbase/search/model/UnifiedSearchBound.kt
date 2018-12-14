package me.yohom.amapbase.search.model

import com.amap.api.services.poisearch.PoiSearch
import me.yohom.amapbase.search.toLatLng
import me.yohom.amapbase.search.toLatLonPoint

class UnifiedSearchBound(searchBound: PoiSearch.SearchBound) {
    val lowerLeft: LatLng? = searchBound.lowerLeft?.toLatLng()
    val upperRight: LatLng? = searchBound.upperRight?.toLatLng()
    private val center: LatLng? = searchBound.center?.toLatLng()
    private val range: Int? = searchBound.range
    val shape: String? = searchBound.shape
    val isDistanceSort: Boolean? = searchBound.isDistanceSort
    private val polyGonList: List<LatLng> = searchBound.polyGonList?.map { it.toLatLng() } ?: listOf()

    /**
     * 中心点 + 半径范围
     */
    fun toSearchBoundCenterRange(): PoiSearch.SearchBound {
        return PoiSearch.SearchBound(center?.toLatLonPoint(), range!!)
    }

    /**
     * 多边形搜索
     */
    fun toSearchBoundPolygon(): PoiSearch.SearchBound {
        return PoiSearch.SearchBound(polyGonList.map { it.toLatLonPoint() })
    }
}