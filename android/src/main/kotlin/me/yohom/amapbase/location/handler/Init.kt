package me.yohom.amapbase.location.handler

import android.annotation.SuppressLint
import com.amap.api.location.AMapLocationClient
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import me.yohom.amapbase.AMapBasePlugin.Companion.registrar
import me.yohom.amapbase.LocationMethodHandler
import me.yohom.amapbase.common.toJson
import me.yohom.amapbase.location.model.UnifiedAMapLocation


object Init : LocationMethodHandler {
    @SuppressLint("StaticFieldLeak")
    lateinit var locationClient: AMapLocationClient

    private val locationEventChannel = EventChannel(registrar.messenger(), "me.yohom/location_event")
    private var eventSink: EventChannel.EventSink? = null

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        locationEventChannel.setStreamHandler(object : EventChannel.StreamHandler{
            override fun onListen(p0: Any?, sink: EventChannel.EventSink?) {
                eventSink = sink
            }

            override fun onCancel(p0: Any?) {

            }
        })

        locationClient = AMapLocationClient(registrar.activity().applicationContext).apply {
            setLocationListener {
                eventSink?.success(UnifiedAMapLocation(it).toJson())
            }
        }
        result.success("初始化成功")
    }
}