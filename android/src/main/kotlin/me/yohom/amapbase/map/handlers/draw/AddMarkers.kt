package me.yohom.amapbase.map.handlers.draw

import com.amap.api.maps.AMap
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import me.yohom.amapbase.map.MapMethodHandler
import me.yohom.amapbase.map.model.UnifiedMarkerOptions
import me.yohom.amapbase.map.success
import me.yohom.amapbase.common.log
import me.yohom.amapbase.common.parseJson
import java.util.*

object AddMarkers : MapMethodHandler {

    lateinit var map: AMap

    override fun with(map: AMap): AddMarkers {
        this.map = map
        return this
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val moveToCenter = call.argument<Boolean>("moveToCenter") ?: true
        val optionsListJson = call.argument<String>("markerOptionsList") ?: "[]"
        val clear = call.argument<Boolean>("clear") ?: false

        log("方法marker#addMarkers android端参数: optionsListJson -> $optionsListJson")

        val optionsList = ArrayList(optionsListJson.parseJson<List<UnifiedMarkerOptions>>().map { it.toMarkerOption() })
        if (clear) map.mapScreenMarkers.forEach { it.remove() }
        map.addMarkers(optionsList, moveToCenter)

        result.success(success)
    }
}