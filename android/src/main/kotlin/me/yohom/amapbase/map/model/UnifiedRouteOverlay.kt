package me.yohom.amapbase.map.model

import com.amap.api.maps.AMap
import com.amap.api.maps.model.LatLng
import me.yohom.amapbase.map.overlay.DrivingRouteOverlay

internal class UnifiedRouteOverlay(
        val type: String,
        val from: LatLng,
        val to: LatLng,
        private val passby: List<LatLng>,
        private val drivePath: UnifiedDrivePath
) {
    fun applyTo(map: AMap) {
        DrivingRouteOverlay(map, from, to, passby, drivePath).apply {
            removeFromMap()
            addToMap()
            zoomToSpan()
        }
    }
}

class UnifiedDrivePath(
        val strategy: String,
        val tolls: Double,
        val tollDistance: Double,
        val totalTrafficlights: Int,
        val steps: List<UnifiedDriveStep>,
        val restriction: Int
)

class UnifiedDriveStep(
        val instruction: String,
        val orientation: String,
        val road: String,
        val distance: Double,
        val tolls: Double,
        val tollDistance: Double,
        val tollRoad: String,
        val duration: Double,
        val polyline: List<LatLng>,
        val action: String,
        val assistantAction: String,
        val routeSearchCityList: List<UnifiedRouteSearchCity>,
        val TMCs: List<UnifiedTMC>
)

class UnifiedRouteSearchCity(val districts: List<UnifiedDistrict>)

class UnifiedTMC(
        val distance: Int,
        val status: String,
        val polyline: List<LatLng>)

class UnifiedDistrict(
        val districtName: String,
        val districtAdcode: String
)