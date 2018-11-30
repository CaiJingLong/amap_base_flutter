package me.yohom.amapbase.map.overlay

import android.content.Context
import android.graphics.Color
import com.amap.api.maps.AMap
import com.amap.api.maps.model.*
import com.amap.api.services.core.LatLonPoint
import com.amap.api.services.route.DrivePath
import com.amap.api.services.route.DriveStep
import com.amap.api.services.route.TMC
import me.yohom.amapbase.R
import java.util.*


/**
 * 导航路线图层类。
 */
class DrivingRouteOverlay
/**
 * 根据给定的参数，构造一个导航路线图层类对象。
 *
 * @_routePlanParam amap      地图对象。
 * @_routePlanParam path 导航路线规划方案。
 * @_routePlanParam context   当前的activity对象。
 */
(private val mContext: Context, amap: AMap, private val drivePath: DrivePath?,
 start: LatLonPoint, end: LatLonPoint, private val throughPointList: List<LatLonPoint>?) : RouteOverlay(mContext) {
    private val throughPointMarkerList = ArrayList<Marker>()
    private var throughPointMarkerVisible = true
    private var tmcs: MutableList<TMC>? = null
    private var mPolylineOptions: PolylineOptions? = null
    private var mPolylineOptionscolor: PolylineOptions? = null
    private var isColorfulline = true
    /**
     * 设置路线宽度
     *
     * @_routePlanParam mWidth 路线宽度，取值范围：大于0
     */
    override var routeWidth = 25f
    private var mLatLngsOfPath: MutableList<LatLng>? = null

    protected override val latLngBounds: LatLngBounds
        get() {
            val b = LatLngBounds.builder()
            b.include(LatLng(startPoint!!.latitude, startPoint!!.longitude))
            b.include(LatLng(endPoint!!.latitude, endPoint!!.longitude))
            if (this.throughPointList != null && this.throughPointList.size > 0) {
                for (i in this.throughPointList.indices) {
                    b.include(LatLng(
                            this.throughPointList[i].latitude,
                            this.throughPointList[i].longitude))
                }
            }
            return b.build()
        }

    private val throughPointBitDes: BitmapDescriptor
        get() = BitmapDescriptorFactory.fromResource(R.drawable.amap_through)

    fun setIsColorfulline(iscolorfulline: Boolean) {
        this.isColorfulline = iscolorfulline
    }

    init {
        mAMap = amap
        startPoint = AMapUtil.convertToLatLng(start)
        endPoint = AMapUtil.convertToLatLng(end)
    }

    /**
     * 添加驾车路线添加到地图上显示。
     */
    fun addToMap() {
        initPolylineOptions()
        try {
            if (mAMap == null) {
                return
            }

            if (routeWidth == 0f || drivePath == null) {
                return
            }
            mLatLngsOfPath = ArrayList<LatLng>()
            tmcs = ArrayList()
            val drivePaths = drivePath.steps
            mPolylineOptions!!.add(startPoint)
            for (step in drivePaths) {
                val latlonPoints = step.polyline
                val tmclist = step.tmCs
                tmcs!!.addAll(tmclist)
                addDrivingStationMarkers(step, convertToLatLng(latlonPoints[0]))
                for (latlonpoint in latlonPoints) {
                    mPolylineOptions!!.add(convertToLatLng(latlonpoint))
                    mLatLngsOfPath!!.add(convertToLatLng(latlonpoint))
                }
            }
            mPolylineOptions!!.add(endPoint)
            if (startMarker != null) {
                startMarker!!.remove()
                startMarker = null
            }
            if (endMarker != null) {
                endMarker!!.remove()
                endMarker = null
            }
            addStartAndEndMarker()
            addThroughPointMarker()
            if (isColorfulline && tmcs!!.size > 0) {
                colorWayUpdate(tmcs)
                showcolorPolyline()
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

        mPolylineOptions = null

        mPolylineOptions = PolylineOptions()
        mPolylineOptions!!.color(driveColor).width(routeWidth)
    }

    private fun showPolyline() {
        addPolyLine(mPolylineOptions)
    }

    private fun showcolorPolyline() {
        addPolyLine(mPolylineOptionscolor)

    }

    /**
     * 根据不同的路段拥堵情况展示不同的颜色
     *
     * @_routePlanParam tmcSection
     */
    private fun colorWayUpdate(tmcSection: List<TMC>?) {
        if (mAMap == null) {
            return
        }
        if (tmcSection == null || tmcSection.size <= 0) {
            return
        }
        var segmentTrafficStatus: TMC
        mPolylineOptionscolor = null
        mPolylineOptionscolor = PolylineOptions()
        mPolylineOptionscolor!!.width(routeWidth)
        mPolylineOptionscolor!!.color(driveColor)
        mPolylineOptionscolor!!.add(startPoint)

        mPolylineOptionscolor!!.add(AMapUtil.convertToLatLng(tmcSection[0].polyline[0]))
        for (i in tmcSection.indices) {
            segmentTrafficStatus = tmcSection[i]
            val color = getcolor(segmentTrafficStatus.status)
            val mployline = segmentTrafficStatus.polyline
            mPolylineOptionscolor!!.color(color)
            var lastLanLng: LatLng? = null
            for (j in 1 until mployline.size) {
                lastLanLng = AMapUtil.convertToLatLng(mployline[j])
                mPolylineOptionscolor!!.add(lastLanLng)
            }
            mAMap!!.addPolyline(mPolylineOptionscolor)

            // 准备下一次绘制
            mPolylineOptionscolor = PolylineOptions()
            mPolylineOptionscolor!!.width(routeWidth)
            mPolylineOptionscolor!!.color(driveColor)
            if (lastLanLng != null) {
                mPolylineOptionscolor!!.add(lastLanLng)
            }
        }
        mPolylineOptionscolor!!.add(endPoint)

        mAMap!!.addPolyline(mPolylineOptionscolor)
    }

    private fun getcolor(status: String): Int {

        return if (status == "畅通") {
            Color.GREEN
        } else if (status == "缓行") {
            Color.YELLOW
        } else if (status == "拥堵") {
            Color.RED
        } else if (status == "严重拥堵") {
            Color.parseColor("#990033")
        } else {
            Color.parseColor("#537edc")
        }
    }

    fun convertToLatLng(point: LatLonPoint): LatLng {
        return LatLng(point.latitude, point.longitude)
    }

    /**
     * @_routePlanParam driveStep
     * @_routePlanParam latLng
     */
    private fun addDrivingStationMarkers(driveStep: DriveStep, latLng: LatLng) {
        addStationMarker(MarkerOptions()
                .position(latLng)
                .title("\u65B9\u5411:" + driveStep.action
                        + "\n\u9053\u8DEF:" + driveStep.road)
                .snippet(driveStep.instruction).visible(nodeIconVisible)
                .anchor(0.5f, 0.5f).icon(driveBitmapDescriptor))
    }

    fun setThroughPointIconVisibility(visible: Boolean) {
        try {
            throughPointMarkerVisible = visible
            if (this.throughPointMarkerList != null && this.throughPointMarkerList.size > 0) {
                for (i in this.throughPointMarkerList.indices) {
                    this.throughPointMarkerList[i].setVisible(visible)
                }
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }

    }

    private fun addThroughPointMarker() {
        if (this.throughPointList != null && this.throughPointList.size > 0) {
            var latLonPoint: LatLonPoint? = null
            for (i in this.throughPointList.indices) {
                latLonPoint = this.throughPointList[i]
                if (latLonPoint != null) {
                    throughPointMarkerList.add(mAMap!!
                            .addMarker(MarkerOptions()
                                    .position(
                                            LatLng(latLonPoint
                                                    .latitude, latLonPoint
                                                    .longitude))
                                    .visible(throughPointMarkerVisible)
                                    .icon(throughPointBitDes)
                                    .title("\u9014\u7ECF\u70B9")))
                }
            }
        }
    }

    /**
     * 去掉DriveLineOverlay上的线段和标记。
     */
    override fun removeFromMap() {
        try {
            super.removeFromMap()
            if (this.throughPointMarkerList != null && this.throughPointMarkerList.size > 0) {
                for (i in this.throughPointMarkerList.indices) {
                    this.throughPointMarkerList[i].remove()
                }
                this.throughPointMarkerList.clear()
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }

    }

    companion object {

        /**
         * 获取两点间距离
         *
         * @_routePlanParam start
         * @_routePlanParam end
         * @return
         */
        fun calculateDistance(start: LatLng, end: LatLng): Int {
            val x1 = start.longitude
            val y1 = start.latitude
            val x2 = end.longitude
            val y2 = end.latitude
            return calculateDistance(x1, y1, x2, y2)
        }

        fun calculateDistance(x1: Double, y1: Double, x2: Double, y2: Double): Int {
            var x1 = x1
            var y1 = y1
            var x2 = x2
            var y2 = y2
            val NF_pi = 0.01745329251994329 // 弧度 PI/180
            x1 *= NF_pi
            y1 *= NF_pi
            x2 *= NF_pi
            y2 *= NF_pi
            val sinx1 = Math.sin(x1)
            val siny1 = Math.sin(y1)
            val cosx1 = Math.cos(x1)
            val cosy1 = Math.cos(y1)
            val sinx2 = Math.sin(x2)
            val siny2 = Math.sin(y2)
            val cosx2 = Math.cos(x2)
            val cosy2 = Math.cos(y2)
            val v1 = DoubleArray(3)
            v1[0] = cosy1 * cosx1 - cosy2 * cosx2
            v1[1] = cosy1 * sinx1 - cosy2 * sinx2
            v1[2] = siny1 - siny2
            val dist = Math.sqrt(v1[0] * v1[0] + v1[1] * v1[1] + v1[2] * v1[2])

            return (Math.asin(dist / 2) * 12742001.5798544).toInt()
        }


        //获取指定两点之间固定距离点
        fun getPointForDis(sPt: LatLng, ePt: LatLng, dis: Double): LatLng {
            val lSegLength = calculateDistance(sPt, ePt).toDouble()
            val preResult = dis / lSegLength
            return LatLng((ePt.latitude - sPt.latitude) * preResult + sPt.latitude, (ePt.longitude - sPt.longitude) * preResult + sPt.longitude)
        }
    }
}