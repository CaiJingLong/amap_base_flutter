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
import me.yohom.amapbase.map.model.UnifiedPoiResult
import me.yohom.amapbase.map.model.UnifiedPoiSearchQuery
import me.yohom.amapbase.utils.log
import me.yohom.amapbase.utils.parseJson
import me.yohom.amapbase.utils.toAMapError
import me.yohom.amapbase.utils.toJson

object SearchPoiBound : MapMethodHandler {

    lateinit var map: AMap

    override fun with(map: AMap): SearchPoiBound {
        this.map = map
        return this
    }

    override fun onMethodCall(methodCall: MethodCall, methodResult: MethodChannel.Result) {
        val query = methodCall.argument<String>("query") ?: "{}"

        log("方法map#searchPoi android端参数: query -> $query")

        query.parseJson<UnifiedPoiSearchQuery>()
                .toPoiSearchBound(registrar.context())
                .apply {
                    setOnPoiSearchListener(object : PoiSearch.OnPoiSearchListener {
                        override fun onPoiItemSearched(result: PoiItem?, rCode: Int) {}

                        override fun onPoiSearched(result: PoiResult?, rCode: Int) {
                            if (rCode == AMapException.CODE_AMAP_SUCCESS) {
                                if (result != null) {
                                    methodResult.success(UnifiedPoiResult(result).toJson())
                                } else {
                                    methodResult.error(rCode.toAMapError(), null, null)
                                }
                            } else {
                                methodResult.error(rCode.toAMapError(), null, null)
                            }
                        }
                    })
                }.searchPOIAsyn()
    }
}