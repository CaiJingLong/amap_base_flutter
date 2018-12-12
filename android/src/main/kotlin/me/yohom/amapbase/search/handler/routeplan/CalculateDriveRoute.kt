package me.yohom.amapbase.search.handler.routeplan

import com.amap.api.services.route.*
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import me.yohom.amapbase.AMapBasePlugin
import me.yohom.amapbase.SearchMethodHandler
import me.yohom.amapbase.common.log
import me.yohom.amapbase.common.parseJson
import me.yohom.amapbase.common.toLatLonPoint
import me.yohom.amapbase.search.model.RoutePlanParam

object CalculateDriveRoute : SearchMethodHandler {

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        // 规划参数
        val param = call.argument<String>("routePlanParam")!!.parseJson<RoutePlanParam>()
        val showRouteImmediately = call.argument<Boolean>("showRouteImmediately")
                ?: true

        log("方法setUiSettings android端参数: routePlanParam -> $param")

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
//                    if (errorCode != AMapException.CODE_AMAP_SUCCESS || r == null) {
//                        result.error("路线规划失败, 错误码: $errorCode", null, null)
//                    } else if (r.paths.isEmpty()) {
//                        result.error("没有规划出合适的路线", null, null)
//                    } else if (showRouteImmediately) {
//                        map.clear()
//                        DrivingRouteOverlay(map, r.startPos, r.targetPos, listOf(), r.paths[0])
//                                .apply {
//                                    nodeIconVisible = false//设置节点marker是否显示
//                                    removeFromMap()
//                                    addToMap()
//                                    zoomToSpan()
//                                }
//
//                        result.success(success)
//                    }
                }

                override fun onBusRouteSearched(result: BusRouteResult?, errorCode: Int) {}

                override fun onRideRouteSearched(result: RideRouteResult?, errorCode: Int) {}

                override fun onWalkRouteSearched(result: WalkRouteResult?, errorCode: Int) {}
            })

            calculateDriveRouteAsyn(routeQuery)
        }
    }
}