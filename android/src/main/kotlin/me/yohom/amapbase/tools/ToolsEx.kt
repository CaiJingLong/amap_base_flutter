package me.yohom.amapbase.tools

import com.amap.api.maps.CoordinateConverter
import com.amap.api.maps.model.LatLng
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

/// create 2018/12/6 by caijinglong


private const val channel = "me.yohom/tools"
private const val convert = "convert"


fun PluginRegistry.Registrar.setupToolsChannel() {
    val channel = MethodChannel(messenger(), channel)
    channel.setMethodCallHandler { call, result ->
        when (call.method) {
            convert -> {
                val lat = call.argument<Double>("lat")!!
                val lon = call.argument<Double>("lon")!!
                val intType = call.argument<Int>("type")!!
                val coordType = types[intType]
                val convertedLatlng = CoordinateConverter(activity())
                        .from(coordType)
                        .coord(LatLng(lat, lon,false))
                        .convert()

                result.success("""{"latitude":${convertedLatlng.latitude},"longitude":${convertedLatlng.longitude}}""")
            }
            else -> result.notImplemented()
        }
    }
}

private val types = arrayListOf(
        CoordinateConverter.CoordType.GPS,
        CoordinateConverter.CoordType.BAIDU,
        CoordinateConverter.CoordType.MAPBAR,
        CoordinateConverter.CoordType.MAPABC,
        CoordinateConverter.CoordType.SOSOMAP,
        CoordinateConverter.CoordType.ALIYUN,
        CoordinateConverter.CoordType.GOOGLE
)