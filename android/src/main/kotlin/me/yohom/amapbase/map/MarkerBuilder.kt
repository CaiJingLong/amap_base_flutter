package me.yohom.amapbase.map

import com.amap.api.maps.model.BitmapDescriptor
import com.amap.api.maps.model.LatLng
import com.amap.api.maps.model.MarkerOptions

class MarkerBuilder(private val mapController: AMapController) : MarkerOptionsSink {
    private val markerOptions: MarkerOptions = MarkerOptions()
    private var consumesTapEvents: Boolean = false

    fun build(): String {
        val marker = mapController.addMarker(markerOptions, consumesTapEvents)
        return marker.id
    }

    override fun setAlpha(alpha: Float) {
        markerOptions.alpha(alpha)
    }

    override fun setAnchor(u: Float, v: Float) {
        markerOptions.anchor(u, v)
    }

    override fun setConsumeTapEvents(consumesTapEvents: Boolean) {
        this.consumesTapEvents = consumesTapEvents
    }

    override fun setDraggable(draggable: Boolean) {
        markerOptions.draggable(draggable)
    }

    override fun setFlat(flat: Boolean) {
        markerOptions.isFlat = flat
    }

    override fun setIcon(bitmapDescriptor: BitmapDescriptor) {
        markerOptions.icon(bitmapDescriptor)
    }

    override fun setInfoWindowAnchor(u: Float, v: Float) {
        markerOptions.anchor(u, v)
    }

    override fun setInfoWindowText(title: String, snippet: String) {
        markerOptions.title(title)
        markerOptions.snippet(snippet)
    }

    override fun setPosition(position: LatLng) {
        markerOptions.position(position)
    }

    override fun setRotation(rotation: Float) {
        markerOptions.rotateAngle(rotation)
    }

    override fun setVisible(visible: Boolean) {
        markerOptions.visible(visible)
    }

    override fun setZIndex(zIndex: Float) {
        markerOptions.zIndex(zIndex)
    }
}
