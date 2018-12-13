package me.yohom.amapbase.map.handler.createmap

import com.amap.api.maps.AMap
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import me.yohom.amapbase.MapMethodHandler
import me.yohom.amapbase.common.log
import me.yohom.amapbase.map.success

object SetMapType : MapMethodHandler {

    lateinit var map: AMap

    override fun with(map: AMap): SetMapType {
        this.map = map
        return this
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val mapType = call.argument<Int>("mapType") ?: 1

        log("方法map#setMapType android端参数: mapType -> $mapType")

        map.mapType = mapType

        result.success(success)
    }
}