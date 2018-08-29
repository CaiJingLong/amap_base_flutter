package me.yohom.amapbase

import com.amap.api.maps.model.Marker

interface OnInfoWindowTappedListener {
    fun onInfoWindowTapped(marker: Marker)
}
