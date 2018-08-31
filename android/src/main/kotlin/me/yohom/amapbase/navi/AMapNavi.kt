package me.yohom.amapbase.navi

import com.amap.api.maps.model.LatLng
import com.amap.api.maps.model.Poi
import com.amap.api.navi.AmapNaviPage
import com.amap.api.navi.AmapNaviParams
import com.amap.api.navi.AmapNaviType
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

private const val channel = "me.yohom/amap_navi"
private const val startNavi = "startNavi"
private const val setKey = "setKey"

fun PluginRegistry.Registrar.setupNaviChannel() {
    val channel = MethodChannel(messenger(), channel)
    channel.setMethodCallHandler { call, result ->
        when (call.method) {
            startNavi -> {
                val lat = call.argument<Double>("lat")
                val lon = call.argument<Double>("lon")
                val end = Poi(null, LatLng(lat, lon), "")
                AmapNaviPage.getInstance().showRouteActivity(
                        activity(),
                        AmapNaviParams(null, null, end, AmapNaviType.DRIVER),
                        null
                )
            }
            setKey -> result.success("android端需要在Manifest里配置key")
            else -> result.notImplemented()
        }
    }
}