package me.yohom.amapbase.search.model

import com.amap.api.services.routepoisearch.RoutePOIItem
import com.amap.api.services.routepoisearch.RoutePOISearchQuery
import com.amap.api.services.routepoisearch.RoutePOISearchResult
import me.yohom.amapbase.search.toLatLng

class UnifiedRoutePoiSearchResult(routePOISearchResult: RoutePOISearchResult) {
    private val routePoiList: List<UnifiedRoutePOIItem> = routePOISearchResult.routePois?.map { UnifiedRoutePOIItem(it) }
            ?: listOf()
    private val query: RoutePOISearchQuery = routePOISearchResult.query
}

private class UnifiedRoutePOIItem(poiItem: RoutePOIItem) {
    val id: String = poiItem.id
    val title: String = poiItem.title
    val point: LatLng? = poiItem.point?.toLatLng()
    val distance: Float = poiItem.distance
    val duration: Float = poiItem.duration
}