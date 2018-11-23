package me.yohom.amapbase.map

import com.amap.api.maps.model.Marker

interface OnMarkerTappedListener {
    fun onMarkerTapped(marker: Marker)
}
