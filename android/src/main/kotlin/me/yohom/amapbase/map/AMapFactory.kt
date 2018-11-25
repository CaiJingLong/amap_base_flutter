package me.yohom.amapbase.map

import android.content.Context
import android.view.View
import com.amap.api.maps.TextureMapView
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class AMapFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, id: Int, params: Any?): PlatformView {
        val view = AMapView(context)
        view.init()
        return view
    }
}

class AMapView(context: Context) : PlatformView {
    private val mapView = TextureMapView(context)

    fun init() {
        mapView.onCreate(null)
    }

    override fun getView(): View = mapView

    override fun dispose() {}
}