package me.yohom.amapbase

import io.flutter.plugin.common.PluginRegistry.Registrar
import me.yohom.amapbase.map.AMapFactory
import me.yohom.amapbase.navi.setupNaviChannel

class AmapBasePlugin {
    companion object {
        lateinit var registrar: Registrar

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            // 由于registrar用到的地方比较多, 这里直接放到全局变量里去好了
            AmapBasePlugin.registrar = registrar
            // 导航相关插件
            registrar.setupNaviChannel()
            registrar
                    .platformViewRegistry()
                    .registerViewFactory("me.yohom/AMapView", AMapFactory())
        }
    }
}
