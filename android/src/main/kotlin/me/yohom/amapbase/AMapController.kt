package me.yohom.amapbase

import android.app.Activity
import android.app.Application
import android.content.Context
import android.os.Bundle
import android.view.View
import com.amap.api.maps.*
import com.amap.api.maps.model.CameraPosition
import com.amap.api.maps.model.Marker
import com.amap.api.maps.model.MarkerOptions
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.platform.PlatformView
import java.util.*
import java.util.concurrent.atomic.AtomicInteger

class AMapController(
        private val id: Int,
        private val registrar: PluginRegistry.Registrar,
        private val activityState: AtomicInteger,
        context: Context,
        options: AMapOptions
) :     // AMap相关
        AMap.OnCameraChangeListener,
        AMap.OnInfoWindowClickListener,
        AMap.OnMarkerClickListener,

        // Android相关
        Application.ActivityLifecycleCallbacks,

        // Flutter相关
        MethodChannel.MethodCallHandler,
        PlatformView,

        // 自定义接口
        AMapOptionsSink,
        OnMarkerTappedListener {

    private val mapView = TextureMapView(context, options)
    private val aMap: AMap = mapView.map
    private val density: Float = context.resources.displayMetrics.density
    private val markers = HashMap<String, MarkerController>()
    private val methodChannel = MethodChannel(registrar.messenger(), "me.yohom/amap_base_$id").apply {
        setMethodCallHandler(this@AMapController)
    }

    private var disposed = false
    private var trackCameraPosition = false

    fun init() {
        when (activityState.get()) {
            STOPPED -> {
                mapView.onCreate(null)
                mapView.onResume()
                mapView.onPause()
            }
            PAUSED -> {
                mapView.onCreate(null)
                mapView.onResume()
                mapView.onPause()
            }
            RESUMED -> {
                mapView.onCreate(null)
                mapView.onResume()
            }
            STARTED -> {
                mapView.onCreate(null)
            }
            CREATED -> {
                mapView.onCreate(null)
            }
        }

        aMap.apply {
            setOnInfoWindowClickListener(this@AMapController)
            setOnCameraChangeListener(this@AMapController)
            setOnMarkerClickListener(this@AMapController)
        }

        registrar.activity().application.registerActivityLifecycleCallbacks(this)
    }

    private fun moveCamera(cameraUpdate: CameraUpdate) {
        aMap.moveCamera(cameraUpdate)
    }

    private fun animateCamera(cameraUpdate: CameraUpdate) {
        aMap.animateCamera(cameraUpdate)
    }

    private fun getCameraPosition(): CameraPosition? {
        return if (trackCameraPosition) aMap.cameraPosition else null
    }

    private fun newMarkerBuilder(): MarkerBuilder {
        return MarkerBuilder(this)
    }

    fun addMarker(markerOptions: MarkerOptions, consumesTapEvents: Boolean): Marker {
        val marker = aMap.addMarker(markerOptions)
        markers[marker.id] = MarkerController(marker, consumesTapEvents, this)
        return marker
    }

    private fun removeMarker(markerId: String) {
        val markerController = markers.remove(markerId)
        markerController?.remove()
    }

    private fun marker(markerId: String): MarkerController {
        return markers[markerId] ?: throw IllegalArgumentException("Unknown marker: $markerId")
    }

    //region AMap
    //region AMap.OnCameraChangeListener
    override fun onCameraChangeFinish(position: CameraPosition?) {
        methodChannel.invokeMethod("camera#onIdle", Collections.singletonMap<String, Int>("map", id))
    }

    override fun onCameraChange(position: CameraPosition?) {
        if (!trackCameraPosition) {
            return
        }
        val arguments = HashMap<String, Any>(2)
        arguments["position"] = Convert.toJson(aMap.cameraPosition)!!
        methodChannel.invokeMethod("camera#onMove", arguments)
    }
    //endregion

    //region AMap.OnInfoWindowClickListener
    override fun onInfoWindowClick(marker: Marker) {
        val arguments = java.util.HashMap<String, Any>(2)
        arguments["marker"] = marker.id
        methodChannel.invokeMethod("marker#onTap", arguments)
    }
    //endregion

    //region AMap.OnMarkerClickListener
    override fun onMarkerClick(marker: Marker): Boolean {
        val markerController = markers[marker.id]
        return markerController != null && markerController.onTap()
    }
    //endregion
    //endregion

    //region Application.ActivityLifecycleCallbacks
    override fun onActivityCreated(activity: Activity?, savedInstanceState: Bundle?) {
        if (disposed) return
        mapView.onCreate(savedInstanceState)
    }

    override fun onActivityStarted(activity: Activity?) {}

    override fun onActivityResumed(activity: Activity?) {
        if (disposed) return
        mapView.onResume()
    }

    override fun onActivityPaused(activity: Activity?) {
        if (disposed) return
        mapView.onPause()
    }

    override fun onActivityStopped(activity: Activity?) {}

    override fun onActivitySaveInstanceState(activity: Activity?, outState: Bundle?) {
        if (disposed) return
        mapView.onSaveInstanceState(outState)
    }

    override fun onActivityDestroyed(activity: Activity?) {
        if (disposed) return
        mapView.onDestroy()
    }
    //endregion

    //region Flutter
    //region MethodChannel.MethodCallHandler
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "map#waitForMap" -> {
                result.success(null)
            }
            "map#update" -> {
                Convert.interpretGoogleMapOptions(call.argument("options"), this)
                result.success(Convert.toJson(getCameraPosition()))
            }
            "camera#move" -> {
                val cameraUpdate = Convert.toCameraUpdate(call.argument("cameraUpdate"), density)
                moveCamera(cameraUpdate)
                result.success(null)
            }
            "camera#animate" -> {
                val cameraUpdate = Convert.toCameraUpdate(call.argument("cameraUpdate"), density)
                animateCamera(cameraUpdate)
                result.success(null)
            }
            "marker#add" -> {
                val markerBuilder = newMarkerBuilder()
                Convert.interpretMarkerOptions(call.argument("options"), markerBuilder)
                val markerId = markerBuilder.build()
                result.success(markerId)
            }
            "marker#remove" -> {
                val markerId = call.argument<String>("marker")
                removeMarker(markerId)
                result.success(null)
            }
            "marker#update" -> {
                val markerId = call.argument<String>("marker")
                val marker = marker(markerId)
                Convert.interpretMarkerOptions(call.argument("options"), marker)
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }
    //endregion

    //region PlatformView
    override fun getView(): View = mapView

    override fun dispose() {
        if (disposed) {
            return
        }
        disposed = true
        mapView.onDestroy()
        registrar.activity().application.unregisterActivityLifecycleCallbacks(this)
    }
    //endregion
    //endregion

    //region 自定义接口
    //region AMapOptionsSink
    override fun setCameraPosition(position: CameraPosition) {
        aMap.moveCamera(CameraUpdateFactory.newCameraPosition(position))
    }

    override fun setCompassEnabled(compassEnabled: Boolean) {
        aMap.uiSettings.isCompassEnabled = compassEnabled
    }

    override fun setMapType(mapType: Int) {
        aMap.mapType = mapType
    }

    override fun setMinMaxZoomPreference(min: Float?, max: Float?) {
        // 此处api与GMap有点出入
        aMap.resetMinMaxZoomPreference()
        if (min != null) {
            aMap.minZoomLevel = min
        }
        if (max != null) {
            aMap.maxZoomLevel = max
        }
    }

    override fun setRotateGesturesEnabled(rotateGesturesEnabled: Boolean) {
        aMap.uiSettings.isRotateGesturesEnabled = rotateGesturesEnabled
    }

    override fun setScrollGesturesEnabled(scrollGesturesEnabled: Boolean) {
        aMap.uiSettings.isScrollGesturesEnabled = scrollGesturesEnabled
    }

    override fun setTiltGesturesEnabled(tiltGesturesEnabled: Boolean) {
        aMap.uiSettings.isTiltGesturesEnabled = tiltGesturesEnabled
    }

    override fun setTrackCameraPosition(trackCameraPosition: Boolean) {
        this.trackCameraPosition = trackCameraPosition
    }

    override fun setZoomGesturesEnabled(zoomGesturesEnabled: Boolean) {
        aMap.uiSettings.isZoomGesturesEnabled = zoomGesturesEnabled
    }

    override fun setZoomControlEnabled(zoomControlEnabled: Boolean) {
        // 没有对应api, 只能在option里设置
    }
    //endregion

    //region OnMarkerTappedListener
    override fun onMarkerTapped(marker: Marker) {

    }
    //endregion
    //endregion
}