package me.yohom.amapbase.map

import android.graphics.Point
import com.amap.api.maps.CameraUpdate
import com.amap.api.maps.CameraUpdateFactory
import com.amap.api.maps.model.*
import io.flutter.view.FlutterMain
import java.util.*

/** Conversions between JSON-like values and AMaps data types.  */
object Convert {
    private fun toBitmapDescriptor(o: Any): BitmapDescriptor {
        val data = toList(o)
        when (toString(data[0]!!)) {
            "defaultMarker" -> return if (data.size == 1) {
                BitmapDescriptorFactory.defaultMarker()
            } else {
                BitmapDescriptorFactory.defaultMarker(toFloat(data[1]!!))
            }
            "fromAsset" -> return if (data.size == 2) {
                BitmapDescriptorFactory.fromAsset(
                        FlutterMain.getLookupKeyForAsset(toString(data[1]!!)))
            } else {
                BitmapDescriptorFactory.fromAsset(
                        FlutterMain.getLookupKeyForAsset(toString(data[1]!!), toString(data[2]!!)))
            }
        }
        throw IllegalArgumentException("Cannot interpret $o as BitmapDescriptor")
    }

    private fun toBoolean(o: Any): Boolean {
        return o as Boolean
    }

    private fun toCameraPosition(o: Any): CameraPosition {
        val data = toMap(o)
        val builder = CameraPosition.builder()
        builder.bearing(toFloat(data["bearing"]!!))
        builder.target(toLatLng(data["target"]!!))
        builder.tilt(toFloat(data["tilt"]!!))
        builder.zoom(toFloat(data["zoom"]!!))
        return builder.build()
    }

    fun toCameraUpdate(o: Any, density: Float): CameraUpdate {
        val data = toList(o)
        when (toString(data[0]!!)) {
            "newCameraPosition" -> return CameraUpdateFactory.newCameraPosition(toCameraPosition(data[1]!!))
            "newLatLng" -> return CameraUpdateFactory.newLatLng(toLatLng(data[1]!!))
            "newLatLngBounds" -> return CameraUpdateFactory.newLatLngBounds(
                    toLatLngBounds(data[1]), toPixels(data[2]!!, density))
            "newLatLngZoom" -> return CameraUpdateFactory.newLatLngZoom(toLatLng(data[1]!!), toFloat(data[2]!!))
            "scrollBy" -> return CameraUpdateFactory.scrollBy( //
                    toFractionalPixels(data[1]!!, density), //
                    toFractionalPixels(data[2]!!, density))
            "zoomBy" -> return if (data.size == 2) {
                CameraUpdateFactory.zoomBy(toFloat(data[1]!!))
            } else {
                CameraUpdateFactory.zoomBy(toFloat(data[1]!!), toPoint(data[2]!!, density))
            }
            "zoomIn" -> return CameraUpdateFactory.zoomIn()
            "zoomOut" -> return CameraUpdateFactory.zoomOut()
            "zoomTo" -> return CameraUpdateFactory.zoomTo(toFloat(data[1]!!))
        }
        throw IllegalArgumentException("Cannot interpret $o as CameraUpdate")
    }

    private fun toDouble(o: Any): Double {
        return (o as Number).toDouble()
    }

    private fun toFloat(o: Any): Float {
        return (o as Number).toFloat()
    }

    private fun toFloatWrapper(o: Any?): Float? {
        return if (o == null) null else toFloat(o)
    }

    fun toInt(o: Any): Int {
        return (o as Number).toInt()
    }

    fun toJson(position: CameraPosition?): Any? {
        if (position == null) {
            return null
        }
        val data = HashMap<String, Any>()
        data["bearing"] = position.bearing
        data["target"] = toJson(position.target)
        data["tilt"] = position.tilt
        data["zoom"] = position.zoom
        return data
    }

    private fun toJson(latLng: LatLng): Any {
        return Arrays.asList(latLng.latitude, latLng.longitude)
    }

    private fun toLatLng(o: Any): LatLng {
        val data = toList(o)
        return LatLng(toDouble(data[0]!!), toDouble(data[1]!!))
    }

    private fun toLatLngBounds(o: Any?): LatLngBounds? {
        if (o == null) {
            return null
        }
        val data = toList(o)
        return LatLngBounds(toLatLng(data[0]!!), toLatLng(data[1]!!))
    }

    private fun toList(o: Any): List<*> {
        return o as List<*>
    }

    fun toLong(o: Any): Long {
        return (o as Number).toLong()
    }

    fun toMap(o: Any): Map<*, *> {
        return o as Map<*, *>
    }

    private fun toFractionalPixels(o: Any, density: Float): Float {
        return toFloat(o) * density
    }

    fun toPixels(o: Any, density: Float): Int {
        return toFractionalPixels(o, density).toInt()
    }

    private fun toPoint(o: Any, density: Float): Point {
        val data = toList(o)
        return Point(toPixels(data[0]!!, density), toPixels(data[1]!!, density))
    }

    private fun toString(o: Any): String {
        return o as String
    }

    fun interpretGoogleMapOptions(params: Any, sink: AMapOptionsSink) {
        val data = toMap(params)
        val cameraPosition = data["cameraPosition"]
        if (cameraPosition != null) {
            sink.setCameraPosition(toCameraPosition(cameraPosition))
        }
        val cameraTargetBounds = data["cameraTargetBounds"]
//        if (cameraTargetBounds != null) {
//            val targetData = toList(cameraTargetBounds)
//            sink.setCameraTargetBounds(toLatLngBounds(targetData[0])!!)
//        }
        val compassEnabled = data["compassEnabled"]
        if (compassEnabled != null) {
            sink.setCompassEnabled(toBoolean(compassEnabled))
        }
        val mapType = data["mapType"]
        if (mapType != null) {
            sink.setMapType(toInt(mapType))
        }
        val minMaxZoomPreference = data["minMaxZoomPreference"]
        if (minMaxZoomPreference != null) {
            val zoomPreferenceData = toList(minMaxZoomPreference)
            sink.setMinMaxZoomPreference( //
                    toFloatWrapper(zoomPreferenceData[0]), //
                    toFloatWrapper(zoomPreferenceData[1]))
        }
        val rotateGesturesEnabled = data["rotateGesturesEnabled"]
        if (rotateGesturesEnabled != null) {
            sink.setRotateGesturesEnabled(toBoolean(rotateGesturesEnabled))
        }
        val scrollGesturesEnabled = data["scrollGesturesEnabled"]
        if (scrollGesturesEnabled != null) {
            sink.setScrollGesturesEnabled(toBoolean(scrollGesturesEnabled))
        }
        val tiltGesturesEnabled = data["tiltGesturesEnabled"]
        if (tiltGesturesEnabled != null) {
            sink.setTiltGesturesEnabled(toBoolean(tiltGesturesEnabled))
        }
        val trackCameraPosition = data["trackCameraPosition"]
        if (trackCameraPosition != null) {
            sink.setTrackCameraPosition(toBoolean(trackCameraPosition))
        }
        val zoomGesturesEnabled = data["zoomGesturesEnabled"]
        if (zoomGesturesEnabled != null) {
            sink.setZoomGesturesEnabled(toBoolean(zoomGesturesEnabled))
        }
    }

    fun interpretMarkerOptions(o: Any, sink: MarkerOptionsSink) {
        val data = toMap(o)
        val alpha = data["alpha"]
        if (alpha != null) {
            sink.setAlpha(toFloat(alpha))
        }
        val anchor = data["anchor"]
        if (anchor != null) {
            val anchorData = toList(anchor)
            sink.setAnchor(toFloat(anchorData[0]!!), toFloat(anchorData[1]!!))
        }
        val consumesTapEvents = data["consumesTapEvents"]
        if (consumesTapEvents != null) {
            sink.setConsumeTapEvents(toBoolean(consumesTapEvents))
        }
        val draggable = data["draggable"]
        if (draggable != null) {
            sink.setDraggable(toBoolean(draggable))
        }
        val flat = data["flat"]
        if (flat != null) {
            sink.setFlat(toBoolean(flat))
        }
        val icon = data["icon"]
        if (icon != null) {
            sink.setIcon(toBitmapDescriptor(icon))
        }
        val infoWindowAnchor = data["infoWindowAnchor"]
        if (infoWindowAnchor != null) {
            val anchorData = toList(infoWindowAnchor)
            sink.setInfoWindowAnchor(toFloat(anchorData[0]!!), toFloat(anchorData[1]!!))
        }
        val infoWindowText = data["infoWindowText"]
        if (infoWindowText != null) {
            val textData = toList(infoWindowText)
            sink.setInfoWindowText(toString(textData[0]!!), toString(textData[1]!!))
        }
        val position = data["position"]
        if (position != null) {
            sink.setPosition(toLatLng(position))
        }
        val rotation = data["rotation"]
        if (rotation != null) {
            sink.setRotation(toFloat(rotation))
        }
        val visible = data["visible"]
        if (visible != null) {
            sink.setVisible(toBoolean(visible))
        }
        val zIndex = data["zIndex"]
        if (zIndex != null) {
            sink.setZIndex(toFloat(zIndex))
        }
    }
}
