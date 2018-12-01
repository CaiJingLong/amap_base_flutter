package me.yohom.amapbase.map.overlay

import android.graphics.Color
import com.amap.api.maps.AMap
import com.amap.api.maps.model.*
import com.amap.api.services.core.LatLonPoint
import com.amap.api.services.route.DrivePath
import com.amap.api.services.route.DriveStep
import com.amap.api.services.route.TMC
import me.yohom.amapbase.utils.UnifiedAssets
import me.yohom.amapbase.utils.toLatLng
import java.util.*


/**
 * 导航路线图层类。
 * 根据给定的参数，构造一个导航路线图层类对象。
 *
 * @param map      地图对象。
 * @param drivePath 导航路线规划方案。
 */
class DrivingRouteOverlay(map: AMap,
                          from: LatLonPoint,
                          to: LatLonPoint,
                          private val passbyPointList: List<LatLonPoint>,
                          private val drivePath: DrivePath) : RouteOverlay(map, from.toLatLng(), to.toLatLng()) {
    private val passbyPointMarkerList = ArrayList<Marker>()
    private var passbyPointMarkerVisible = true
    /**
     * 交通拥堵信息
     */
    private var tmcs: MutableList<TMC> = mutableListOf()
    private var polylineOptions: PolylineOptions? = null
    private var polylineOptionsColor: PolylineOptions? = null
    var isColorfulLine = true

    /**
     * 设置路线宽度 路线宽度，取值范围：大于0
     */
    override var routeWidth = 25f
    private var latLngsOfPath: MutableList<LatLng> = mutableListOf()

    override val latLngBounds: LatLngBounds
        get() {
            val b = LatLngBounds.builder()
            b.include(from)
            passbyPointList.forEach { b.include(it.toLatLng()) }
            b.include(to)
            return b.build()
        }

    private val passbyPointBitDes: BitmapDescriptor = UnifiedAssets.getBitmapDescriptor("images/amap_through.png")

    /**
     * 添加驾车路线添加到地图上显示。
     */
    fun addToMap() {
        initPolylineOptions()
        try {
            if (routeWidth == 0f) {
                return
            }

            latLngsOfPath = ArrayList()
            tmcs = ArrayList()
            val drivePaths = drivePath.steps
            polylineOptions!!.add(from)
            for (step in drivePaths) {
                val latlonPoints = step.polyline
                val tmclist = step.tmCs
                tmcs.addAll(tmclist)
                addDrivingStationMarkers(step, convertToLatLng(latlonPoints[0]))
                for (latlonpoint in latlonPoints) {
                    polylineOptions!!.add(convertToLatLng(latlonpoint))
                    latLngsOfPath.add(convertToLatLng(latlonpoint))
                }
            }
            polylineOptions!!.add(to)
            if (fromMarker != null) {
                fromMarker!!.remove()
                fromMarker = null
            }
            if (toMarker != null) {
                toMarker!!.remove()
                toMarker = null
            }
            addFromAndToMarker()
            addPassbyMarker()
            if (isColorfulLine && tmcs.size > 0) {
                colorWayUpdate(tmcs)
                showColorPolyline()
            } else {
                showPolyline()
            }

        } catch (e: Throwable) {
            e.printStackTrace()
        }

    }

    /**
     * 初始化线段属性
     */
    private fun initPolylineOptions() {
        polylineOptions = null

        polylineOptions = PolylineOptions()
        polylineOptions!!.color(driveColor).width(routeWidth)
    }

    private fun showPolyline() {
        addPolyLine(polylineOptions!!)
    }

    private fun showColorPolyline() {
        addPolyLine(polylineOptionsColor!!)
    }

    /**
     * 根据不同的路段拥堵情况展示不同的颜色
     *
     * @routePlanParam tmcSection
     */
    private fun colorWayUpdate(tmcSection: List<TMC>?) {
        if (tmcSection == null || tmcSection.isEmpty()) {
            return
        }
        var segmentTrafficStatus: TMC
        polylineOptionsColor = null
        polylineOptionsColor = PolylineOptions()
        polylineOptionsColor!!.width(routeWidth)
        polylineOptionsColor!!.color(driveColor)
        polylineOptionsColor!!.add(from)

        polylineOptionsColor!!.add(tmcSection[0].polyline[0].toLatLng())
        for (i in tmcSection.indices) {
            segmentTrafficStatus = tmcSection[i]
            val color = getColor(segmentTrafficStatus.status)
            val ployline = segmentTrafficStatus.polyline
            polylineOptionsColor!!.color(color)
            var lastLanLng: LatLng? = null
            for (j in 1 until ployline.size) {
                lastLanLng = ployline[j].toLatLng()
                polylineOptionsColor!!.add(lastLanLng)
            }
            map.addPolyline(polylineOptionsColor)

            // 准备下一次绘制
            polylineOptionsColor = PolylineOptions()
            polylineOptionsColor!!.width(routeWidth)
            polylineOptionsColor!!.color(driveColor)
            if (lastLanLng != null) {
                polylineOptionsColor!!.add(lastLanLng)
            }
        }
        polylineOptionsColor!!.add(to)

        map.addPolyline(polylineOptionsColor)
    }

    private fun getColor(status: String): Int {
        return when (status) {
            "畅通" -> Color.GREEN
            "缓行" -> Color.YELLOW
            "拥堵" -> Color.RED
            "严重拥堵" -> Color.parseColor("#990033")
            else -> Color.parseColor("#537edc")
        }
    }

    private fun convertToLatLng(point: LatLonPoint): LatLng {
        return LatLng(point.latitude, point.longitude)
    }

    /**
     * @param driveStep
     * @param latLng
     */
    private fun addDrivingStationMarkers(driveStep: DriveStep, latLng: LatLng) {
        addStationMarker(MarkerOptions()
                .position(latLng)
                .title("\u65B9\u5411:" + driveStep.action
                        + "\n\u9053\u8DEF:" + driveStep.road)
                .snippet(driveStep.instruction).visible(nodeIconVisible)
                .anchor(0.5f, 0.5f).icon(driveBitmapDescriptor))
    }

    private fun addPassbyMarker() {
        if (passbyPointList.isNotEmpty()) {
            var latLonPoint: LatLonPoint?
            for (i in passbyPointList.indices) {
                latLonPoint = passbyPointList[i]
                passbyPointMarkerList.add(map
                        .addMarker(MarkerOptions()
                                .position(
                                        LatLng(latLonPoint
                                                .latitude, latLonPoint
                                                .longitude))
                                .visible(passbyPointMarkerVisible)
                                .icon(passbyPointBitDes)
                                .title("\u9014\u7ECF\u70B9")))
            }
        }
    }

    /**
     * 去掉DriveLineOverlay上的线段和标记。
     */
    override fun removeFromMap() {
        try {
            super.removeFromMap()
            if (this.passbyPointMarkerList.size > 0) {
                for (i in this.passbyPointMarkerList.indices) {
                    this.passbyPointMarkerList[i].remove()
                }
                this.passbyPointMarkerList.clear()
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }

    }
}