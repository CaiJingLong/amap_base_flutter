package me.yohom.amapbase.map.handlers.fetchdata

import com.amap.api.maps.AMap
import com.amap.api.services.core.AMapException
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import me.yohom.amapbase.AMapBasePlugin.Companion.registrar
import me.yohom.amapbase.map.MapMethodHandler
import me.yohom.amapbase.map.model.UnifiedRoutePOISearchResult
import me.yohom.amapbase.map.model.UnifiedRoutePoiSearchQuery
import me.yohom.amapbase.utils.log
import me.yohom.amapbase.utils.parseJson
import me.yohom.amapbase.utils.toAMapError
import me.yohom.amapbase.utils.toJson

object SearchRoutePoiPolygon : MapMethodHandler {

    lateinit var map: AMap

    override fun with(map: AMap): SearchRoutePoiPolygon {
        this.map = map
        return this
    }

    override fun onMethodCall(methodCall: MethodCall, methodResult: MethodChannel.Result) {
        val query = methodCall.argument<String>("query") ?: "{}"

        log("方法map#searchRoutePoiPolygon android端参数: query -> $query")

        query.parseJson<UnifiedRoutePoiSearchQuery>()
                .toRoutePoiSearchPolygon(registrar.context())
                .apply {
                    setPoiSearchListener { result, rCode ->
                        if (rCode == AMapException.CODE_AMAP_SUCCESS) {
                            if (result != null) {
                                methodResult.success(UnifiedRoutePOISearchResult(result).toJson())
                            } else {
                                methodResult.error(rCode.toAMapError(), null, null)
                            }
                        } else {
                            methodResult.error(rCode.toAMapError(), null, null)
                        }
                    }
                }.searchRoutePOIAsyn()
    }
}