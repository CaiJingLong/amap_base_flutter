package me.yohom.amapbase.map.overlay

import android.content.Context
import com.amap.api.maps.AMap
import com.amap.api.maps.model.BitmapDescriptor
import com.amap.api.maps.model.LatLng
import com.amap.api.maps.model.MarkerOptions
import com.amap.api.maps.model.PolylineOptions
import com.amap.api.services.core.LatLonPoint
import com.amap.api.services.route.WalkPath
import com.amap.api.services.route.WalkStep

/**
 * 步行路线图层类。在高德地图API里，如果要显示步行路线规划，可以用此类来创建步行路线图层。如不满足需求，也可以自己创建自定义的步行路线图层。
 * @since V2.1.0
 */
class WalkRouteOverlay
/**
 * 通过此构造函数创建步行路线图层。
 * @_routePlanParam context 当前activity。
 * @_routePlanParam amap 地图对象。
 * @_routePlanParam path 步行路线规划的一个方案。详见搜索服务模块的路径查询包（com.amap.api.services.route）中的类 **[WalkStep](../../../../../../Search/com/amap/api/services/route/WalkStep.html)**。
 * @_routePlanParam start 起点。详见搜索服务模块的核心基础包（com.amap.api.services.core）中的类**[LatLonPoint](../../../../../../Search/com/amap/api/services/core/LatLonPoint.html)**。
 * @_routePlanParam end 终点。详见搜索服务模块的核心基础包（com.amap.api.services.core）中的类**[LatLonPoint](../../../../../../Search/com/amap/api/services/core/LatLonPoint.html)**。
 * @since V2.1.0
 */
(context: Context, amap: AMap, private val walkPath: WalkPath,
 start: LatLonPoint, end: LatLonPoint) : RouteOverlay(context) {

    private var mPolylineOptions: PolylineOptions? = null

    private var walkStationDescriptor: BitmapDescriptor? = null

    init {
        this.mAMap = amap
        startPoint = AMapServicesUtil.convertToLatLng(start)
        endPoint = AMapServicesUtil.convertToLatLng(end)
    }

    /**
     * 添加步行路线到地图中。
     * @since V2.1.0
     */
    fun addToMap() {

        initPolylineOptions()
        try {
            val walkPaths = walkPath.steps
            mPolylineOptions!!.add(startPoint)
            for (i in walkPaths.indices) {
                val walkStep = walkPaths[i]
                val latLng = AMapServicesUtil.convertToLatLng(walkStep
                        .polyline[0])

                addWalkStationMarkers(walkStep, latLng)
                addWalkPolyLines(walkStep)

            }
            mPolylineOptions!!.add(endPoint)
            addStartAndEndMarker()

            showPolyline()
        } catch (e: Throwable) {
            e.printStackTrace()
        }

    }

    /**
     * 检查这一步的最后一点和下一步的起始点之间是否存在空隙
     */
    private fun checkDistanceToNextStep(walkStep: WalkStep,
                                        walkStep1: WalkStep) {
        val lastPoint = getLastWalkPoint(walkStep)
        val nextFirstPoint = getFirstWalkPoint(walkStep1)
        if (lastPoint != nextFirstPoint) {
            addWalkPolyLine(lastPoint, nextFirstPoint)
        }
    }

    /**
     * @_routePlanParam walkStep
     * @return
     */
    private fun getLastWalkPoint(walkStep: WalkStep): LatLonPoint {
        return walkStep.polyline[walkStep.polyline.size - 1]
    }

    /**
     * @_routePlanParam walkStep
     * @return
     */
    private fun getFirstWalkPoint(walkStep: WalkStep): LatLonPoint {
        return walkStep.polyline[0]
    }


    private fun addWalkPolyLine(pointFrom: LatLonPoint, pointTo: LatLonPoint) {
        addWalkPolyLine(AMapServicesUtil.convertToLatLng(pointFrom), AMapServicesUtil.convertToLatLng(pointTo))
    }

    private fun addWalkPolyLine(latLngFrom: LatLng, latLngTo: LatLng) {
        mPolylineOptions!!.add(latLngFrom, latLngTo)
    }

    /**
     * @_routePlanParam walkStep
     */
    private fun addWalkPolyLines(walkStep: WalkStep) {
        mPolylineOptions!!.addAll(AMapServicesUtil.convertArrList(walkStep.polyline))
    }

    /**
     * @_routePlanParam walkStep
     * @_routePlanParam position
     */
    private fun addWalkStationMarkers(walkStep: WalkStep, position: LatLng) {
        addStationMarker(MarkerOptions()
                .position(position)
                .title("\u65B9\u5411:" + walkStep.action
                        + "\n\u9053\u8DEF:" + walkStep.road)
                .snippet(walkStep.instruction).visible(nodeIconVisible)
                .anchor(0.5f, 0.5f).icon(walkStationDescriptor))
    }

    /**
     * 初始化线段属性
     */
    private fun initPolylineOptions() {

        if (walkStationDescriptor == null) {
            walkStationDescriptor = walkBitmapDescriptor
        }

        mPolylineOptions = null

        mPolylineOptions = PolylineOptions()
        mPolylineOptions!!.color(walkColor).width(routeWidth)
    }


    private fun showPolyline() {
        addPolyLine(mPolylineOptions)
    }
}
