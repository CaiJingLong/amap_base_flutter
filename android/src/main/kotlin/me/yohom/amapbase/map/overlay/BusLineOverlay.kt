package me.yohom.amapbase.map.overlay

import android.content.Context
import android.graphics.Color
import com.amap.api.maps.AMap
import com.amap.api.maps.CameraUpdateFactory
import com.amap.api.maps.model.*
import com.amap.api.services.busline.BusLineItem
import com.amap.api.services.busline.BusStationItem
import com.amap.api.services.core.LatLonPoint
import me.yohom.amapbase.R
import java.util.*

/**
 * 公交线路图层类。在高德地图API里，如果要显示公交线路，可以用此类来创建公交线路图层。如不满足需求，也可以自己创建自定义的公交线路图层。
 *
 * @since V2.1.0
 */
class BusLineOverlay
/**
 * 通过此构造函数创建公交线路图层。
 *
 * @param context     当前activity。
 * @param amap        地图对象。
 * @param busLineItem 公交线路。详见搜索服务模块的公交线路和公交站点包（com.amap.api.services.busline）中的类 **[BusStationItem](../../../../../../Search/com/amap/api/services/busline/BusStationItem.html)**。
 * @since V2.1.0
 */
(private val mContext: Context, private val mAMap: AMap?, private val mBusLineItem: BusLineItem) {
    private val mBusStationMarks = ArrayList<Marker>()
    private var mBusLinePolyline: Polyline? = null
    private val mBusStations: List<BusStationItem>
    private var startBit: BitmapDescriptor? = null
    private var endBit: BitmapDescriptor? = null
    private var busBit: BitmapDescriptor? = null

    protected val startBitmapDescriptor: BitmapDescriptor?
        get() {
            startBit = BitmapDescriptorFactory.fromResource(R.drawable.amap_start)
            return startBit
        }

    protected val endBitmapDescriptor: BitmapDescriptor?
        get() {
            endBit = BitmapDescriptorFactory.fromResource(R.drawable.amap_end)
            return endBit
        }

    protected val busBitmapDescriptor: BitmapDescriptor?
        get() {
            busBit = BitmapDescriptorFactory.fromResource(R.drawable.amap_bus)
            return busBit
        }

    protected val busColor: Int
        get() = Color.parseColor("#537edc")

    protected val buslineWidth: Float
        get() = 18f

    init {
        mBusStations = mBusLineItem.busStations
    }

    /**
     * 添加公交线路到地图中。
     *
     * @since V2.1.0
     */
    fun addToMap() {
        try {
            val pointList = mBusLineItem.directionsCoordinates
            val listPolyline = AMapServicesUtil.convertArrList(pointList)
            mBusLinePolyline = mAMap!!.addPolyline(PolylineOptions()
                    .addAll(listPolyline).color(busColor)
                    .width(buslineWidth))
            if (mBusStations.size < 1) {
                return
            }
            for (i in 1 until mBusStations.size - 1) {
                val marker = mAMap!!.addMarker(getMarkerOptions(i))
                mBusStationMarks.add(marker)
            }
            val markerStart = mAMap!!.addMarker(getMarkerOptions(0))
            mBusStationMarks.add(markerStart)
            val markerEnd = mAMap!!
                    .addMarker(getMarkerOptions(mBusStations.size - 1))
            mBusStationMarks.add(markerEnd)
        } catch (e: Throwable) {
            e.printStackTrace()
        }

    }

    /**
     * 去掉BusLineOverlay上所有的Marker。
     *
     * @since V2.1.0
     */
    fun removeFromMap() {
        if (mBusLinePolyline != null) {
            mBusLinePolyline!!.remove()
        }
        try {
            for (mark in mBusStationMarks) {
                mark.remove()
            }
            destroyBit()
        } catch (e: Throwable) {
            e.printStackTrace()
        }

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
    }

    /**
     * 移动镜头到当前的视角。
     *
     * @since V2.1.0
     */
    fun zoomToSpan() {
        if (mAMap == null)
            return
        try {
            val coordin = mBusLineItem.directionsCoordinates
            if (coordin != null && coordin.size > 0) {
                val bounds = getLatLngBounds(coordin)
                mAMap!!.moveCamera(CameraUpdateFactory.newLatLngBounds(bounds, 5))
            }
        } catch (e: Throwable) {
            e.printStackTrace()
        }

    }

    private fun getLatLngBounds(coordin: List<LatLonPoint>): LatLngBounds {
        val b = LatLngBounds.builder()
        for (i in coordin.indices) {
            b.include(LatLng(coordin[i].latitude, coordin[i]
                    .longitude))
        }
        return b.build()
    }

    private fun getMarkerOptions(index: Int): MarkerOptions {
        val options = MarkerOptions()
                .position(
                        LatLng(mBusStations[index].latLonPoint
                                .latitude, mBusStations[index]
                                .latLonPoint.longitude))
                .title(getTitle(index)).snippet(getSnippet(index))
        if (index == 0) {
            options.icon(startBitmapDescriptor)
        } else if (index == mBusStations.size - 1) {
            options.icon(endBitmapDescriptor)
        } else {
            options.anchor(0.5f, 0.5f)
            options.icon(busBitmapDescriptor)
        }
        return options
    }

    /**
     * 返回第index的Marker的标题。
     *
     * @param index 第几个Marker。
     * @return marker的标题。
     * @since V2.1.0
     */
    protected fun getTitle(index: Int): String {
        return mBusStations[index].busStationName

    }

    /**
     * 返回第index的Marker的详情。
     *
     * @param index 第几个Marker。
     * @return marker的详情。
     * @since V2.1.0
     */
    protected fun getSnippet(index: Int): String {
        return ""
    }

    /**
     * 从marker中得到公交站点在list的位置。
     *
     * @param marker 一个标记的对象。
     * @return 返回该marker对应的公交站点在list的位置。
     * @since V2.1.0
     */
    fun getBusStationIndex(marker: Marker): Int {
        for (i in mBusStationMarks.indices) {
            if (mBusStationMarks[i].equals(marker)) {
                return i
            }
        }
        return -1
    }

    /**
     * 返回第index的公交站点的信息。
     *
     * @param index 第几个公交站点。
     * @return 公交站点的信息。详见搜索服务模块的公交线路和公交站点包（com.amap.api.services.busline）中的类 **[BusStationItem](../../../../../../Search/com/amap/api/services/busline/BusStationItem.html)**。
     * @since V2.1.0
     */
    fun getBusStationItem(index: Int): BusStationItem? {
        return if (index < 0 || index >= mBusStations.size) {
            null
        } else mBusStations[index]
    }
}
