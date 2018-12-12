package me.yohom.amapbase.map.handler.draw

import com.amap.api.maps.AMap
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import me.yohom.amapbase.MapMethodHandler
import me.yohom.amapbase.common.log
import me.yohom.amapbase.common.parseJson
import me.yohom.amapbase.map.model.UnifiedRouteOverlay
import me.yohom.amapbase.map.success

object AddRouteOverlay : MapMethodHandler {

    lateinit var map: AMap

    override fun with(map: AMap): AddRouteOverlay {
        this.map = map
        return this
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val overlayJson = call.argument<String>("overlay") ?: "{}"

        log("方法map#addRouteOverlay android端参数: overlayJson -> $overlayJson")

        overlayJson.parseJson<UnifiedRouteOverlay>().applyTo(map)

        result.success(success)
    }
}