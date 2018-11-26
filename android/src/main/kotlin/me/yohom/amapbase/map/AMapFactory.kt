package me.yohom.amapbase.map

import android.content.Context
import android.view.View
import com.amap.api.maps.AMapOptions
import com.amap.api.maps.TextureMapView
import com.google.gson.Gson
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class AMapFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, id: Int, params: Any?): PlatformView {
        val amapOptions = Gson().fromJson(params as String, AMapOptions::class.java)

        val view = AMapView(context, amapOptions)
        view.init()
        return view
    }
}

class AMapView(context: Context, amapOptions: AMapOptions) : PlatformView {
    private val mapView = TextureMapView(context, amapOptions)

    fun init() {
        mapView.onCreate(null)
    }

    override fun getView(): View = mapView

    override fun dispose() {}
}