package me.yohom.amapbase.map

import android.content.Context
import android.view.View
import com.amap.api.maps.AMapOptions
import com.amap.api.maps.TextureMapView
import com.google.gson.Gson
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import me.yohom.amapbase.AmapBasePlugin

const val mapChannelName = "me.yohom/map"

class AMapFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, id: Int, params: Any?): PlatformView {
        val amapOptions = Gson()
                .fromJson(params as String, AMapOptionsLike::class.java)
                .toAMapOption()

        val view = AMapView(context, amapOptions, id)
        view.setup()
        return view
    }
}

class AMapView(context: Context, amapOptions: AMapOptions, private val id: Int) : PlatformView {
    private val mapView = TextureMapView(context, amapOptions)

    fun setup() {
        mapView.onCreate(null)
        setupMapChannel()
    }

    private fun setupMapChannel() {
        val mapChannel = MethodChannel(AmapBasePlugin.registrar.messenger(), "${mapChannelName}_$id")
        mapChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                else -> result.notImplemented()
            }
        }
    }

    override fun getView(): View = mapView

    override fun dispose() {}
}