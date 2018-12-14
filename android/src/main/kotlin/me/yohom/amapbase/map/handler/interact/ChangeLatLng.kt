package me.yohom.amapbase.map.handler.interact

import com.amap.api.maps.AMap
import com.amap.api.maps.CameraUpdateFactory
import com.amap.api.maps.model.LatLng
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import me.yohom.amapbase.MapMethodHandler
import me.yohom.amapbase.common.parseJson
import me.yohom.amapbase.map.success

object ChangeLatLng : MapMethodHandler {

    lateinit var map: AMap

    override fun with(map: AMap): ChangeLatLng {
        this.map = map
        return this
    }

    override fun onMethodCall(methodCall: MethodCall, methodResult: MethodChannel.Result) {
        val targetJson = methodCall.argument<String>("target") ?: "{}"

        map.animateCamera(CameraUpdateFactory.changeLatLng(targetJson.parseJson<LatLng>()))

        methodResult.success(success)
    }
}