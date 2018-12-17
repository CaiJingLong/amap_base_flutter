package me.yohom.amapbase.location.model

import com.amap.api.location.AMapLocation
import com.amap.api.location.AMapLocationQualityReport

class UnifiedAMapLocation(amapLocation: AMapLocation) {
    val gpsAccuracyStatus: Int = amapLocation.gpsAccuracyStatus
    val locationType: Int = amapLocation.locationType
    val locationDetail: String = amapLocation.locationDetail
    val errorCode: Int = amapLocation.errorCode
    val errorInfo: String = amapLocation.errorInfo
    val country: String = amapLocation.country
    val address: String = amapLocation.address
    val province: String = amapLocation.province
    val city: String = amapLocation.city
    val district: String = amapLocation.district
    val cityCode: String = amapLocation.cityCode
    val adCode: String = amapLocation.adCode
    val poiName: String = amapLocation.poiName
    val latitude: Double = amapLocation.latitude
    val longitude: Double = amapLocation.longitude
    val satellites: Int = amapLocation.satellites
    val street: String = amapLocation.street
    val streetNum: String = amapLocation.streetNum
    val isOffset: Boolean = amapLocation.isOffset
    val aoiName: String = amapLocation.aoiName
    val buildingId: String = amapLocation.buildingId
    val floor: String = amapLocation.floor
    val isFixLastLocation: Boolean = amapLocation.isFixLastLocation
    val isMock: Boolean = amapLocation.isMock
    val accuracy: Double = amapLocation.accuracy.toDouble()
    val bearing: Double = amapLocation.bearing.toDouble()
    val altitude: Double = amapLocation.altitude
    val speed: Double = amapLocation.speed.toDouble()
    val provider: String = amapLocation.provider
    val locationQualityReport: UnifiedAMapLocationQualityReport = UnifiedAMapLocationQualityReport(amapLocation.locationQualityReport)
    val coordType: String = amapLocation.coordType
    val trustedLevel: Int = amapLocation.trustedLevel
}

class UnifiedAMapLocationQualityReport(amapLocationQualityReport: AMapLocationQualityReport) {
    val isWifiAble: Boolean = amapLocationQualityReport.isWifiAble
    val gpsStatus: Int = amapLocationQualityReport.gpsStatus
    val gpsSatellites: Int = amapLocationQualityReport.gpsSatellites
    val networkType: String = amapLocationQualityReport.networkType
    val netUseTime: Long = amapLocationQualityReport.netUseTime
    val adviseMessage: String = amapLocationQualityReport.adviseMessage
}