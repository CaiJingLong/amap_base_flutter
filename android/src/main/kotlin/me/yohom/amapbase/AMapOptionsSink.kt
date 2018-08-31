package me.yohom.amapbase

import com.amap.api.maps.model.CameraPosition

interface AMapOptionsSink {
    fun setCameraPosition(position: CameraPosition)

    fun setCompassEnabled(compassEnabled: Boolean)

    fun setMapType(mapType: Int)

    fun setMinMaxZoomPreference(min: Float?, max: Float?)

    fun setRotateGesturesEnabled(rotateGesturesEnabled: Boolean)

    fun setScrollGesturesEnabled(scrollGesturesEnabled: Boolean)

    fun setTiltGesturesEnabled(tiltGesturesEnabled: Boolean)

    fun setTrackCameraPosition(trackCameraPosition: Boolean)

    fun setZoomGesturesEnabled(zoomGesturesEnabled: Boolean)
}
