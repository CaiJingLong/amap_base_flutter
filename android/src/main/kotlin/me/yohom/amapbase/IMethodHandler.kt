package me.yohom.amapbase

import com.amap.api.maps.AMap
import io.flutter.plugin.common.MethodChannel

interface SearchMethodHandler : MethodChannel.MethodCallHandler

interface MapMethodHandler: MethodChannel.MethodCallHandler {
    fun with(map: AMap): MapMethodHandler
}