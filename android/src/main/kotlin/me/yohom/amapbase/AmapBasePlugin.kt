package me.yohom.amapbase

import android.app.Activity
import android.app.Application
import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.PluginRegistry.Registrar
import me.yohom.amapbase.map.AMapFactory
import me.yohom.amapbase.navi.setupNaviChannel
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
        if (activity !is FlutterActivity) return
        state.set(CREATED)
    }

    override fun onActivityStarted(activity: Activity?) {
        if (activity !is FlutterActivity) return
        state.set(STARTED)
    }

    override fun onActivityResumed(activity: Activity?) {
        if (activity !is FlutterActivity) return
        state.set(RESUMED)
    }

    override fun onActivityPaused(activity: Activity?) {
        if (activity !is FlutterActivity) return
        state.set(PAUSED)
    }

    override fun onActivityStopped(activity: Activity?) {
        if (activity !is FlutterActivity) return
        state.set(STOPPED)
    }

    override fun onActivitySaveInstanceState(activity: Activity?, outState: Bundle?) {}

    override fun onActivityDestroyed(activity: Activity?) {
        if (activity !is FlutterActivity) return
        state.set(DESTROYED)
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val plugin = AmapBasePlugin()
            registrar.activity().application.registerActivityLifecycleCallbacks(plugin)

            // 导航相关插件
            registrar.setupNaviChannel()
            registrar
                    .platformViewRegistry()
                    .registerViewFactory("me.yohom/AMapView", AMapFactory(plugin.state, registrar))
        }
    }
}
