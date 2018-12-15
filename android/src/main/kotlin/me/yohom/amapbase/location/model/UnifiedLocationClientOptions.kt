package me.yohom.amapbase.location.model

import com.amap.api.location.AMapLocationClientOption

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