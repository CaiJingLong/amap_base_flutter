package me.yohom.amapbase.map.model

import com.amap.api.maps.AMap

class UnifiedUiSettings(
        /// 是否允许显示缩放按钮
        private val isZoomControlsEnabled: Boolean?,

        /// 设置缩放按钮的位置
        private val zoomPosition: Int?,

        /// 指南针
        private val isCompassEnabled: Boolean?,

        /// 定位按钮
        private val isMyLocationButtonEnabled: Boolean?,

        /// 比例尺控件
        private val isScaleControlsEnabled: Boolean?,

        /// 地图Logo
        private val logoPosition: Int?
) {
    fun applyTo(map: AMap) {
        map.uiSettings.run {
            if (this@UnifiedUiSettings.isZoomControlsEnabled != null) {
                isZoomControlsEnabled = this@UnifiedUiSettings.isZoomControlsEnabled
            }
            if (this@UnifiedUiSettings.zoomPosition != null) {
                zoomPosition = this@UnifiedUiSettings.zoomPosition
            }
            if (this@UnifiedUiSettings.isCompassEnabled != null) {
                isCompassEnabled = this@UnifiedUiSettings.isCompassEnabled
            }
            if (this@UnifiedUiSettings.isMyLocationButtonEnabled != null) {
                isMyLocationButtonEnabled = this@UnifiedUiSettings.isMyLocationButtonEnabled
                // 需要设置一下我的位置使能, 不然按按钮没反应
                map.isMyLocationEnabled = true
            }
            if (this@UnifiedUiSettings.isScaleControlsEnabled != null) {
                isScaleControlsEnabled = this@UnifiedUiSettings.isScaleControlsEnabled
            }
            if (this@UnifiedUiSettings.logoPosition != null) {
                logoPosition = this@UnifiedUiSettings.logoPosition
            }
        }
    }
}