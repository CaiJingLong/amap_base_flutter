package me.yohom.amapbase

import android.app.Activity
import android.app.Application
import android.os.Bundle
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar
import me.yohom.amapbase.map.AMapFactory
import me.yohom.amapbase.map.MAP_METHOD_HANDLER
import me.yohom.amapbase.navi.setupNaviChannel
import me.yohom.amapbase.search.SEARCH_METHOD_HANDLER
import java.util.concurrent.atomic.AtomicInteger

const val CREATED = 1
const val RESUMED = 3
const val STOPPED = 5
const val DESTROYED = 6

class AMapBasePlugin {
    companion object : Application.ActivityLifecycleCallbacks {

        lateinit var registrar: Registrar
        private var registrarActivityHashCode: Int = 0
        private val activityState = AtomicInteger(0)

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            // 由于registrar用到的地方比较多, 这里直接放到全局变量里去好了
            AMapBasePlugin.registrar = registrar
            registrarActivityHashCode = registrar.activity().hashCode()

            // 注册生命周期回调, 保证地图初始化的时候对应的是正确的activity状态
            registrar.activity().application.registerActivityLifecycleCallbacks(this)

            // 设置key channel
            MethodChannel(registrar.messenger(), "me.yohom/amap_base")
                    .setMethodCallHandler { methodCall, result ->
                        when (methodCall.method) {
                            "setKey" -> result.success("android端需要在Manifest里配置key")
                            else -> result.notImplemented()
                        }
                    }

            // 地图计算工具相关method channel
            MethodChannel(registrar.messenger(), "me.yohom/tool")
                    .setMethodCallHandler { call, result ->
                        MAP_METHOD_HANDLER[call.method]
                                ?.onMethodCall(call, result) ?: result.notImplemented()
                    }

            // 离线地图 channel
            MethodChannel(registrar.messenger(), "me.yohom/offline")
                    .setMethodCallHandler { call, result ->
                        MAP_METHOD_HANDLER[call.method]
                                ?.onMethodCall(call, result) ?: result.notImplemented()
                    }

            // 搜索 channel
            MethodChannel(registrar.messenger(), "me.yohom/search")
                    .setMethodCallHandler { call, result ->
                        SEARCH_METHOD_HANDLER[call.method]
                                ?.onMethodCall(call, result) ?: result.notImplemented()
                    }

            // 导航相关插件
            registrar.setupNaviChannel()

            // MapView
            registrar
                    .platformViewRegistry()
                    .registerViewFactory("me.yohom/AMapView", AMapFactory(activityState))
        }

        override fun onActivityCreated(activity: Activity, savedInstanceState: Bundle?) {
            if (activity.hashCode() != registrarActivityHashCode) {
                return
            }
            activityState.set(CREATED)
        }

        override fun onActivityStarted(activity: Activity) {
            if (activity.hashCode() != registrarActivityHashCode) {
                return
            }
        }

        override fun onActivityResumed(activity: Activity) {
            if (activity.hashCode() != registrarActivityHashCode) {
                return
            }
            activityState.set(RESUMED)
        }

        override fun onActivityPaused(activity: Activity) {
            if (activity.hashCode() != registrarActivityHashCode) {
                return
            }
        }

        override fun onActivityStopped(activity: Activity) {
            if (activity.hashCode() != registrarActivityHashCode) {
                return
            }
            activityState.set(STOPPED)
        }

        override fun onActivitySaveInstanceState(activity: Activity, outState: Bundle?) {}

        override fun onActivityDestroyed(activity: Activity) {
            if (activity.hashCode() != registrarActivityHashCode) {
                return
            }
            activityState.set(DESTROYED)
        }
    }
}
