package me.yohom.amapbase.search

import com.amap.api.services.core.AMapException
import com.amap.api.services.core.PoiItem
import com.amap.api.services.geocoder.GeocodeQuery
import com.amap.api.services.geocoder.GeocodeResult
import com.amap.api.services.geocoder.GeocodeSearch
import com.amap.api.services.geocoder.RegeocodeResult
import com.amap.api.services.poisearch.PoiResult
import com.amap.api.services.poisearch.PoiSearch
import com.amap.api.services.route.*
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import me.yohom.amapbase.AMapBasePlugin
import me.yohom.amapbase.SearchMethodHandler
import me.yohom.amapbase.common.log
import me.yohom.amapbase.common.parseJson
import me.yohom.amapbase.common.toAMapError
import me.yohom.amapbase.common.toJson

object SearchGeocode : SearchMethodHandler {
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val structuredAddress = call.argument<String>("name") ?: ""
        val city = call.argument<String>("city") ?: ""

        GeocodeSearch(AMapBasePlugin.registrar.activity()).run {
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

object SearchPoiBound : SearchMethodHandler {
    override fun onMethodCall(methodCall: MethodCall, methodResult: MethodChannel.Result) {
        val query = methodCall.argument<String>("query") ?: "{}"

        log("方法map#searchPoi android端参数: query -> $query")

        query.parseJson<UnifiedPoiSearchQuery>()
                .toPoiSearchBound(AMapBasePlugin.registrar.context())
                .apply {
                    setOnPoiSearchListener(object : PoiSearch.OnPoiSearchListener {
                        override fun onPoiItemSearched(result: PoiItem?, rCode: Int) {}

                        override fun onPoiSearched(result: PoiResult?, rCode: Int) {
                            if (rCode == AMapException.CODE_AMAP_SUCCESS) {
                                if (result != null) {
                                    methodResult.success(UnifiedPoiResult(result).toJson())
                                } else {
                                    methodResult.error(rCode.toString(), rCode.toAMapError(), rCode.toAMapError())
                                }
                            } else {
                                methodResult.error(rCode.toString(), rCode.toAMapError(), rCode.toAMapError())
                            }
                        }
                    })
                }.searchPOIAsyn()
    }
}

object SearchPoiId : SearchMethodHandler {

    override fun onMethodCall(methodCall: MethodCall, methodResult: MethodChannel.Result) {
        val id = methodCall.argument<String>("id") ?: ""

        log("方法map#searchPoiId android端参数: id -> $id")

        PoiSearch(AMapBasePlugin.registrar.context(), null).apply {
            setOnPoiSearchListener(object : PoiSearch.OnPoiSearchListener {
                override fun onPoiItemSearched(result: PoiItem?, rCode: Int) {
                    if (rCode == AMapException.CODE_AMAP_SUCCESS) {
                        if (result != null) {
                            methodResult.success(UnifiedPoiItem(result).toJson())
                        } else {
                            methodResult.error(rCode.toString(), rCode.toAMapError(), rCode.toAMapError())
                        }
                    } else {
                        methodResult.error(rCode.toString(), rCode.toAMapError(), rCode.toAMapError())
                    }
                }

                override fun onPoiSearched(result: PoiResult?, rCode: Int) {}
            })
        }.searchPOIIdAsyn(id)
    }
}

object SearchPoiKeyword : SearchMethodHandler {

    override fun onMethodCall(methodCall: MethodCall, methodResult: MethodChannel.Result) {
        val query = methodCall.argument<String>("query") ?: "{}"

        log("方法map#searchPoi android端参数: query -> $query")

        query.parseJson<UnifiedPoiSearchQuery>()
                .toPoiSearch(AMapBasePlugin.registrar.context())
                .apply {
                    setOnPoiSearchListener(object : PoiSearch.OnPoiSearchListener {
                        override fun onPoiItemSearched(result: PoiItem?, rCode: Int) {}

                        override fun onPoiSearched(result: PoiResult?, rCode: Int) {
                            if (rCode == AMapException.CODE_AMAP_SUCCESS) {
                                if (result != null) {
                                    methodResult.success(UnifiedPoiResult(result).toJson())
                                } else {
                                    methodResult.error(rCode.toString(), rCode.toAMapError(), rCode.toAMapError())
                                }
                            } else {
                                methodResult.error(rCode.toString(), rCode.toAMapError(), rCode.toAMapError())
                            }
                        }
                    })
                }.searchPOIAsyn()
    }
}

object SearchPoiPolygon : SearchMethodHandler {
    override fun onMethodCall(methodCall: MethodCall, methodResult: MethodChannel.Result) {
        val query = methodCall.argument<String>("query") ?: "{}"

        log("方法map#searchPoi android端参数: query -> $query")

        query.parseJson<UnifiedPoiSearchQuery>()
                .toPoiSearchPolygon(AMapBasePlugin.registrar.context())
                .apply {
                    setOnPoiSearchListener(object : PoiSearch.OnPoiSearchListener {
                        override fun onPoiItemSearched(result: PoiItem?, rCode: Int) {}

                        override fun onPoiSearched(result: PoiResult?, rCode: Int) {
                            if (rCode == AMapException.CODE_AMAP_SUCCESS) {
                                if (result != null) {
                                    methodResult.success(UnifiedPoiResult(result).toJson())
                                } else {
                                    methodResult.error(rCode.toString(), rCode.toAMapError(), rCode.toAMapError())
                                }
                            } else {
                                methodResult.error(rCode.toString(), rCode.toAMapError(), rCode.toAMapError())
                            }
                        }
                    })
                }.searchPOIAsyn()
    }
}

object SearchRoutePoiLine : SearchMethodHandler {

    override fun onMethodCall(methodCall: MethodCall, methodResult: MethodChannel.Result) {
        val query = methodCall.argument<String>("query") ?: "{}"

        log("方法map#searchRoutePoiLine android端参数: query -> $query")

        query.parseJson<UnifiedRoutePoiSearchQuery>()
                .toRoutePoiSearchLine(AMapBasePlugin.registrar.context())
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

object SearchRoutePoiPolygon : SearchMethodHandler {

    override fun onMethodCall(methodCall: MethodCall, methodResult: MethodChannel.Result) {
        val query = methodCall.argument<String>("query") ?: "{}"

        log("方法map#searchRoutePoiPolygon android端参数: query -> $query")

        query.parseJson<UnifiedRoutePoiSearchQuery>()
                .toRoutePoiSearchPolygon(AMapBasePlugin.registrar.context())
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

object CalculateDriveRoute : SearchMethodHandler {

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        // 规划参数
        val param = call.argument<String>("routePlanParam")!!.parseJson<RoutePlanParam>()

        log("方法calculateDriveRoute android端参数: routePlanParam -> $param")

        val routeQuery = RouteSearch.DriveRouteQuery(
                RouteSearch.FromAndTo(param.from.toLatLonPoint(), param.to.toLatLonPoint()),
                param.mode,
                param.passedByPoints?.map { it.toLatLonPoint() },
                param.avoidPolygons?.map { list -> list.map { it.toLatLonPoint() } },
                param.avoidRoad
        )
        RouteSearch(AMapBasePlugin.registrar.context()).run {
            setRouteSearchListener(object : RouteSearch.OnRouteSearchListener {
                override fun onDriveRouteSearched(r: DriveRouteResult?, errorCode: Int) {
                    if (errorCode != AMapException.CODE_AMAP_SUCCESS || r == null) {
                        result.error("路线规划失败, 错误码: $errorCode", null, null)
                    } else if (r.paths.isEmpty()) {
                        result.error("没有规划出合适的路线", null, null)
                    } else {
                        result.success(UnifiedDriveRouteResult(r).toJson())
                    }
                }

                override fun onBusRouteSearched(result: BusRouteResult?, errorCode: Int) {}

                override fun onRideRouteSearched(result: RideRouteResult?, errorCode: Int) {}

                override fun onWalkRouteSearched(result: WalkRouteResult?, errorCode: Int) {}
            })

            calculateDriveRouteAsyn(routeQuery)
        }
    }
}