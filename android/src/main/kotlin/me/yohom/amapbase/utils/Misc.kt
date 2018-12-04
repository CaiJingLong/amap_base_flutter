package me.yohom.amapbase.utils

import com.amap.api.maps.model.LatLng
import com.amap.api.services.core.LatLonPoint
import com.amap.api.services.core.PoiItem
import com.amap.api.services.poisearch.*

fun LatLng.toLatLonPoint(): LatLonPoint {
    return LatLonPoint(latitude, longitude)
}

fun LatLonPoint.toLatLng(): LatLng {
    return LatLng(latitude, longitude)
}

fun Int.toAMapError(): String {
    when (this) {
        1000 -> return "请求正常"
        1001 -> return "开发者签名未通过"
        1002 -> return "用户Key不正确或过期"
        1003 -> return "没有权限使用相应的接口"
        1008 -> return "MD5安全码未通过验证"
        1009 -> return "请求Key与绑定平台不符"
        1012 -> return "权限不足，服务请求被拒绝"
        1013 -> return "该Key被删除"
        1100 -> return "引擎服务响应错误"
        1101 -> return "引擎返回数据异常"
        1102 -> return "高德服务端请求链接超时"
        1103 -> return "读取服务结果返回超时"
        1200 -> return "请求参数非法"
        1201 -> return "请求条件中，缺少必填参数"
        1202 -> return "服务请求协议非法"
        1203 -> return "服务端未知错误"
        1800 -> return "服务端新增错误"
        1801 -> return "协议解析错误"
        1802 -> return "socket 连接超时 - SocketTimeoutException"
        1803 -> return "url异常 - MalformedURLException"
        1804 -> return "未知主机 - UnKnowHostException"
        1806 -> return "http或socket连接失败 - ConnectionException"
        1900 -> return "未知错误"
        1901 -> return "参数无效"
        1902 -> return "IO 操作异常 - IOException"
        1903 -> return "空指针异常 - NullPointException"
        2000 -> return "Tableid格式不正确"
        2001 -> return "数据ID不存在"
        2002 -> return "云检索服务器维护中"
        2003 -> return "Key对应的tableID不存在"
        2100 -> return "找不到对应的userid信息"
        2101 -> return "App Key未开通“附近”功能"
        2200 -> return "在开启自动上传功能的同时对表进行清除或者开启单点上传的功能"
        2201 -> return "USERID非法"
        2202 -> return "NearbyInfo对象为空"
        2203 -> return "两次单次上传的间隔低于7秒"
        2204 -> return "Point为空，或与前次上传的相同"
        3000 -> return "规划点（包括起点、终点、途经点）不在中国陆地范围内"
        3001 -> return "规划点（包括起点、终点、途经点）附近搜不到路"
        3002 -> return "路线计算失败，通常是由于道路连通关系导致"
        3003 -> return "步行算路起点、终点距离过长导致算路失败。"
        4000 -> return "短串分享认证失败"
        4001 -> return "短串请求失败"
        else -> return "无法识别的代码"
    }
}

fun PoiResult.toJson(): String {
    return StringBuilder()
            .append("{")
            .append("\"pageCount\":\"$pageCount\",")
            .append("\"query\":\"$query\",")
            .append("\"bound\":\"$bound\",")
            .append("\"pois\":\"${pois.map { it.toJson() }}\",")
            .append("\"searchSuggestionKeywords\":\"$searchSuggestionKeywords\",")
            .append("\"searchSuggestionCitys\":\"$searchSuggestionCitys\"")
            .append("}")
            .toString()
}

fun PoiItem.toJson(): String {
    return StringBuilder()
            .append("{")
            .append("\"businessArea\":\"$businessArea\",")
            .append("\"adName\":\"$adName\",")
            .append("\"cityName\":\"$cityName\",")
            .append("\"provinceName\":\"$provinceName\",")
            .append("\"typeDes\":\"$typeDes\",")
            .append("\"tel\":\"$tel\",")
            .append("\"adCode\":\"$adCode\",")
            .append("\"poiId\":\"$poiId\",")
            .append("\"distance\":\"$distance\",")
            .append("\"title\":\"$title\",")
            .append("\"snippet\":\"$snippet\",")
            .append("\"latLonPoint\":${latLonPoint.toLatLng().toJson()},")
            .append("\"cityCode\":\"$cityCode\",")
            .append("\"enter\":\"$enter\",")
            .append("\"exit\":\"$exit\",")
            .append("\"postcode\":\"$postcode\",")
            .append("\"email\":\"$email\",")
            .append("\"direction\":\"$direction\",")
            .append("\"isIndoorMap\":\"$isIndoorMap\",")
            .append("\"provinceCode\":\"$provinceCode\",")
            .append("\"parkingType\":\"$parkingType\",")
            .append("\"subPois\":${subPois.map { it.toJson() }.toJson()},")
            .append("\"indoorData\":\"${indoorData.toJson()}\",")
            .append("\"photos\":${photos.map { it.toJson() }.toJson()},")
            .append("\"poiExtension\":${poiExtension.toJson()},")
            .append("\"typeCode\":\"$typeCode\",")
            .append("\"shopID\":\"$shopID\"")
            .append("}")
            .toString()
}

fun PoiItemExtension.toJson(): String {
    return StringBuilder()
            .append("{")
            .append("\"opentime\":\"$opentime\",")
            .append("\"rating\":\"${getmRating()}\"")
            .append("}")
            .toString()
}

fun Photo.toJson(): String {
    return StringBuilder()
            .append("{")
            .append("title:$title,")
            .append("url:$url")
            .append("}")
            .toString()
}

fun SubPoiItem.toJson(): String {
    return StringBuilder()
            .append("{")
            .append("\"poiId\":\"$poiId\",")
            .append("\"title\":\"$title\",")
            .append("\"subName\":\"$subName\",")
            .append("\"distance\":\"$distance\",")
            .append("\"latLonPoint\":\"${latLonPoint.toLatLng().toJson()}\",")
            .append("\"snippet\":\"$snippet\",")
            .append("\"subTypeDes\":\"$subTypeDes\"")
            .append("}")
            .toString()
}

fun IndoorData.toJson(): String {
    return StringBuilder()
            .append("{")
            .append("\"poiId\":\"$poiId\",")
            .append("\"floor\":\"$floor\",")
            .append("\"floorName\":\"$floorName\"")
            .append("}")
            .toString()
}