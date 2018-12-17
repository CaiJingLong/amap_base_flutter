package me.yohom.amapbase.location

import com.amap.api.location.AMapLocation
import com.amap.api.location.AMapLocationClientOption
import com.amap.api.location.AMapLocationQualityReport


//region UnifiedAMapLocation
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
    val floor: Int = amapLocation.floor.toIntOrNull() ?: 0
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
//endregion

//region UnifiedLocationClientOptions
class UnifiedLocationClientOptions(
        private val isMockEnable: Boolean,
        private val interval: Int,
        private val isOnceLocation: Boolean,
        private val isNeedAddress: Boolean,
        private val isWifiScan: Boolean,
        private val locationMode: Int,
        private val locationProtocol: Int,
        private val isKillProcess: Boolean,
        private val isGpsFirst: Boolean,
        private val httpTimeOut: Int,
        private val isOffset: Boolean,
        private val isLocationCacheEnable: Boolean,
        private val isOnceLocationLatest: Boolean,
        private val isSensorEnable: Boolean,
        private val lastLocationLifeCycle: Int,
        private val geoLanguage: Int,
        private val isDownloadCoordinateConvertLibrary: Boolean,
        private val deviceModeDistanceFilter: Double,
        private val locationPurpose: Int?,
        private val isOpenAlwaysScanWifi: Boolean,
        private val scanWifiInterval: Int
) {

    fun toLocationClientOptions(): AMapLocationClientOption {
        AMapLocationClientOption.setDownloadCoordinateConvertLibrary(isDownloadCoordinateConvertLibrary)
        AMapLocationClientOption.setOpenAlwaysScanWifi(isOpenAlwaysScanWifi)
        AMapLocationClientOption.setScanWifiInterval(scanWifiInterval.toLong())
        AMapLocationClientOption.setLocationProtocol(when (locationProtocol) {
            0 -> AMapLocationClientOption.AMapLocationProtocol.HTTP
            1 -> AMapLocationClientOption.AMapLocationProtocol.HTTPS
            else -> AMapLocationClientOption.AMapLocationProtocol.HTTP
        })
        return AMapLocationClientOption()
                .setMockEnable(isMockEnable)
                .setInterval(interval.toLong())
                .setOnceLocation(isOnceLocation)
                .setNeedAddress(isNeedAddress)
                .setWifiScan(isWifiScan)
                .setLocationMode(when (locationMode) {
                    0 -> AMapLocationClientOption.AMapLocationMode.Battery_Saving
                    1 -> AMapLocationClientOption.AMapLocationMode.Device_Sensors
                    2 -> AMapLocationClientOption.AMapLocationMode.Hight_Accuracy
                    else -> AMapLocationClientOption.AMapLocationMode.Hight_Accuracy
                })
                .setKillProcess(isKillProcess)
                .setGpsFirst(isGpsFirst)
                .setHttpTimeOut(httpTimeOut.toLong())
                .setOffset(isOffset)
                .setLocationCacheEnable(isLocationCacheEnable)
                .setOnceLocationLatest(isOnceLocationLatest)
                .setSensorEnable(isSensorEnable)
                .setLastLocationLifeCycle(lastLocationLifeCycle.toLong())
                .setGeoLanguage((when (geoLanguage) {
                    0 -> AMapLocationClientOption.GeoLanguage.DEFAULT
                    1 -> AMapLocationClientOption.GeoLanguage.ZH
                    2 -> AMapLocationClientOption.GeoLanguage.EN
                    else -> AMapLocationClientOption.GeoLanguage.DEFAULT
                }))
                .setDeviceModeDistanceFilter(deviceModeDistanceFilter.toFloat())
                .setLocationPurpose(when (locationPurpose) {
                    0 -> AMapLocationClientOption.AMapLocationPurpose.SignIn
                    1 -> AMapLocationClientOption.AMapLocationPurpose.Transport
                    2 -> AMapLocationClientOption.AMapLocationPurpose.Sport
                    else -> null
                })
    }
}
//endregion