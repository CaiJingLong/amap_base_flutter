package me.yohom.amapbase

import com.amap.api.maps.model.CameraPosition

interface OnCameraMoveListener {
    fun onCameraMoveStarted(isGesture: Boolean)

    fun onCameraMove(newPosition: CameraPosition)

    fun onCameraIdle()
}
