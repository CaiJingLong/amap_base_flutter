package me.yohom.amapbase.search.model

import com.amap.api.services.geocoder.GeocodeAddress
import com.amap.api.services.geocoder.GeocodeQuery
import com.amap.api.services.geocoder.GeocodeResult
import me.yohom.amapbase.search.toLatLng

class UnifiedGeocodeResult(geocodeResult: GeocodeResult) {
    val geocodeQuery: UnifiedGeocodeQuery = UnifiedGeocodeQuery(geocodeResult.geocodeQuery)
    val geocodeAddressList: List<UnifiedGeocodeAddress> = geocodeResult.geocodeAddressList.map { UnifiedGeocodeAddress(it) }
}

class UnifiedGeocodeAddress(geocodeAddress: GeocodeAddress) {
    val formatAddress: String = geocodeAddress.formatAddress
    val province: String = geocodeAddress.province
    val city: String = geocodeAddress.city
    val district: String = geocodeAddress.district
    val township: String = geocodeAddress.township
    val neighborhood: String = geocodeAddress.neighborhood
    val building: String = geocodeAddress.building
    val adcode: String = geocodeAddress.adcode
    val latLng: LatLng = geocodeAddress.latLonPoint.toLatLng()
    val level: String = geocodeAddress.level
}

class UnifiedGeocodeQuery(geocodeQuery: GeocodeQuery) {
    val locationName: String = geocodeQuery.locationName
    val city: String = geocodeQuery.city
}