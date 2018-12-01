package me.yohom.amapbase.map.model

import com.amap.api.maps.AMap
import com.amap.api.maps.model.BitmapDescriptor
import com.amap.api.maps.model.LatLng
import com.amap.api.maps.model.MarkerOptions
import me.yohom.amapbase.utils.UnifiedAssets
import java.util.*

class UnifiedMarkerOptions(
        /// Marker覆盖物的图标
        private val icon: String?,

        /// Marker覆盖物的动画帧图标列表，动画的描点和大小以第一帧为准，建议图片大小保持一致
        private val icons: List<String>,

        /// Marker覆盖物的透明度
        private val alpha: Float,

        /// Marker覆盖物锚点在水平范围的比例
        private val anchorU: Float,

        /// Marker覆盖物锚点垂直范围的比例
        private val anchorV: Float,

        /// Marker覆盖物是否可拖拽
        private val draggable: Boolean,

        /// Marker覆盖物的InfoWindow是否允许显示, 可以通过 MarkerOptions.infoWindowEnable(kotlin.Booleanean) 进行设置
        private val infoWindowEnable: Boolean,

        /// 设置多少帧刷新一次图片资源，Marker动画的间隔时间，值越小动画越快
        private val period: Int,

        /// Marker覆盖物的位置坐标
        private val position: LatLng,

        /// Marker覆盖物的图片旋转角度，从正北开始，逆时针计算
        private val rotateAngle: Float,

        /// Marker覆盖物是否平贴地图
        private val isFlat: Boolean,

        /// Marker覆盖物的坐标是否是Gps，默认为false
        private val isGps: Boolean,

        /// Marker覆盖物的水平偏移距离
        private val infoWindowOffsetX: Int,

        /// Marker覆盖物的垂直偏移距离
        private val infoWindowOffsetY: Int,

        /// 设置 Marker覆盖物的 文字描述
        private val snippet: String,

        /// Marker覆盖物 的标题
        private val title: String,

        /// Marker覆盖物是否可见
        private val visible: Boolean,

        /// todo 缺少文档
        private val autoOverturnInfoWindow: Boolean,

        /// Marker覆盖物 zIndex
        private val zIndex: Float,

        /// 显示等级 缺少文档
        private val displayLevel: Int,

        /// 是否在掩层下 缺少文档
        private val belowMaskLayer: Boolean
) {
    fun applyTo(map: AMap) {
        map.addMarker(MarkerOptions()
                .icon(if (icon != null) UnifiedAssets.getBitmapDescriptor(icon) else null)
                .alpha(alpha)
                .anchor(anchorU, anchorV)
                .draggable(draggable)
                .infoWindowEnable(infoWindowEnable)
                .period(period)
                .position(position)
                .rotateAngle(rotateAngle)
                .setFlat(isFlat)
                .setGps(isGps)
                .setInfoWindowOffset(infoWindowOffsetX, infoWindowOffsetY)
                .snippet(snippet)
                .title(title)
                .visible(visible)
                .autoOverturnInfoWindow(autoOverturnInfoWindow)
                .zIndex(zIndex)
                .displayLevel(displayLevel)
                .belowMaskLayer(belowMaskLayer)
                .apply {
                    if (this@UnifiedMarkerOptions.icons.isNotEmpty()) {
                        icons(this@UnifiedMarkerOptions.icons.map { UnifiedAssets.getBitmapDescriptor(it) } as ArrayList<BitmapDescriptor>)
                    }
                }
        )
    }

    fun toMarkerOption(): MarkerOptions = MarkerOptions()
            .icon(if (icon != null) UnifiedAssets.getBitmapDescriptor(icon) else null)
            .alpha(alpha)
            .anchor(anchorU, anchorV)
            .draggable(draggable)
            .infoWindowEnable(infoWindowEnable)
            .period(period)
            .position(position)
            .rotateAngle(rotateAngle)
            .setFlat(isFlat)
            .setGps(isGps)
            .setInfoWindowOffset(infoWindowOffsetX, infoWindowOffsetY)
            .snippet(snippet)
            .title(title)
            .visible(visible)
            .autoOverturnInfoWindow(autoOverturnInfoWindow)
            .zIndex(zIndex)
            .displayLevel(displayLevel)
            .belowMaskLayer(belowMaskLayer)
            .apply {
                if (this@UnifiedMarkerOptions.icons.isNotEmpty()) {
                    icons(this@UnifiedMarkerOptions.icons.map { UnifiedAssets.getBitmapDescriptor(it) } as ArrayList<BitmapDescriptor>)
                }
            }
}