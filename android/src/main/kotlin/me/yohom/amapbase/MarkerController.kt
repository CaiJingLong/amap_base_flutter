package me.yohom.amapbase

import com.amap.api.maps.model.BitmapDescriptor
import com.amap.api.maps.model.LatLng
import com.amap.api.maps.model.Marker

/** Controller of a single Marker on the map.  */
class MarkerController(
        private val marker: Marker,
        private var consumeTapEvents: Boolean,
        private val onTappedListener: OnMarkerTappedListener?
) : MarkerOptionsSink {

    fun onTap(): Boolean {
        onTappedListener?.onMarkerTapped(marker)
        return consumeTapEvents
    }

    fun remove() {
        marker.remove()
    }

    override fun setAlpha(alpha: Float) {
        marker.alpha = alpha
    }

    override fun setAnchor(u: Float, v: Float) {
        marker.setAnchor(u, v)
    }

    override fun setConsumeTapEvents(consumesTapEvents: Boolean) {
        this.consumeTapEvents = consumesTapEvents
    }

    override fun setDraggable(draggable: Boolean) {
        marker.isDraggable = draggable
    }

    override fun setFlat(flat: Boolean) {
        marker.isFlat = flat
    }

    override fun setIcon(bitmapDescriptor: BitmapDescriptor) {
        marker.setIcon(bitmapDescriptor)
    }

    override fun setInfoWindowAnchor(u: Float, v: Float) {
        // fixme: 跟GMap api有出入
        marker.setAnchor(u, v)
    }

    override fun setInfoWindowText(title: String, snippet: String) {
        marker.title = title
        marker.snippet = snippet
    }

    override fun setPosition(position: LatLng) {
        marker.position = position
    }

    override fun setRotation(rotation: Float) {
        // fixme: 跟GMap api有出入
        marker.rotateAngle = rotation
    }

    override fun setVisible(visible: Boolean) {
        marker.isVisible = visible
    }

    override fun setZIndex(zIndex: Float) {
        marker.zIndex = zIndex
    }
}
