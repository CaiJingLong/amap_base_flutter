package me.yohom.amapbase.map.model

import android.graphics.Color
import com.amap.api.maps.AMap
import com.amap.api.maps.model.LatLng
import com.amap.api.maps.model.PolylineOptions
import me.yohom.amapbase.common.hexStringToColorInt

class UnifiedPolylineOptions(
        /// 顶点
        private val latLngList: List<LatLng>,

        /// 线段的宽度
        val width: Double,

        /// 线段的颜色
        val color: String,

        /// 线段的Z轴值
        private val zIndex: Double,

        /// 线段的可见属性
        private val isVisible: Boolean,

        /// 线段是否画虚线，默认为false，画实线
        private val isDottedLine: Boolean,

        /// 线段是否为大地曲线，默认false，不画大地曲线
        private val isGeodesic: Boolean,

        /// 虚线形状
        private val dottedLineType: Int,

        /// Polyline尾部形状
        private val lineCapType: Int,

        /// Polyline连接处形状
        private val lineJoIntype: Int,

        /// 线段是否使用渐变色
        private val isUseGradient: Boolean,

        /// 线段是否使用纹理贴图
        private val isUseTexture: Boolean
) {

    fun applyTo(map: AMap) {
        map.addPolyline(PolylineOptions().apply {
            addAll(this@UnifiedPolylineOptions.latLngList)
            width(this@UnifiedPolylineOptions.width.toFloat())
            color(this@UnifiedPolylineOptions.color.hexStringToColorInt() ?: Color.BLACK)
            zIndex(this@UnifiedPolylineOptions.zIndex.toFloat())
            visible(this@UnifiedPolylineOptions.isVisible)
            isDottedLine = this@UnifiedPolylineOptions.isDottedLine
            geodesic(this@UnifiedPolylineOptions.isGeodesic)
            lineCapType
            dottedLineType = this@UnifiedPolylineOptions.dottedLineType
            lineCapType(when (this@UnifiedPolylineOptions.lineCapType) {
                0 -> PolylineOptions.LineCapType.LineCapButt
                1 -> PolylineOptions.LineCapType.LineCapSquare
                2 -> PolylineOptions.LineCapType.LineCapArrow
                3 -> PolylineOptions.LineCapType.LineCapRound
                else -> PolylineOptions.LineCapType.LineCapButt
            })
            lineJoinType(when (this@UnifiedPolylineOptions.lineJoIntype) {
                0 -> PolylineOptions.LineJoinType.LineJoinBevel
                1 -> PolylineOptions.LineJoinType.LineJoinMiter
                2 -> PolylineOptions.LineJoinType.LineJoinRound
                else -> PolylineOptions.LineJoinType.LineJoinBevel
            })
            isUseTexture = this@UnifiedPolylineOptions.isUseGradient
            isUseTexture = this@UnifiedPolylineOptions.isUseTexture
        })
    }

}