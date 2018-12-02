package me.yohom.amapbase

import io.flutter.plugin.common.PluginRegistry.Registrar
import me.yohom.amapbase.map.AMapFactory

class AMapBasePlugin {
    companion object {
        lateinit var registrar: Registrar

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            // 由于registrar用到的地方比较多, 这里直接放到全局变量里去好了
            AMapBasePlugin.registrar = registrar
            registrar
                    .platformViewRegistry()
                    .registerViewFactory("me.yohom/AMapView", AMapFactory())
        }
    }
}
