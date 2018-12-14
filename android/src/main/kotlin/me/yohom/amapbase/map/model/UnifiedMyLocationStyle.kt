package me.yohom.amapbase.map.model

import android.graphics.Color
import com.amap.api.maps.AMap
import com.amap.api.maps.model.MyLocationStyle
import me.yohom.amapbase.common.hexStringToColorInt

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
    fun applyTo(map: AMap) {
        map.isMyLocationEnabled = showMyLocation
        map.myLocationStyle = MyLocationStyle()
                .myLocationIcon(null)
                .anchor(anchorU, anchorV)
                .radiusFillColor(radiusFillColor.hexStringToColorInt() ?: Color.argb(100, 0, 0, 180))
                .strokeColor(strokeColor.hexStringToColorInt() ?: Color.argb(255, 0, 0, 220))
                .strokeWidth(strokeWidth)
                .myLocationType(myLocationType)
                .interval(interval)
                .showMyLocation(showMyLocation)
    }

}