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

fun PluginRegistry.Registrar.setupNaviChannel() {
    val channel = MethodChannel(messenger(), channel)
    channel.setMethodCallHandler { call, result ->
        when (call.method) {
            startNavi -> {
                val lat = call.argument<Double>("lat")!!
                val lon = call.argument<Double>("lon")!!
                val naviType = call.argument<Int>("naviType") ?: AmapNaviType.DRIVER

                val end = Poi(null, LatLng(lat, lon), "")
                AmapNaviPage.getInstance().showRouteActivity(
                        activity(),
                        AmapNaviParams(null, null, end, when (naviType) {
                            0 -> AmapNaviType.DRIVER
                            1 -> AmapNaviType.WALK
                            2 -> AmapNaviType.RIDE
                            else -> AmapNaviType.DRIVER
                        }),
                        null
                )
            }
            else -> result.notImplemented()
        }
    }
}