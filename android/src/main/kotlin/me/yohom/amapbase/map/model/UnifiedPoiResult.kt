package me.yohom.amapbase.map.model

import com.amap.api.maps.model.LatLng
import com.amap.api.services.core.SuggestionCity
import com.amap.api.services.poisearch.*
import me.yohom.amapbase.common.toLatLng


class UnifiedPoiResult(poiResult: PoiResult) {
    val pageCount: Int? = poiResult.pageCount
    /**
     * 暂未支持
     */
    val query: PoiSearch.Query = poiResult.query
    private val bound: UnifiedSearchBound? = if (poiResult.bound != null) UnifiedSearchBound(poiResult.bound) else null
    private val pois: List<UnifiedPoiItem> = poiResult.pois?.map { UnifiedPoiItem(it) } ?: listOf()
    private val searchSuggestionKeywords: List<String> = poiResult.searchSuggestionKeywords
            ?: listOf()
    private val searchSuggestionCitys: List<UnifiedSuggestionCity> = poiResult.searchSuggestionCitys?.map { UnifiedSuggestionCity(it) }
            ?: listOf()
}

class UnifiedSubPoiItem(subPoiItem: SubPoiItem) {
    val poiId: String? = subPoiItem.poiId
    val title: String? = subPoiItem.title
    val subName: String? = subPoiItem.subName
    val distance: Int? = subPoiItem.distance
    val latLonPoint: LatLng? = subPoiItem.latLonPoint?.toLatLng()
    val snippet: String? = subPoiItem.snippet
    val subTypeDes: String? = subPoiItem.subTypeDes
}

class UnifiedIndoorData(indoorData: IndoorData) {
    val poiId: String? = indoorData.poiId
    val floor: Int? = indoorData.floor
    val floorName: String? = indoorData.floorName
}

class UnifiedPhoto(photo: Photo) {
    val title: String? = photo.title
    val url: String? = photo.url
}

class UnifiedPoiItemExtension(poiItemExtension: PoiItemExtension) {
    val opentime: String? = poiItemExtension.opentime
    val rating: String? = poiItemExtension.getmRating()
}

class UnifiedSuggestionCity(suggestionCity: SuggestionCity) {
    val cityName: String? = suggestionCity.cityName
    val cityCode: String? = suggestionCity.cityCode
    val adCode: String? = suggestionCity.adCode
    val suggestionNum: Int? = suggestionCity.suggestionNum
}