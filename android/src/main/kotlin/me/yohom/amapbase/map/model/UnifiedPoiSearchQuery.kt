package me.yohom.amapbase.map.model

import android.content.Context
import com.amap.api.maps.model.LatLng
import com.amap.api.services.poisearch.PoiSearch
import me.yohom.amapbase.utils.toLatLonPoint

class UnifiedPoiSearchQuery(
        /// 查询字符串，多个关键字用“|”分割
        private val query: String,

        /// 待查询建筑物的标识
        private val building: String?,

        /// 待查分类组合
        private val category: String?,

        /// 待查城市（地区）的电话区号
        private val city: String,

        /// 设置查询的是第几页，从0开始
        private val pageNum: Int,

        /// 设置的查询页面的结果数目
        private val pageSize: Int,

        /// 是否严格按照设定城市搜索
        private val cityLimit: Boolean,

        /// 是否按照父子关系展示POI
        private val requireSubPois: Boolean,

        /// 是否按照距离排序
        private val distanceSort: Boolean,

        /// 设置的经纬度
        private val location: LatLng?
) {
    fun toPoiSearch(context: Context): PoiSearch {
        return PoiSearch(context, PoiSearch.Query(query, category, city).apply {
            building = this@UnifiedPoiSearchQuery.building
            pageNum = this@UnifiedPoiSearchQuery.pageNum
            pageSize = this@UnifiedPoiSearchQuery.pageSize
            cityLimit = this@UnifiedPoiSearchQuery.cityLimit
            requireSubPois(requireSubPois)
            isDistanceSort = this@UnifiedPoiSearchQuery.distanceSort
            location = this@UnifiedPoiSearchQuery.location?.toLatLonPoint()
        })
    }
}