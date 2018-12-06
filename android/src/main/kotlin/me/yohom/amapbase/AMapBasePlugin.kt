package me.yohom.amapbase

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar
import me.yohom.amapbase.map.AMapFactory
import me.yohom.amapbase.navi.setupNaviChannel
import me.yohom.amapbase.tools.setupToolsChannel

private const val setKey = "setKey"

class AMapBasePlugin {
    companion object {
        lateinit var registrar: Registrar

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            // 由于registrar用到的地方比较多, 这里直接放到全局变量里去好了
            AMapBasePlugin.registrar = registrar
            MethodChannel(registrar.messenger(), "me.yohom/amap_base").setMethodCallHandler { methodCall, result ->
                when (methodCall.method) {
                    setKey -> result.success("android端需要在Manifest里配置key")
                    else -> result.notImplemented()
                }
            }

            // 导航相关插件
            registrar.setupNaviChannel()
            registrar
                    .platformViewRegistry()
                    .registerViewFactory("me.yohom/AMapView", AMapFactory())

            registrar.setupToolsChannel()
        }
    }
}

