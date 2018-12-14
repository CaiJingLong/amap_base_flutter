package me.yohom.amapbase.map.model

import com.amap.api.maps.AMap

class UnifiedUiSettings(
        /// 是否允许显示缩放按钮
        private val isZoomControlsEnabled: Boolean,

        /// 设置缩放按钮的位置
        private val zoomPosition: Int,

        /// 指南针
        private val isCompassEnabled: Boolean,

        /// 定位按钮
        private val isMyLocationButtonEnabled: Boolean,

        /// 比例尺控件
        private val isScaleControlsEnabled: Boolean,

        /// 地图Logo
        private val logoPosition: Int,

        /// 缩放手势
        private val isZoomGesturesEnabled: Boolean,

        /// 滑动手势
        private val isScrollGesturesEnabled: Boolean,

        /// 旋转手势
        private val isRotateGesturesEnabled: Boolean,

        /// 倾斜手势
        private val isTiltGesturesEnabled: Boolean
) {
    fun applyTo(map: AMap) {
        map.uiSettings.run {
            isZoomControlsEnabled = this@UnifiedUiSettings.isZoomControlsEnabled
            zoomPosition = this@UnifiedUiSettings.zoomPosition
            isCompassEnabled = this@UnifiedUiSettings.isCompassEnabled
            isMyLocationButtonEnabled = this@UnifiedUiSettings.isMyLocationButtonEnabled
            // 需要设置一下我的位置使能, 不然按按钮没反应
            map.isMyLocationEnabled = true
            isScaleControlsEnabled = this@UnifiedUiSettings.isScaleControlsEnabled
            logoPosition = this@UnifiedUiSettings.logoPosition
            isZoomGesturesEnabled = this@UnifiedUiSettings.isZoomGesturesEnabled
            isScrollGesturesEnabled = this@UnifiedUiSettings.isScrollGesturesEnabled
            isRotateGesturesEnabled = this@UnifiedUiSettings.isRotateGesturesEnabled
            isTiltGesturesEnabled = this@UnifiedUiSettings.isTiltGesturesEnabled
        }
    }
}