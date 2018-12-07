package me.yohom.amapbase.map.handlers.createmap

import com.amap.api.maps.AMap
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import me.yohom.amapbase.map.MapMethodHandler
import me.yohom.amapbase.map.model.UnifiedUiSettings
import me.yohom.amapbase.map.success
import me.yohom.amapbase.utils.log
import me.yohom.amapbase.utils.parseJson

object SetUiSettings : MapMethodHandler {

    lateinit var map: AMap

    override fun with(map: AMap): SetUiSettings {
        this.map = map
        return this
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val uiSettingsJson = call.argument<String>("uiSettings") ?: "{}"

        log("方法setUiSettings android端参数: uiSettingsJson -> $uiSettingsJson")

        uiSettingsJson.parseJson<UnifiedUiSettings>().applyTo(map)

        result.success(success)
    }
}