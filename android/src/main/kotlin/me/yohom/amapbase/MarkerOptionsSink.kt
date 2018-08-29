package me.yohom.amapbase

import com.amap.api.maps.model.BitmapDescriptor
import com.amap.api.maps.model.LatLng

/** Receiver of Marker configuration options.  */
interface MarkerOptionsSink {
    fun setAlpha(alpha: Float)

    fun setAnchor(u: Float, v: Float)

    fun setConsumeTapEvents(consumesTapEvents: Boolean)

    fun setDraggable(draggable: Boolean)

    fun setFlat(flat: Boolean)

    fun setIcon(bitmapDescriptor: BitmapDescriptor)

    fun setInfoWindowAnchor(u: Float, v: Float)

    fun setInfoWindowText(title: String, snippet: String)

    fun setPosition(position: LatLng)

    fun setRotation(rotation: Float)

    fun setVisible(visible: Boolean)

    fun setZIndex(zIndex: Float)
}
