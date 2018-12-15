package me.yohom.amapbase.location.handler

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import me.yohom.amapbase.LocationMethodHandler
import me.yohom.amapbase.common.log
import me.yohom.amapbase.location.handler.Init.locationClient

object StopLocate : LocationMethodHandler {

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        locationClient.stopLocation()
        log("停止定位")
        result.success("停止定位")
    }
}