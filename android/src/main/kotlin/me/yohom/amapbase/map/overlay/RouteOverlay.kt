package me.yohom.amapbase.map.overlay

import android.content.Context
import android.graphics.Bitmap
import android.graphics.Color
import com.amap.api.maps.AMap
import com.amap.api.maps.CameraUpdateFactory
import com.amap.api.maps.model.*
import me.yohom.amapbase.R
import java.util.*

open class RouteOverlay(private val mContext: Context) {
    protected var stationMarkers: MutableList<Marker>? = ArrayList<Marker>()
    protected var allPolyLines: MutableList<Polyline> = ArrayList<Polyline>()
    protected var startMarker: Marker? = null
    protected var endMarker: Marker? = null
    protected var startPoint: LatLng? = null
    protected var endPoint: LatLng? = null
    protected var mAMap: AMap? = null
    private var startBit: Bitmap? = null
    private var endBit: Bitmap? = null
    private var busBit: Bitmap? = null
    private var walkBit: Bitmap? = null
    private var driveBit: Bitmap? = null
    protected var nodeIconVisible = true
    /**
     * 给起点Marker设置图标，并返回更换图标的图片。如不用默认图片，需要重写此方法。
     * @return 更换的Marker图片。
     * @since V2.1.0
     */
    protected val startBitmapDescriptor: BitmapDescriptor
        get() = BitmapDescriptorFactory.fromResource(R.drawable.amap_start)
    /**
     * 给终点Marker设置图标，并返回更换图标的图片。如不用默认图片，需要重写此方法。
     * @return 更换的Marker图片。
     * @since V2.1.0
     */
    protected val endBitmapDescriptor: BitmapDescriptor
        get() = BitmapDescriptorFactory.fromResource(R.drawable.amap_end)
    /**
     * 给公交Marker设置图标，并返回更换图标的图片。如不用默认图片，需要重写此方法。
     * @return 更换的Marker图片。
     * @since V2.1.0
     */
    protected val busBitmapDescriptor: BitmapDescriptor
        get() = BitmapDescriptorFactory.fromResource(R.drawable.amap_bus)
    /**
     * 给步行Marker设置图标，并返回更换图标的图片。如不用默认图片，需要重写此方法。
     * @return 更换的Marker图片。
     * @since V2.1.0
     */
    protected val walkBitmapDescriptor: BitmapDescriptor
        get() = BitmapDescriptorFactory.fromResource(R.drawable.amap_man)

    protected val driveBitmapDescriptor: BitmapDescriptor
        get() = BitmapDescriptorFactory.fromResource(R.drawable.amap_car)

    protected open val latLngBounds: LatLngBounds
        get() {
            val b = LatLngBounds.builder()
            b.include(LatLng(startPoint!!.latitude, startPoint!!.longitude))
            b.include(LatLng(endPoint!!.latitude, endPoint!!.longitude))
            return b.build()
        }

    protected open val routeWidth: Float
        get() = 18f

    protected val walkColor: Int
        get() = Color.parseColor("#6db74d")

    /**
     * 自定义路线颜色。
     * return 自定义路线颜色。
     * @since V2.2.1
     */
    protected val busColor: Int
        get() = Color.parseColor("#537edc")

    protected val driveColor: Int
        get() = Color.parseColor("#537edc")

    /**
     * 去掉BusRouteOverlay上所有的Marker。
     * @since V2.1.0
     */
    open fun removeFromMap() {
        if (startMarker != null) {
            startMarker!!.remove()

        }
        if (endMarker != null) {
            endMarker!!.remove()
        }
        for (marker in stationMarkers!!) {
            marker.remove()
        }
        for (line in allPolyLines) {
            line.remove()
        }
        destroyBit()
    }

    private fun destroyBit() {
        if (startBit != null) {
            startBit!!.recycle()
            startBit = null
        }
        if (endBit != null) {
            endBit!!.recycle()
            endBit = null
        }
        if (busBit != null) {
            busBit!!.recycle()
            busBit = null
        }
        if (walkBit != null) {
            walkBit!!.recycle()
            walkBit = null
        }
        if (driveBit != null) {
            driveBit!!.recycle()
            driveBit = null
        }
    }

    protected fun addStartAndEndMarker() {
        startMarker = mAMap!!.addMarker(MarkerOptions()
                .position(startPoint).icon(startBitmapDescriptor)
                .title("\u8D77\u70B9"))
        // startMarker.showInfoWindow();

        endMarker = mAMap!!.addMarker(MarkerOptions().position(endPoint)
                .icon(endBitmapDescriptor).title("\u7EC8\u70B9"))
        // mAMap.moveCamera(CameraUpdateFactory.newLatLngZoom(startPoint,
        // getShowRouteZoom()));
    }

    /**
     * 移动镜头到当前的视角。
     * @since V2.1.0
     */
    fun zoomToSpan() {
        if (startPoint != null) {
            if (mAMap == null) {
                return
            }
            try {
                val bounds = latLngBounds
                mAMap!!.animateCamera(CameraUpdateFactory
                        .newLatLngBounds(bounds, 100))
            } catch (e: Throwable) {
                e.printStackTrace()
            }

        }
    }

    /**
     * 路段节点图标控制显示接口。
     * @_routePlanParam visible true为显示节点图标，false为不显示。
     * @since V2.3.1
     */
    fun setNodeIconVisibility(visible: Boolean) {
        try {
            nodeIconVisible = visible
            if (this.stationMarkers != null && this.stationMarkers!!.size > 0) {
                for (i in this.stationMarkers!!.indices) {
                    this.stationMarkers!![i].setVisible(visible)
                }
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }

    }

    protected fun addStationMarker(options: MarkerOptions?) {
        if (options == null) {
            return
        }
        val marker = mAMap!!.addMarker(options)
        if (marker != null) {
            stationMarkers!!.add(marker)
        }

    }

    protected fun addPolyLine(options: PolylineOptions?) {
        if (options == null) {
            return
        }
        val polyline = mAMap!!.addPolyline(options)
        if (polyline != null) {
            allPolyLines.add(polyline)
        }
    }

    // protected int getShowRouteZoom() {
    // return 15;
    // }
}
