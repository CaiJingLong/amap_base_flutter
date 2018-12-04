package me.yohom.amapbase.map.model

import com.amap.api.maps.model.LatLng
import com.amap.api.services.core.PoiItem
import com.amap.api.services.core.SuggestionCity
import com.amap.api.services.poisearch.*
import me.yohom.amapbase.utils.toLatLng


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

private class UnifiedPoiItem(poiItem: PoiItem) {
    val businessArea: String? = poiItem.businessArea
    val adName: String? = poiItem.adName
    val cityName: String? = poiItem.cityName
    val provinceName: String? = poiItem.provinceName
    val typeDes: String? = poiItem.typeDes
    val tel: String? = poiItem.tel
    val adCode: String? = poiItem.adCode
    val poiId: String? = poiItem.poiId
    val distance: Int? = poiItem.distance
    val title: String? = poiItem.title
    val snippet: String? = poiItem.snippet
    val latLonPoint: LatLng? = poiItem.latLonPoint?.toLatLng()
    val cityCode: String? = poiItem.cityCode
    val enter: LatLng? = poiItem.enter?.toLatLng()
    val exit: LatLng? = poiItem.exit?.toLatLng()
    val website: String? = poiItem.website
    val postcode: String? = poiItem.postcode
    val email: String? = poiItem.email
    val direction: String? = poiItem.direction
    val isIndoorMap: Boolean? = poiItem.isIndoorMap
    val provinceCode: String? = poiItem.provinceCode
    val parkingType: String? = poiItem.parkingType
    val subPois: List<UnifiedSubPoiItem> = poiItem.subPois?.map { UnifiedSubPoiItem(it) }
            ?: listOf()
    val indoorData: UnifiedIndoorData? = if (poiItem.indoorData != null) UnifiedIndoorData(poiItem.indoorData) else null
    val photos: List<UnifiedPhoto> = poiItem.photos?.map { UnifiedPhoto(it) } ?: listOf()
    val poiExtension: UnifiedPoiItemExtension? = if (poiItem.poiExtension != null) UnifiedPoiItemExtension(poiItem.poiExtension) else null
    val typeCode: String? = poiItem.typeCode
    val shopID: String? = poiItem.shopID
}

private class UnifiedSubPoiItem(subPoiItem: SubPoiItem) {
    val poiId: String? = subPoiItem.poiId
    val title: String? = subPoiItem.title
    val subName: String? = subPoiItem.subName
    val distance: Int? = subPoiItem.distance
    val latLonPoint: LatLng? = subPoiItem.latLonPoint?.toLatLng()
    val snippet: String? = subPoiItem.snippet
    val subTypeDes: String? = subPoiItem.subTypeDes
}

private class UnifiedIndoorData(indoorData: IndoorData) {
    val poiId: String? = indoorData.poiId
    val floor: Int? = indoorData.floor
    val floorName: String? = indoorData.floorName
}

private class UnifiedPhoto(photo: Photo) {
    val title: String? = photo.title
    val url: String? = photo.url
}

private class UnifiedPoiItemExtension(poiItemExtension: PoiItemExtension) {
    val opentime: String? = poiItemExtension.opentime
    val rating: String? = poiItemExtension.getmRating()
}

private class UnifiedSuggestionCity(suggestionCity: SuggestionCity) {
    val cityName: String? = suggestionCity.cityName
    val cityCode: String? = suggestionCity.cityCode
    val adCode: String? = suggestionCity.adCode
    val suggestionNum: Int? = suggestionCity.suggestionNum
}