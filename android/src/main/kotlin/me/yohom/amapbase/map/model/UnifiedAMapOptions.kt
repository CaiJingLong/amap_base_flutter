package me.yohom.amapbase.map.model

import com.amap.api.maps.AMap
import com.amap.api.maps.AMapOptions
import com.amap.api.maps.model.CameraPosition

/**
 * 由于高德的AMapOption被混淆了, 无法通过Gson直接反序列化, 这里用这个类过渡一下
 * [CameraPosition]和[LatLng]没有被混淆, 所以可以直接使用
 * 另外这个类和ios端的做一个统一
 */
class UnifiedAMapOptions(
        /// “高德地图”Logo的位置
        private val logoPosition: Int = AMapOptions.LOGO_POSITION_BOTTOM_LEFT,
        private val zOrderOnTop: Boolean = false,

        /// 地图模式
        private val mapType: Int = AMap.MAP_TYPE_NORMAL,

        /// 地图初始化时的地图状态， 默认地图中心点为北京天安门，缩放级别为 10.0f。
        private val camera: CameraPosition? = null,

        /// 比例尺功能是否可用
        private val scaleControlsEnabled: Boolean = false,

        /// 地图是否允许缩放
        private val zoomControlsEnabled: Boolean = true,

        /// 指南针是否可用。
        private val compassEnabled: Boolean = false,

        /// 拖动手势是否可用
        private val scrollGesturesEnabled: Boolean = true,

        /// 缩放手势是否可用
        private val zoomGesturesEnabled: Boolean = true,

        /// 地图倾斜手势（显示3D效果）是否可用
        private val tiltGesturesEnabled: Boolean = true,

        /// 地图旋转手势是否可用
        private val rotateGesturesEnabled: Boolean = true
) {


    fun toAMapOption(): AMapOptions {
        return AMapOptions()
                .logoPosition(logoPosition)
                .zOrderOnTop(zOrderOnTop)
                .mapType(mapType)
                .camera(camera)
                .scaleControlsEnabled(scaleControlsEnabled)
                .zoomControlsEnabled(zoomControlsEnabled)
                .compassEnabled(compassEnabled)
                .scrollGesturesEnabled(scrollGesturesEnabled)
                .zoomGesturesEnabled(zoomGesturesEnabled)
                .tiltGesturesEnabled(tiltGesturesEnabled)
                .rotateGesturesEnabled(rotateGesturesEnabled)
    }
}