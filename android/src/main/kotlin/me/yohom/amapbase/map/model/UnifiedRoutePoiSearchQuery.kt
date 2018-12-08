package me.yohom.amapbase.map.model

import android.content.Context
import com.amap.api.maps.model.LatLng
import com.amap.api.services.routepoisearch.RoutePOISearch
import com.amap.api.services.routepoisearch.RoutePOISearchQuery
import me.yohom.amapbase.common.toLatLonPoint

class UnifiedRoutePoiSearchQuery(
        private val from: LatLng,
        private val to: LatLng,
        private val mode: Int,
        private val searchType: Int,
        private val range: Int,
        private val polylines: List<LatLng>
) {
    fun toRoutePoiSearchLine(context: Context): RoutePOISearch {
        return RoutePOISearch(
                context,
                RoutePOISearchQuery(
                        from.toLatLonPoint(),
                        to.toLatLonPoint(),
                        mode,
                        when (searchType) {
                            0 -> RoutePOISearch.RoutePOISearchType.TypeGasStation
                            1 -> RoutePOISearch.RoutePOISearchType.TypeMaintenanceStation
                            2 -> RoutePOISearch.RoutePOISearchType.TypeATM
                            3 -> RoutePOISearch.RoutePOISearchType.TypeToilet
                            4 -> RoutePOISearch.RoutePOISearchType.TypeFillingStation
                            5 -> RoutePOISearch.RoutePOISearchType.TypeServiceArea
                            else -> throw IllegalArgumentException()
                        },
                        range
                )
        )
    }

    fun toRoutePoiSearchPolygon(context: Context): RoutePOISearch {
        return RoutePOISearch(
                context,
                RoutePOISearchQuery(
                        polylines.map { it.toLatLonPoint() },
                        when (searchType) {
                            0 -> RoutePOISearch.RoutePOISearchType.TypeGasStation
                            1 -> RoutePOISearch.RoutePOISearchType.TypeMaintenanceStation
                            2 -> RoutePOISearch.RoutePOISearchType.TypeATM
                            3 -> RoutePOISearch.RoutePOISearchType.TypeToilet
                            4 -> RoutePOISearch.RoutePOISearchType.TypeFillingStation
                            5 -> RoutePOISearch.RoutePOISearchType.TypeServiceArea
                            else -> throw IllegalArgumentException()
                        },
                        range
                )
        )
    }
}