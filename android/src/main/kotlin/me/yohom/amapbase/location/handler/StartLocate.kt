package me.yohom.amapbase.location.handler

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import me.yohom.amapbase.LocationMethodHandler
import me.yohom.amapbase.common.log
import me.yohom.amapbase.common.parseJson
import me.yohom.amapbase.location.handler.Init.locationClient
import me.yohom.amapbase.location.model.UnifiedLocationClientOptions

object StartLocate : LocationMethodHandler {

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val optionJson = call.argument<String>("options")?: "{}"

        log("startLocate android端: options.toJsonString() -> $optionJson")

        locationClient.setLocationOption(optionJson.parseJson<UnifiedLocationClientOptions>().toLocationClientOptions())
        locationClient.startLocation()
        result.success("开始定位")
    }
}