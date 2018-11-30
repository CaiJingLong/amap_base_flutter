package me.yohom.amapbase.map

import android.content.Context
import android.view.View
import com.amap.api.maps.AMapOptions
import com.amap.api.maps.TextureMapView
import com.amap.api.services.core.AMapException
import com.amap.api.services.route.*
import com.google.gson.Gson
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import me.yohom.amapbase.AMapBasePlugin
import me.yohom.amapbase.map.model.RoutePlanParam
import me.yohom.amapbase.map.model.UnifiedAMapOptions
import me.yohom.amapbase.map.model.UnifiedMyLocationStyle
import me.yohom.amapbase.map.model.UnifiedUiSettings
import me.yohom.amapbase.map.overlay.DrivingRouteOverlay
import me.yohom.amapbase.utils.log
import me.yohom.amapbase.utils.parseJson
import me.yohom.amapbase.utils.toLatLonPoint


const val mapChannelName = "me.yohom/map"

class AMapFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, id: Int, params: Any?): PlatformView {
        val options = Gson()
                .fromJson(params as String, UnifiedAMapOptions::class.java)

        val view = AMapView(context, id, options.toAMapOption())
        view.setup()
        return view
    }
}

class AMapView(private val context: Context,
               private val id: Int,
               amapOptions: AMapOptions) : PlatformView {

    private val mapView = TextureMapView(context, amapOptions)

    override fun getView(): View = mapView

    override fun dispose() {
        mapView.onPause()
        mapView.onDestroy()
    }

    fun setup() {
        mapView.onCreate(null)
        val mapChannel = MethodChannel(AMapBasePlugin.registrar.messenger(), "$mapChannelName$id")
        mapChannel.setMethodCallHandler { call, result ->
            handleMethodCall(call, result)
        }
    }

    private fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val map = mapView.map
        when (call.method) {
            "map#setMyLocationStyle" -> {
                val styleJson = call.argument<String>("myLocationStyle") ?: "{}"

                log("方法setMyLocationEnabled android端参数: styleJson -> $styleJson")

                styleJson.parseJson<UnifiedMyLocationStyle>().applyTo(map)
            }
            "map#setUiSettings" -> {
                val uiSettingsJson = call.argument<String>("uiSettings") ?: "{}"

                log("方法setUiSettings android端参数: uiSettingsJson -> $uiSettingsJson")

                uiSettingsJson.parseJson<UnifiedUiSettings>().applyTo(map)
            }
            "map#calculateDriveRoute" -> {
                // 规划参数
                val param = call.argument<String>("routePlanParam")!!.parseJson<RoutePlanParam>()

                log("方法setUiSettings android端参数: routePlanParam -> $param")

                val routeQuery = RouteSearch.DriveRouteQuery(
                        RouteSearch.FromAndTo(param.from.toLatLonPoint(), param.to.toLatLonPoint()),
                        param.mode,
                        param.passedByPoints?.map { it.toLatLonPoint() },
                        param.avoidPolygons?.map { list -> list.map { it.toLatLonPoint() } },
                        param.avoidRoad
                )
                RouteSearch(context).run {
                    setRouteSearchListener(object : RouteSearch.OnRouteSearchListener {
                        override fun onDriveRouteSearched(r: DriveRouteResult?, errorCode: Int) {
                            if (errorCode != AMapException.CODE_AMAP_SUCCESS || r == null) {
                                result.error("路线规划失败, 错误码: $errorCode", null, null)
                            } else if (r.paths.isEmpty()) {
                                result.error("没有规划出合适的路线", null, null)
                            } else {
                                map.clear()
                                DrivingRouteOverlay(context, map, r.paths[0], r.startPos, r.targetPos, null)
                                        .apply {
                                            setNodeIconVisibility(false)//设置节点marker是否显示
                                            setIsColorfulline(true)//是否用颜色展示交通拥堵情况，默认true
                                            removeFromMap()
                                            addToMap()
                                            zoomToSpan()
                                            addToMap()
                                        }

                            }
                        }

                        override fun onBusRouteSearched(result: BusRouteResult?, errorCode: Int) {}

                        override fun onRideRouteSearched(result: RideRouteResult?, errorCode: Int) {}

                        override fun onWalkRouteSearched(result: WalkRouteResult?, errorCode: Int) {}
                    })

                    calculateDriveRouteAsyn(routeQuery)
                }
            }
            else -> result.notImplemented()
        }
    }
}