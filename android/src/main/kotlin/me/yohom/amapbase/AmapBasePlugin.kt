package me.yohom.amapbase

import android.app.Activity
import android.app.Application
import android.os.Bundle
import com.amap.api.maps.model.LatLng
import com.amap.api.maps.model.Poi
import com.amap.api.navi.AmapNaviPage
import com.amap.api.navi.AmapNaviParams
import com.amap.api.navi.AmapNaviType
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.util.concurrent.atomic.AtomicInteger

const val CREATED = 1
const val STARTED = 2
const val RESUMED = 3
const val PAUSED = 4
const val STOPPED = 5
const val DESTROYED = 6

class AmapBasePlugin : Application.ActivityLifecycleCallbacks {
    private val state = AtomicInteger(0)

    override fun onActivityCreated(activity: Activity?, savedInstanceState: Bundle?) {
        state.set(CREATED)
    }

    override fun onActivityStarted(activity: Activity?) {
        state.set(STARTED)
    }

    override fun onActivityResumed(activity: Activity?) {
        state.set(RESUMED)
    }

    override fun onActivityPaused(activity: Activity?) {
        state.set(PAUSED)
    }

    override fun onActivityStopped(activity: Activity?) {
        state.set(STOPPED)
    }

    override fun onActivitySaveInstanceState(activity: Activity?, outState: Bundle?) {}

    override fun onActivityDestroyed(activity: Activity?) {
        state.set(DESTROYED)
    }

    companion object {
        private const val channel = "me.yohom/amap_navi"
        private const val startNavi = "startNavi"
        private const val setKey = "setKey"

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val plugin = AmapBasePlugin()
            val channel = MethodChannel(registrar.messenger(), channel)
            channel.setMethodCallHandler { call, result ->
                when (call.method) {
                    startNavi -> {
                        val lat = call.argument<Double>("lat")
                        val lon = call.argument<Double>("lon")
                        val end = Poi(null, LatLng(lat, lon), "")
                        AmapNaviPage.getInstance().showRouteActivity(
                                registrar.activity(),
                                AmapNaviParams(null, null, end, AmapNaviType.DRIVER),
                                null
                        )
                    }
                    setKey -> result.success("android端需要在Manifest里配置key")
                    else -> result.notImplemented()
                }
            }

            registrar.activity().application.registerActivityLifecycleCallbacks(plugin)
            registrar
                    .platformViewRegistry()
                    .registerViewFactory("me.yohom/AMapView", AMapFactory(plugin.state, registrar))
        }
    }
}
