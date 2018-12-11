package me.yohom.amapbase.map.handler.calculatetool

import com.amap.api.maps.AMap
import com.amap.api.maps.CoordinateConverter
import com.amap.api.maps.model.LatLng
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import me.yohom.amapbase.AMapBasePlugin.Companion.registrar
import me.yohom.amapbase.common.toJson
import me.yohom.amapbase.map.MapMethodHandler

private val types = arrayListOf(
        CoordinateConverter.CoordType.GPS,
        CoordinateConverter.CoordType.BAIDU,
        CoordinateConverter.CoordType.MAPBAR,
        CoordinateConverter.CoordType.MAPABC,
        CoordinateConverter.CoordType.SOSOMAP,
        CoordinateConverter.CoordType.ALIYUN,
        CoordinateConverter.CoordType.GOOGLE
)

object ConvertCoordinate : MapMethodHandler {

    lateinit var map: AMap

    override fun with(map: AMap): ConvertCoordinate {
        this.map = map
        return this
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val lat = call.argument<Double>("lat")!!
        val lon = call.argument<Double>("lon")!!
        val typeIndex = call.argument<Int>("type")!!
        val amapCoordinate = CoordinateConverter(registrar.context())
                .from(types[typeIndex])
                .coord(LatLng(lat, lon, false))
                .convert()

        result.success(amapCoordinate.toJson())
    }
}