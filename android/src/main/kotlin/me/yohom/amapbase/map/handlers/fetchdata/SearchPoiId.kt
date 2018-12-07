package me.yohom.amapbase.map.handlers.fetchdata

import com.amap.api.maps.AMap
import com.amap.api.services.core.AMapException
import com.amap.api.services.core.PoiItem
import com.amap.api.services.poisearch.PoiResult
import com.amap.api.services.poisearch.PoiSearch
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import me.yohom.amapbase.AMapBasePlugin.Companion.registrar
import me.yohom.amapbase.map.MapMethodHandler
import me.yohom.amapbase.map.model.UnifiedPoiItem
import me.yohom.amapbase.common.log
import me.yohom.amapbase.common.toAMapError
import me.yohom.amapbase.common.toJson

object SearchPoiId : MapMethodHandler {

    lateinit var map: AMap

    override fun with(map: AMap): SearchPoiId {
        this.map = map
        return this
    }

    override fun onMethodCall(methodCall: MethodCall, methodResult: MethodChannel.Result) {
        val id = methodCall.argument<String>("id") ?: ""

        log("方法map#searchPoiId android端参数: id -> $id")

        PoiSearch(registrar.context(), null).apply {
            setOnPoiSearchListener(object : PoiSearch.OnPoiSearchListener {
                override fun onPoiItemSearched(result: PoiItem?, rCode: Int) {
                    if (rCode == AMapException.CODE_AMAP_SUCCESS) {
                        if (result != null) {
                            methodResult.success(UnifiedPoiItem(result).toJson())
                        } else {
                            methodResult.error(rCode.toAMapError(), null, null)
                        }
                    } else {
                        methodResult.error(rCode.toAMapError(), null, null)
                    }
                }

                override fun onPoiSearched(result: PoiResult?, rCode: Int) {}
            })
        }.searchPOIIdAsyn(id)
    }
}