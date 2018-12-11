package me.yohom.amapbase.search.handler.fetchdata

import com.amap.api.services.core.AMapException
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import me.yohom.amapbase.AMapBasePlugin.Companion.registrar
import me.yohom.amapbase.common.log
import me.yohom.amapbase.common.parseJson
import me.yohom.amapbase.common.toAMapError
import me.yohom.amapbase.common.toJson
import me.yohom.amapbase.search.SearchMethodHandler
import me.yohom.amapbase.search.model.UnifiedRoutePoiSearchQuery
import me.yohom.amapbase.search.model.UnifiedRoutePoiSearchResult

object SearchRoutePoiLine : SearchMethodHandler {

    override fun onMethodCall(methodCall: MethodCall, methodResult: MethodChannel.Result) {
        val query = methodCall.argument<String>("query") ?: "{}"

        log("方法map#searchRoutePoiLine android端参数: query -> $query")

        query.parseJson<UnifiedRoutePoiSearchQuery>()
                .toRoutePoiSearchLine(registrar.context())
                .apply {
                    setPoiSearchListener { result, rCode ->
                        if (rCode == AMapException.CODE_AMAP_SUCCESS) {
                            if (result != null) {
                                methodResult.success(UnifiedRoutePoiSearchResult(result).toJson())
                            } else {
                                methodResult.error(rCode.toString(), rCode.toAMapError(), rCode.toAMapError())
                            }
                        } else {
                            methodResult.error(rCode.toString(), rCode.toAMapError(), rCode.toAMapError())
                        }
                    }
                }.searchRoutePOIAsyn()
    }
}