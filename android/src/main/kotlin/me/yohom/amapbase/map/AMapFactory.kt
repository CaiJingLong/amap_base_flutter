package me.yohom.amapbase.map

import android.annotation.SuppressLint
import android.app.Activity
import android.app.Application
import android.content.Context
import android.os.Bundle
import android.view.View
import com.amap.api.maps.AMapOptions
import com.amap.api.maps.TextureMapView
import com.google.gson.Gson
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import me.yohom.amapbase.*
import me.yohom.amapbase.AMapBasePlugin.Companion.registrar
import me.yohom.amapbase.common.checkPermission
import me.yohom.amapbase.common.toJson
import me.yohom.amapbase.map.model.UnifiedAMapOptions
import me.yohom.amapbase.map.model.UnifiedMarkerOptions
import java.util.concurrent.atomic.AtomicInteger

const val mapChannelName = "me.yohom/map"
const val markerClickedChannelName = "me.yohom/marker_clicked"
const val success = "调用成功"

class AMapFactory(private val activityState: AtomicInteger)
    : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, id: Int, params: Any?): PlatformView {
        checkPermission()

        val options = Gson()
                .fromJson(params as String, UnifiedAMapOptions::class.java)

        val view = AMapView(context, id, activityState, options.toAMapOption())
        view.setup()
        return view
    }
}

@SuppressLint("CheckResult")
class AMapView(context: Context,
               private val id: Int,
               private val activityState: AtomicInteger,
               amapOptions: AMapOptions) : PlatformView, Application.ActivityLifecycleCallbacks {

    private val mapView = TextureMapView(context, amapOptions)
    private var disposed = false
    private val registrarActivityHashCode: Int = AMapBasePlugin.registrar.activity().hashCode()

    override fun getView(): View = mapView

    override fun dispose() {
        if (disposed) {
            return
        }
        disposed = true
        mapView.onDestroy()

        registrar.activity().application.unregisterActivityLifecycleCallbacks(this)
    }

    fun setup() {
        when (activityState.get()) {
            STOPPED -> {
                mapView.onCreate(null)
                mapView.onResume()
                mapView.onPause()
            }
            RESUMED -> {
                mapView.onCreate(null)
                mapView.onResume()
            }
            CREATED -> mapView.onCreate(null)
            DESTROYED -> {
            }
            else -> throw IllegalArgumentException("Cannot interpret " + activityState.get() + " as an activity activityState")
        }

        // 地图相关method channel
        val mapChannel = MethodChannel(registrar.messenger(), "$mapChannelName$id")
        mapChannel.setMethodCallHandler { call, result ->
            checkPermission()

            MAP_METHOD_HANDLER[call.method]
                    ?.with(mapView.map)
                    ?.onMethodCall(call, result) ?: result.notImplemented()
        }

        // marker click event channel
        var eventSink: EventChannel.EventSink? = null
        val markerClickedEventChannel = EventChannel(registrar.messenger(), "$markerClickedChannelName$id")
        markerClickedEventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(p0: Any?, sink: EventChannel.EventSink?) {
                eventSink = sink
            }

            override fun onCancel(p0: Any?) {}
        })
        mapView.map.setOnMarkerClickListener {
            eventSink?.success(UnifiedMarkerOptions(it.options).toJson())
            true
        }

        // 注册生命周期
        registrar.activity().application.registerActivityLifecycleCallbacks(this)
    }

    override fun onActivityCreated(activity: Activity, savedInstanceState: Bundle) {
        if (disposed || activity.hashCode() != registrarActivityHashCode) {
            return
        }
        mapView.onCreate(savedInstanceState)
    }

    override fun onActivityStarted(activity: Activity) {
        if (disposed || activity.hashCode() != registrarActivityHashCode) {
            return
        }
    }

    override fun onActivityResumed(activity: Activity) {
        if (disposed || activity.hashCode() != registrarActivityHashCode) {
            return
        }
        mapView.onResume()
    }

    override fun onActivityPaused(activity: Activity) {
        if (disposed || activity.hashCode() != registrarActivityHashCode) {
            return
        }
        mapView.onPause()
    }

    override fun onActivityStopped(activity: Activity) {
        if (disposed || activity.hashCode() != registrarActivityHashCode) {
            return
        }
    }

    override fun onActivitySaveInstanceState(activity: Activity, outState: Bundle) {
        if (disposed || activity.hashCode() != registrarActivityHashCode) {
            return
        }
        mapView.onSaveInstanceState(outState)
    }

    override fun onActivityDestroyed(activity: Activity) {
        if (disposed || activity.hashCode() != registrarActivityHashCode) {
            return
        }
        mapView.onDestroy()
    }
}