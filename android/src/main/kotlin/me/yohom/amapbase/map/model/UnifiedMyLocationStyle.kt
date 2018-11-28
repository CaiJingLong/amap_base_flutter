package me.yohom.amapbase.map.model

import android.graphics.Color
import com.amap.api.maps.model.MyLocationStyle

class UnifiedMyLocationStyle(
        // todo 实现自定义的图标
        /// 当前位置的图标
        private val myLocationIcon: String,
        /// 锚点横坐标方向的偏移量
        private val anchorU: Float,
        /// 锚点纵坐标方向的偏移量
        private val anchorV: Float,
        /// 圆形区域（以定位位置为圆心，定位半径的圆形区域）的填充颜色值
        private val radiusFillColor: String,
        /// 圆形区域（以定位位置为圆心，定位半径的圆形区域）边框的颜色值
        private val strokeColor: String,
        /// 圆形区域（以定位位置为圆心，定位半径的圆形区域）边框的宽度
        private val strokeWidth: Float,
        /// 我的位置展示模式
        private val myLocationType: Int,
        /// 定位请求时间间隔
        private val interval: Long,
        /// 是否显示定位小蓝点
        private val showMyLocation: Boolean
) {
    fun toMyLocationStyle(): MyLocationStyle {
        return MyLocationStyle()
                .myLocationIcon(null)
                .anchor(anchorU, anchorV)
                .radiusFillColor(hexStringToColorInt(radiusFillColor) ?: Color.argb(100, 0, 0, 180))
                .strokeColor(hexStringToColorInt(strokeColor) ?: Color.argb(255, 0, 0, 220))
                .strokeWidth(strokeWidth)
                .myLocationType(myLocationType)
                .interval(interval)
                .showMyLocation(showMyLocation)
    }

    private fun hexStringToColorInt(source: String): Int? {
        return try {
            val alpha = source.substring(0, 2).toInt(16)
            val red = source.substring(2, 4).toInt(16)
            val green = source.substring(4, 6).toInt(16)
            val blue = source.substring(6, 8).toInt(16)
            Color.argb(alpha, red, green, blue)
        } catch (e: Exception) {
            null
        }
    }
}