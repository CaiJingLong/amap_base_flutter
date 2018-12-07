package me.yohom.amapbase.map.handlers.interact

import com.amap.api.maps.AMap
import com.amap.api.maps.model.LatLng
import com.amap.api.maps.model.LatLngBounds
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import me.yohom.amapbase.map.MapMethodHandler
import me.yohom.amapbase.map.success
import me.yohom.amapbase.utils.parseJson

object SetMapStatusLimits : MapMethodHandler {

    lateinit var map: AMap

    override fun with(map: AMap): SetMapStatusLimits {
        this.map = map
        return this
    }

    override fun onMethodCall(methodCall: MethodCall, methodResult: MethodChannel.Result) {
        val swLatLng: LatLng? = methodCall.argument<String>("swLatLng")?.parseJson()
        val neLatLng: LatLng? = methodCall.argument<String>("neLatLng")?.parseJson()

        map.setMapStatusLimits(LatLngBounds(swLatLng, neLatLng))

        methodResult.success(success)
    }
}