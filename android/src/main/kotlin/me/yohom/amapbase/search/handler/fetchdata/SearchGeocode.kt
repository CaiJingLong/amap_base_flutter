package me.yohom.amapbase.search.handler.fetchdata

import com.amap.api.services.geocoder.GeocodeQuery
import com.amap.api.services.geocoder.GeocodeResult
import com.amap.api.services.geocoder.GeocodeSearch
import com.amap.api.services.geocoder.RegeocodeResult
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import me.yohom.amapbase.AMapBasePlugin.Companion.registrar
import me.yohom.amapbase.SearchMethodHandler
import me.yohom.amapbase.common.toJson
import me.yohom.amapbase.search.model.UnifiedGeocodeResult

object SearchGeocode : SearchMethodHandler {
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val structuredAddress = call.argument<String>("name") ?: ""
        val city = call.argument<String>("city") ?: ""

        GeocodeSearch(registrar.activity()).run {
            setOnGeocodeSearchListener(object : GeocodeSearch.OnGeocodeSearchListener {
                override fun onRegeocodeSearched(p0: RegeocodeResult?, resultID: Int) {

                }

                override fun onGeocodeSearched(geocodeResult: GeocodeResult?, resultID: Int) {
                    if (geocodeResult != null) {
                        result.success(UnifiedGeocodeResult(geocodeResult).toJson())
                    } else {
                        result.error("搜索不到结果", "搜索不到结果", "搜索不到结果")
                    }
                }
            })

            getFromLocationNameAsyn(GeocodeQuery(structuredAddress, city))
        }

    }
}