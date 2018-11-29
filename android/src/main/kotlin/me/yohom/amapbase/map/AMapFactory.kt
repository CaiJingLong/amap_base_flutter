package me.yohom.amapbase.map

import android.content.Context
import android.view.View
import com.amap.api.maps.AMapOptions
import com.amap.api.maps.TextureMapView
import com.google.gson.Gson
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import me.yohom.amapbase.AMapBasePlugin
import me.yohom.amapbase.map.model.UnifiedAMapOptions
import me.yohom.amapbase.map.model.UnifiedMyLocationStyle
import me.yohom.amapbase.map.model.UnifiedUiSettings
import me.yohom.amapbase.utils.Jsons
import me.yohom.amapbase.utils.log


const val mapChannelName = "me.yohom/map"

class AMapFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, id: Int, params: Any?): PlatformView {
        val options = Gson()
                .fromJson(params as String, UnifiedAMapOptions::class.java)

        val view = AMapView(context, options.toAMapOption(), id)
        view.setup()
        return view
    }
}

class AMapView(context: Context,
               amapOptions: AMapOptions,
               private val id: Int) : PlatformView {

    private val mapView = TextureMapView(context, amapOptions)

    fun setup() {
        mapView.onCreate(null)
        val mapChannel = MethodChannel(AMapBasePlugin.registrar.messenger(), "$mapChannelName$id")
        mapChannel.setMethodCallHandler { call, result ->
            handleMethodCall(call, result)
        }
    }

    private fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val map = mapView.map
        when (call.method) {
            "map#setMyLocationStyle" -> {
                val styleJson = call.argument<String>("myLocationStyle") ?: "{}"

                log("方法setMyLocationEnabled android端参数: styleJson -> $styleJson")

                Jsons.fromJson<UnifiedMyLocationStyle>(styleJson).applyTo(map)
            }
            "map#setUiSettings" -> {
                val uiSettingsJson = call.argument<String>("uiSettings") ?: "{}"

                log("方法setUiSettings android端参数: _uiSettings -> $uiSettingsJson")

                Jsons.fromJson<UnifiedUiSettings>(uiSettingsJson).applyTo(map)
            }
            else -> result.notImplemented()
        }
    }

    override fun getView(): View = mapView

    override fun dispose() {
        mapView.onPause()
        mapView.onDestroy()
    }
}