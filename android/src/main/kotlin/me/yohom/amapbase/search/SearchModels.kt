package me.yohom.amapbase.search

import android.content.Context
import com.amap.api.services.core.PoiItem
import com.amap.api.services.core.SuggestionCity
import com.amap.api.services.geocoder.GeocodeAddress
import com.amap.api.services.geocoder.GeocodeQuery
import com.amap.api.services.geocoder.GeocodeResult
import com.amap.api.services.poisearch.*
import com.amap.api.services.route.*
import com.amap.api.services.routepoisearch.RoutePOIItem
import com.amap.api.services.routepoisearch.RoutePOISearch
import com.amap.api.services.routepoisearch.RoutePOISearchQuery
import com.amap.api.services.routepoisearch.RoutePOISearchResult

class LatLng(
        val latitude: Double,
        val longitude: Double
)

class RoutePlanParam(
        /// 起点
        val from: LatLng,
        /// 终点
        val to: LatLng,
        /// 计算路径的模式，可选，默认为速度优先=0
        val mode: Int,
        /// 途经点，可选
        val passedByPoints: List<LatLng>?,
        /// 避让区域，可选，支持32个避让区域，每个区域最多可有16个顶点。如果是四边形则有4个坐标点，如果是五边形则有5个坐标点
        val avoidPolygons: List<List<LatLng>>?,
        /// 避让道路，只支持一条避让道路，避让区域和避让道路同时设置，只有避让道路生效
        val avoidRoad: String?
) {
    override fun toString(): String {
        return "RoutePlanParam(from=$from, to=$to, mode=$mode, passedByPoints=$passedByPoints, avoidPolygons=$avoidPolygons, avoidRoad='$avoidRoad')"
    }
}

//region UnifiedDriveRouteResult
internal class UnifiedDriveRouteResult(driveRouteResult: DriveRouteResult) {
    /// 起始
    val startPos: LatLng = driveRouteResult.startPos.toLatLng()

    /// 终点
    val targetPos: LatLng = driveRouteResult.targetPos.toLatLng()

    /// 打的费用
    val taxiCost: Double = driveRouteResult.taxiCost.toDouble()

    /// 路段
    val paths: List<UnifiedDrivePath> = driveRouteResult.paths.map { UnifiedDrivePath(it) }
}


class UnifiedDrivePath(drivePath: DrivePath) {
    val strategy: String = drivePath.strategy
    val tolls: Double = drivePath.tolls.toDouble()
    val tollDistance: Double = drivePath.tollDistance.toDouble()
    val totalTrafficlights: Int = drivePath.totalTrafficlights
    val steps: List<UnifiedDriveStep> = drivePath.steps.map { UnifiedDriveStep(it) }
    val restriction: Int = drivePath.restriction
}

class UnifiedDriveStep(driveStep: DriveStep) {
    val instruction: String = driveStep.instruction
    val orientation: String = driveStep.orientation
    val road: String = driveStep.road
    val distance: Double = driveStep.distance.toDouble()
    val tolls: Double = driveStep.tolls.toDouble()
    val tollDistance: Double = driveStep.tollDistance.toDouble()
    val tollRoad: String = driveStep.tollRoad
    val duration: Double = driveStep.duration.toDouble()
    val polyline: List<LatLng> = driveStep.polyline.map { it.toLatLng() }
    val action: String = driveStep.action
    val assistantAction: String = driveStep.assistantAction
    val routeSearchCityList: List<UnifiedRouteSearchCity> = driveStep.routeSearchCityList.map { UnifiedRouteSearchCity(it) }
    val TMCs: List<UnifiedTMC> = driveStep.tmCs.map { UnifiedTMC(it) }
}

class UnifiedRouteSearchCity(routeSearchCity: RouteSearchCity) {
    val districts: List<UnifiedDistrict> = routeSearchCity.districts.map { UnifiedDistrict(it) }
}

class UnifiedTMC(tmc: TMC) {
    val distance: Int = tmc.distance
    val status: String = tmc.status
    val polyline: List<LatLng> = tmc.polyline.map { it.toLatLng() }
}

class UnifiedDistrict(district: District) {
    val districtName: String = district.districtName
    val districtAdcode: String = district.districtAdcode
}
//endregion

//region UnifiedGeocodeResult
class UnifiedGeocodeResult(geocodeResult: GeocodeResult) {
    val geocodeQuery: UnifiedGeocodeQuery = UnifiedGeocodeQuery(geocodeResult.geocodeQuery)
    val geocodeAddressList: List<UnifiedGeocodeAddress> = geocodeResult.geocodeAddressList.map { UnifiedGeocodeAddress(it) }
}

class UnifiedGeocodeAddress(geocodeAddress: GeocodeAddress) {
    val formatAddress: String = geocodeAddress.formatAddress
    val province: String = geocodeAddress.province
    val city: String = geocodeAddress.city
    val district: String = geocodeAddress.district
    val township: String = geocodeAddress.township
    val neighborhood: String = geocodeAddress.neighborhood
    val building: String = geocodeAddress.building
    val adcode: String = geocodeAddress.adcode
    val latLng: LatLng = geocodeAddress.latLonPoint.toLatLng()
    val level: String = geocodeAddress.level
}

class UnifiedGeocodeQuery(geocodeQuery: GeocodeQuery) {
    val locationName: String = geocodeQuery.locationName
    val city: String = geocodeQuery.city
}
//endregion

//region UnifiedPoiItem
class UnifiedPoiItem(poiItem: PoiItem) {
    val businessArea: String? = poiItem.businessArea
    val adName: String? = poiItem.adName
    val cityName: String? = poiItem.cityName
    val provinceName: String? = poiItem.provinceName
    val typeDes: String? = poiItem.typeDes
    val tel: String? = poiItem.tel
    val adCode: String? = poiItem.adCode
    val poiId: String? = poiItem.poiId
    val distance: Int? = poiItem.distance
    val title: String? = poiItem.title
    val snippet: String? = poiItem.snippet
    val latLonPoint: LatLng? = poiItem.latLonPoint?.toLatLng()
    val cityCode: String? = poiItem.cityCode
    val enter: LatLng? = poiItem.enter?.toLatLng()
    val exit: LatLng? = poiItem.exit?.toLatLng()
    val website: String? = poiItem.website
    val postcode: String? = poiItem.postcode
    val email: String? = poiItem.email
    val direction: String? = poiItem.direction
    val isIndoorMap: Boolean? = poiItem.isIndoorMap
    val provinceCode: String? = poiItem.provinceCode
    val parkingType: String? = poiItem.parkingType
    val subPois: List<UnifiedSubPoiItem> = poiItem.subPois?.map { UnifiedSubPoiItem(it) }
            ?: listOf()
    val indoorData: UnifiedIndoorData? = if (poiItem.indoorData != null) UnifiedIndoorData(poiItem.indoorData) else null
    val photos: List<UnifiedPhoto> = poiItem.photos?.map { UnifiedPhoto(it) } ?: listOf()
    val poiExtension: UnifiedPoiItemExtension? = if (poiItem.poiExtension != null) UnifiedPoiItemExtension(poiItem.poiExtension) else null
    val typeCode: String? = poiItem.typeCode
    val shopID: String? = poiItem.shopID
}

class UnifiedPoiResult(poiResult: PoiResult) {
    val pageCount: Int? = poiResult.pageCount
    /**
     * 暂未支持
     */
    val query: PoiSearch.Query = poiResult.query
    private val bound: UnifiedSearchBound? = if (poiResult.bound != null) UnifiedSearchBound(poiResult.bound) else null
    private val pois: List<UnifiedPoiItem> = poiResult.pois?.map { UnifiedPoiItem(it) } ?: listOf()
    private val searchSuggestionKeywords: List<String> = poiResult.searchSuggestionKeywords
            ?: listOf()
    private val searchSuggestionCitys: List<UnifiedSuggestionCity> = poiResult.searchSuggestionCitys?.map { UnifiedSuggestionCity(it) }
            ?: listOf()
}

class UnifiedSubPoiItem(subPoiItem: SubPoiItem) {
    val poiId: String? = subPoiItem.poiId
    val title: String? = subPoiItem.title
    val subName: String? = subPoiItem.subName
    val distance: Int? = subPoiItem.distance
    val latLonPoint: LatLng? = subPoiItem.latLonPoint?.toLatLng()
    val snippet: String? = subPoiItem.snippet
    val subTypeDes: String? = subPoiItem.subTypeDes
}

class UnifiedIndoorData(indoorData: IndoorData) {
    val poiId: String? = indoorData.poiId
    val floor: Int? = indoorData.floor
    val floorName: String? = indoorData.floorName
}

class UnifiedPhoto(photo: Photo) {
    val title: String? = photo.title
    val url: String? = photo.url
}

class UnifiedPoiItemExtension(poiItemExtension: PoiItemExtension) {
    val opentime: String? = poiItemExtension.opentime
    val rating: String? = poiItemExtension.getmRating()
}

class UnifiedSuggestionCity(suggestionCity: SuggestionCity) {
    val cityName: String? = suggestionCity.cityName
    val cityCode: String? = suggestionCity.cityCode
    val adCode: String? = suggestionCity.adCode
    val suggestionNum: Int? = suggestionCity.suggestionNum
}
//endregion

//region UnifiedPoiSearchQuery
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
        private val location: LatLng?,

        /// 搜索边界, 周边检索使用
        private val searchBound: UnifiedSearchBound?
) {
    /**
     * 关键字搜索
     */
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

    /**
     * 周边检索
     */
    fun toPoiSearchBound(context: Context): PoiSearch {
        return PoiSearch(context, PoiSearch.Query(query, category, city).apply {
            building = this@UnifiedPoiSearchQuery.building
            pageNum = this@UnifiedPoiSearchQuery.pageNum
            pageSize = this@UnifiedPoiSearchQuery.pageSize
            cityLimit = this@UnifiedPoiSearchQuery.cityLimit
            requireSubPois(requireSubPois)
            isDistanceSort = this@UnifiedPoiSearchQuery.distanceSort
            location = this@UnifiedPoiSearchQuery.location?.toLatLonPoint()
        }).apply { bound = searchBound?.toSearchBoundCenterRange() }
    }

    /**
     * 多边形内检索
     */
    fun toPoiSearchPolygon(context: Context): PoiSearch {
        return PoiSearch(context, PoiSearch.Query(query, category, city).apply {
            building = this@UnifiedPoiSearchQuery.building
            pageNum = this@UnifiedPoiSearchQuery.pageNum
            pageSize = this@UnifiedPoiSearchQuery.pageSize
            cityLimit = this@UnifiedPoiSearchQuery.cityLimit
            requireSubPois(requireSubPois)
            isDistanceSort = this@UnifiedPoiSearchQuery.distanceSort
            location = this@UnifiedPoiSearchQuery.location?.toLatLonPoint()
        }).apply { bound = searchBound?.toSearchBoundPolygon() }
    }
}
//endregion

//region UnifiedRoutePoiSearchQuery
class UnifiedRoutePoiSearchQuery(
        private val from: LatLng,
        private val to: LatLng,
        private val mode: Int,
        private val searchType: Int,
        private val range: Int,
        private val polylines: List<LatLng>
) {
    fun toRoutePoiSearchLine(context: Context): RoutePOISearch {
        return RoutePOISearch(
                context,
                RoutePOISearchQuery(
                        from.toLatLonPoint(),
                        to.toLatLonPoint(),
                        mode,
                        when (searchType) {
                            0 -> RoutePOISearch.RoutePOISearchType.TypeGasStation
                            1 -> RoutePOISearch.RoutePOISearchType.TypeMaintenanceStation
                            2 -> RoutePOISearch.RoutePOISearchType.TypeATM
                            3 -> RoutePOISearch.RoutePOISearchType.TypeToilet
                            4 -> RoutePOISearch.RoutePOISearchType.TypeFillingStation
                            5 -> RoutePOISearch.RoutePOISearchType.TypeServiceArea
                            else -> throw IllegalArgumentException()
                        },
                        range
                )
        )
    }

    fun toRoutePoiSearchPolygon(context: Context): RoutePOISearch {
        return RoutePOISearch(
                context,
                RoutePOISearchQuery(
                        polylines.map { it.toLatLonPoint() },
                        when (searchType) {
                            0 -> RoutePOISearch.RoutePOISearchType.TypeGasStation
                            1 -> RoutePOISearch.RoutePOISearchType.TypeMaintenanceStation
                            2 -> RoutePOISearch.RoutePOISearchType.TypeATM
                            3 -> RoutePOISearch.RoutePOISearchType.TypeToilet
                            4 -> RoutePOISearch.RoutePOISearchType.TypeFillingStation
                            5 -> RoutePOISearch.RoutePOISearchType.TypeServiceArea
                            else -> throw IllegalArgumentException()
                        },
                        range
                )
        )
    }
}
//endregion

//region UnifiedRoutePoiSearchResult
class UnifiedRoutePoiSearchResult(routePOISearchResult: RoutePOISearchResult) {
    private val routePoiList: List<UnifiedRoutePOIItem> = routePOISearchResult.routePois?.map { UnifiedRoutePOIItem(it) }
            ?: listOf()
    private val query: RoutePOISearchQuery = routePOISearchResult.query
}

private class UnifiedRoutePOIItem(poiItem: RoutePOIItem) {
    val id: String = poiItem.id
    val title: String = poiItem.title
    val point: LatLng? = poiItem.point?.toLatLng()
    val distance: Float = poiItem.distance
    val duration: Float = poiItem.duration
}
//endregion

class UnifiedSearchBound(searchBound: PoiSearch.SearchBound) {
    val lowerLeft: LatLng? = searchBound.lowerLeft?.toLatLng()
    val upperRight: LatLng? = searchBound.upperRight?.toLatLng()
    private val center: LatLng? = searchBound.center?.toLatLng()
    private val range: Int? = searchBound.range
    val shape: String? = searchBound.shape
    val isDistanceSort: Boolean? = searchBound.isDistanceSort
    private val polyGonList: List<LatLng> = searchBound.polyGonList?.map { it.toLatLng() } ?: listOf()

    /**
     * 中心点 + 半径范围
     */
    fun toSearchBoundCenterRange(): PoiSearch.SearchBound {
        return PoiSearch.SearchBound(center?.toLatLonPoint(), range!!)
    }

    /**
     * 多边形搜索
     */
    fun toSearchBoundPolygon(): PoiSearch.SearchBound {
        return PoiSearch.SearchBound(polyGonList.map { it.toLatLonPoint() })
    }
}