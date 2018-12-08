package me.yohom.amapbase.map.handlers.draw

import com.amap.api.maps.AMap
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import me.yohom.amapbase.map.MapMethodHandler
import me.yohom.amapbase.map.model.UnifiedMarkerOptions
import me.yohom.amapbase.map.success
import me.yohom.amapbase.common.log
import me.yohom.amapbase.common.parseJson

object AddMarker : MapMethodHandler {

    lateinit var map: AMap

    override fun with(map: AMap): AddMarker {
        this.map = map
        return this
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val optionsJson = call.argument<String>("markerOptions") ?: "{}"

        log("方法marker#addMarker android端参数: optionsJson -> $optionsJson")

        optionsJson.parseJson<UnifiedMarkerOptions>().applyTo(map)

        result.success(success)
    }
}