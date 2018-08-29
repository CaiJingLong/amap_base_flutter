package me.yohom.amapbase

import com.amap.api.maps.model.Marker

interface OnMarkerTappedListener {
    fun onMarkerTapped(marker: Marker)
}
