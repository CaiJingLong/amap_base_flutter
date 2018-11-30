package me.yohom.amapbase.utils

import com.amap.api.maps.model.LatLng
import com.amap.api.services.core.LatLonPoint

fun LatLng.toLatLonPoint(): LatLonPoint {
    return LatLonPoint(latitude, longitude)
}