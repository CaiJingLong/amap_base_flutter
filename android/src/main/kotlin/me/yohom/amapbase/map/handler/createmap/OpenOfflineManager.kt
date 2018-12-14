package me.yohom.amapbase.map.handler.createmap

import android.content.Intent
import com.amap.api.maps.AMap
import com.amap.api.maps.offlinemap.OfflineMapActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import me.yohom.amapbase.AMapBasePlugin.Companion.registrar
import me.yohom.amapbase.MapMethodHandler

object OpenOfflineManager: MapMethodHandler {

    override fun with(map: AMap): MapMethodHandler {
        return this
    }

    override fun onMethodCall(p0: MethodCall?, p1: MethodChannel.Result?) {
        registrar.activity().startActivity(
                Intent(registrar.activity(),
                OfflineMapActivity::class.java)
        )
    }
}