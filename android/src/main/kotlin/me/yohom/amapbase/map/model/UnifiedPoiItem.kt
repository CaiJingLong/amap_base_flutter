package me.yohom.amapbase.map.model

import com.amap.api.maps.model.LatLng
import com.amap.api.services.core.PoiItem
import me.yohom.amapbase.utils.toLatLng

class UnifiedPoiItem(poiItem: PoiItem) {
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