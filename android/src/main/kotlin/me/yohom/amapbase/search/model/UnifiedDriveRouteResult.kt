package me.yohom.amapbase.search.model

import com.amap.api.maps.model.LatLng
import com.amap.api.services.route.*
import me.yohom.amapbase.search.toLatLng

internal class UnifiedDriveRouteResult(driveRouteResult: DriveRouteResult) {
    /// 起始
    val startPos: LatLng = driveRouteResult.startPos.toLatLng()

    /// 终点
    val targetPos: LatLng = driveRouteResult.targetPos.toLatLng()

    /// 打的费用
    val taxiCost: Double = driveRouteResult.taxiCost.toDouble()

    /// 路段
    val paths: List<UnifiedDrivePath> = driveRouteResult.paths.map { UnifiedDrivePath(it) }
}


class UnifiedDrivePath(drivePath: DrivePath) {
    val strategy: String = drivePath.strategy
    val tolls: Double = drivePath.tolls.toDouble()
    val tollDistance: Double = drivePath.tollDistance.toDouble()
    val totalTrafficlights: Int = drivePath.totalTrafficlights
    val steps: List<UnifiedDriveStep> = drivePath.steps.map { UnifiedDriveStep(it) }
    val restriction: Int = drivePath.restriction
}

class UnifiedDriveStep(driveStep: DriveStep) {
    val instruction: String = driveStep.instruction
    val orientation: String = driveStep.orientation
    val road: String = driveStep.road
    val distance: Double = driveStep.distance.toDouble()
    val tolls: Double = driveStep.tolls.toDouble()
    val tollDistance: Double = driveStep.tollDistance.toDouble()
    val tollRoad: String = driveStep.tollRoad
    val duration: Double = driveStep.duration.toDouble()
    val polyline: List<LatLng> = driveStep.polyline.map { it.toLatLng() }
    val action: String = driveStep.action
    val assistantAction: String = driveStep.assistantAction
    val routeSearchCityList: List<UnifiedRouteSearchCity> = driveStep.routeSearchCityList.map { UnifiedRouteSearchCity(it) }
    val TMCs: List<UnifiedTMC> = driveStep.tmCs.map { UnifiedTMC(it) }
}

class UnifiedRouteSearchCity(routeSearchCity: RouteSearchCity) {
    val districts: List<UnifiedDistrict> = routeSearchCity.districts.map { UnifiedDistrict(it) }
}

class UnifiedTMC(tmc: TMC) {
    val distance: Int = tmc.distance
    val status: String = tmc.status
    val polyline: List<LatLng> = tmc.polyline.map { it.toLatLng() }
}

class UnifiedDistrict(district: District) {
    val districtName: String = district.districtName
    val districtAdcode: String = district.districtAdcode
}