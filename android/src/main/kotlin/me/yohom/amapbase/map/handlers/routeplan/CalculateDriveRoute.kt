package me.yohom.amapbase.map.handlers.routeplan

import com.amap.api.maps.AMap
import com.amap.api.services.core.AMapException
import com.amap.api.services.route.*
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import me.yohom.amapbase.AMapBasePlugin
import me.yohom.amapbase.map.MapMethodHandler
import me.yohom.amapbase.map.model.RoutePlanParam
import me.yohom.amapbase.map.overlay.DrivingRouteOverlay
import me.yohom.amapbase.map.success
import me.yohom.amapbase.utils.log
import me.yohom.amapbase.utils.parseJson
import me.yohom.amapbase.utils.toLatLonPoint

object CalculateDriveRoute : MapMethodHandler {

    lateinit var map: AMap

    override fun with(map: AMap): CalculateDriveRoute {
        this.map = map
        return this
    }

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
                    if (errorCode != AMapException.CODE_AMAP_SUCCESS || r == null) {
                        result.error("路线规划失败, 错误码: $errorCode", null, null)
                    } else if (r.paths.isEmpty()) {
                        result.error("没有规划出合适的路线", null, null)
                    } else if (showRouteImmediately) {
                        map.clear()
                        DrivingRouteOverlay(map, r.startPos, r.targetPos, listOf(), r.paths[0])
                                .apply {
                                    nodeIconVisible = false//设置节点marker是否显示
                                    removeFromMap()
                                    addToMap()
                                    zoomToSpan()
                                }

                        result.success(success)
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