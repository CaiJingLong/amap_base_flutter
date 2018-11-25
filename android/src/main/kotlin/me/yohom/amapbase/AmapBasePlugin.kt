package me.yohom.amapbase

import io.flutter.plugin.common.PluginRegistry.Registrar
import me.yohom.amapbase.map.AMapFactory
import me.yohom.amapbase.navi.setupNaviChannel

class AmapBasePlugin {
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            // 导航相关插件
            registrar.setupNaviChannel()
            registrar
                    .platformViewRegistry()
                    .registerViewFactory("me.yohom/AMapView", AMapFactory())
        }
    }
}
