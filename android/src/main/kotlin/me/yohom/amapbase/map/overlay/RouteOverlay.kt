package me.yohom.amapbase.map.overlay

import android.graphics.Bitmap
import android.graphics.Color
import com.amap.api.maps.AMap
import com.amap.api.maps.CameraUpdateFactory
import com.amap.api.maps.model.*
import me.yohom.amapbase.utils.UnifiedAssets

open class RouteOverlay(val map: AMap,
                        val from: LatLng,
                        val to: LatLng) {

    private var stationMarkers: MutableList<Marker> = mutableListOf()
    private var allPolyLines: MutableList<Polyline> = mutableListOf()
    protected var fromMarker: Marker? = null
    protected var toMarker: Marker? = null
    private var startBit: Bitmap? = null
    private var endBit: Bitmap? = null
    private var driveBit: Bitmap? = null

    /**
     * 路段节点图标控制显示
     */
    var nodeIconVisible = true
        set(value) {
            field = value
            stationMarkers.forEach { it.isVisible = value }
        }

    /**
     * 给起点Marker设置图标，并返回更换图标的图片。如不用默认图片，需要重写此方法。
     */
    private val startBitmapDescriptor: BitmapDescriptor = UnifiedAssets.getAMapBitmapDescriptor("images/amap_start.png")

    /**
     * 给终点Marker设置图标，并返回更换图标的图片。如不用默认图片，需要重写此方法。
     */
    private val endBitmapDescriptor: BitmapDescriptor = UnifiedAssets.getAMapBitmapDescriptor("images/amap_end.png")

    protected val driveBitmapDescriptor: BitmapDescriptor = UnifiedAssets.getAMapBitmapDescriptor("images/car.png")

    protected open val latLngBounds: LatLngBounds
        get() {
            val b = LatLngBounds.builder()
            b.include(from)
            b.include(to)
            return b.build()
        }

    protected open val routeWidth: Float = 18f

    protected val driveColor: Int = Color.parseColor("#537edc")

    /**
     * 去掉BusRouteOverlay上所有的Marker。
     * @since V2.1.0
     */
    open fun removeFromMap() {
        fromMarker?.remove()
        toMarker?.remove()
        for (marker in stationMarkers) {
            marker.remove()
        }
        for (line in allPolyLines) {
            line.remove()
        }
        destroyBit()
    }

    private fun destroyBit() {
        startBit?.recycle()
        startBit = null
        endBit?.recycle()
        endBit = null

        driveBit?.recycle()
        driveBit = null
    }

    protected fun addFromAndToMarker() {
        fromMarker = map.addMarker(MarkerOptions()
                .position(from).icon(startBitmapDescriptor)
                .title("\u8D77\u70B9"))

        toMarker = map.addMarker(MarkerOptions().position(to)
                .icon(endBitmapDescriptor).title("\u7EC8\u70B9"))
    }

    /**
     * 移动镜头到当前的视角。
     * @since V2.1.0
     */
    fun zoomToSpan() {
        val bounds = latLngBounds
        map.animateCamera(CameraUpdateFactory.newLatLngBounds(bounds, 100))
    }

    protected fun addStationMarker(options: MarkerOptions?) {
        if (options == null) {
            return
        }
        val marker = map.addMarker(options)
        if (marker != null) {
            stationMarkers.add(marker)
        }

    }

    protected fun addPolyLine(options: PolylineOptions) {
        val polyline = map.addPolyline(options)
        if (polyline != null) {
            allPolyLines.add(polyline)
        }
    }
}
