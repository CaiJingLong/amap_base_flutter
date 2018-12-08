package me.yohom.amapbase.map

import com.amap.api.maps.AMap
import io.flutter.plugin.common.MethodChannel

interface MapMethodHandler: MethodChannel.MethodCallHandler {
    fun with(map: AMap): MapMethodHandler
}