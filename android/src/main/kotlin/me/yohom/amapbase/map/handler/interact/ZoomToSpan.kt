package me.yohom.amapbase.map.handler.interact

import com.amap.api.maps.AMap
import com.amap.api.maps.CameraUpdateFactory
import com.amap.api.maps.model.LatLng
import com.amap.api.maps.model.LatLngBounds
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import me.yohom.amapbase.MapMethodHandler
import me.yohom.amapbase.common.parseJson
import me.yohom.amapbase.map.success

object ZoomToSpan : MapMethodHandler {

    lateinit var map: AMap

    override fun with(map: AMap): ZoomToSpan {
        this.map = map
        return this
    }

    override fun onMethodCall(methodCall: MethodCall, methodResult: MethodChannel.Result) {
        val boundJson = methodCall.argument<String>("bound") ?: "[]"
        val padding = methodCall.argument<Int>("padding") ?: 80

        map.moveCamera(CameraUpdateFactory.newLatLngBounds(
                LatLngBounds.builder().run {
                    boundJson.parseJson<List<LatLng>>().forEach {
                        include(it)
                    }
                    build()
                },
                padding
        ))

        methodResult.success(success)
    }
}