package me.yohom.amapbase.map.overlay

import android.graphics.Color
import com.amap.api.maps.AMap
import com.amap.api.maps.model.*
import com.amap.api.services.core.LatLonPoint
import me.yohom.amapbase.common.UnifiedAssets
import me.yohom.amapbase.map.model.UnifiedDrivePath
import me.yohom.amapbase.map.model.UnifiedDriveStep
import me.yohom.amapbase.map.model.UnifiedTMC
import java.util.*


/**
 * 导航路线图层类。
 * 根据给定的参数，构造一个导航路线图层类对象。
 *
 * @param map      地图对象。
 * @param drivePath 导航路线规划方案。
 */
class DrivingRouteOverlay(map: AMap,
                          from: LatLng,
                          to: LatLng,
                          private val passbyPointList: List<LatLng>,
                          private val drivePath: UnifiedDrivePath) : RouteOverlay(map, from, to) {
    private val passbyMarkerList = arrayListOf<Marker>()
    private var passbyMarkerVisible = true
    /**
     * 交通拥堵信息
     */
    private var tmcs: MutableList<UnifiedTMC> = mutableListOf()
    private var polylineOptions: PolylineOptions = PolylineOptions()
    private var polylineOptionsColor: PolylineOptions = PolylineOptions()
    private var isColorfulLine = true

    /**
     * 设置路线宽度 路线宽度，取值范围：大于0
     */
    override var routeWidth = 25f
    private var latLngsOfPath: MutableList<LatLng> = mutableListOf()

    override val latLngBounds: LatLngBounds
        get() {
            val b = LatLngBounds.builder()
            b.include(from)
            passbyPointList.forEach { b.include(it) }
            b.include(to)
            return b.build()
        }

    private val passbyPointBitDes: BitmapDescriptor = UnifiedAssets.getDefaultBitmapDescriptor("images/amap_through.png")

    /**
     * 添加驾车路线添加到地图上显示。
     */
    fun addToMap() {
        initPolylineOptions()
        if (routeWidth == 0f) return

        latLngsOfPath = ArrayList()
        tmcs = ArrayList()
        val drivePaths = drivePath.steps
        polylineOptions.add(from)
        for (step in drivePaths) {
            val latlonPoints = step.polyline

            tmcs.addAll(step.TMCs)

            addDrivingStationMarkers(step, latlonPoints[0])

            latlonPoints.forEach {
                polylineOptions.add(it)
                latLngsOfPath.add(it)
            }
        }
        polylineOptions.add(to)

        fromMarker?.remove()
        toMarker?.remove()

        addFromAndToMarker()
        addPassbyMarker()
        if (isColorfulLine && tmcs.size > 0) {
            colorWayUpdate(tmcs)
            showColorPolyline()
        } else {
            showPolyline()
        }
    }

    /**
     * 初始化线段属性
     */
    private fun initPolylineOptions() {
        polylineOptions.color(driveColor).width(routeWidth)
    }

    private fun showPolyline() {
        addPolyLine(polylineOptions)
    }

    private fun showColorPolyline() {
        addPolyLine(polylineOptionsColor)
    }

    /**
     * 根据不同的路段拥堵情况展示不同的颜色
     *
     * @routePlanParam tmcSection
     */
    private fun colorWayUpdate(tmcSection: List<UnifiedTMC>?) {
        if (tmcSection == null || tmcSection.isEmpty()) {
            return
        }
        var segmentTrafficStatus: UnifiedTMC
        polylineOptionsColor = PolylineOptions()
        polylineOptionsColor.width(routeWidth)
        polylineOptionsColor.color(driveColor)
        polylineOptionsColor.add(from)

        polylineOptionsColor.add(tmcSection[0].polyline[0])
        for (i in tmcSection.indices) {
            segmentTrafficStatus = tmcSection[i]
            val color = getColor(segmentTrafficStatus.status)
            val ployline = segmentTrafficStatus.polyline
            polylineOptionsColor.color(color)
            var lastLanLng: LatLng? = null
            for (j in 1 until ployline.size) {
                lastLanLng = ployline[j]
                polylineOptionsColor.add(lastLanLng)
            }
            map.addPolyline(polylineOptionsColor)

            // 准备下一次绘制
            polylineOptionsColor = PolylineOptions()
            polylineOptionsColor.width(routeWidth)
            polylineOptionsColor.color(driveColor)
            if (lastLanLng != null) {
                polylineOptionsColor.add(lastLanLng)
            }
        }
        polylineOptionsColor.add(to)

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
    private fun addDrivingStationMarkers(driveStep: UnifiedDriveStep, latLng: LatLng) {
        addStationMarker(MarkerOptions()
                .position(latLng)
                .title("\u65B9\u5411:" + driveStep.action
                        + "\n\u9053\u8DEF:" + driveStep.road)
                .snippet(driveStep.instruction).visible(nodeIconVisible)
                .anchor(0.5f, 0.5f).icon(driveBitmapDescriptor))
    }

    private fun addPassbyMarker() {
        if (passbyPointList.isNotEmpty()) {
            var latLonPoint: LatLng?
            for (i in passbyPointList.indices) {
                latLonPoint = passbyPointList[i]
                passbyMarkerList.add(map
                        .addMarker(MarkerOptions()
                                .position(
                                        LatLng(latLonPoint
                                                .latitude, latLonPoint
                                                .longitude))
                                .visible(passbyMarkerVisible)
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
            if (passbyMarkerList.size > 0) {
                for (i in passbyMarkerList.indices) {
                    passbyMarkerList[i].remove()
                }
                passbyMarkerList.clear()
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }

    }
}