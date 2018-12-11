import 'dart:convert';

import 'package:amap_base/amap_base.dart';
import 'package:amap_base/src/common/log.dart';
import 'package:amap_base/src/map/model/poi_result.dart';
import 'package:flutter/services.dart';

class AMapSearch {
  static AMapSearch _instance;

  static const _searchChannel = MethodChannel('me.yohom/search');

  AMapSearch._();

  factory AMapSearch() {
    if (_instance == null) {
      _instance = AMapSearch._();
      return _instance;
    } else {
      return _instance;
    }
  }

  /// 搜索poi
  Future<PoiResult> searchPoi(PoiSearchQuery query) {
    L.p('方法searchPoi dart端参数: query.toJsonString() -> ${query.toJsonString()}');

    return _searchChannel
        .invokeMethod('search#searchPoi', {'query': query.toJsonString()})
        .then((result) => result as String)
        .then((jsonString) => PoiResult.fromJson(jsonDecode(jsonString)));
  }

  /// 搜索poi 周边搜索
  Future<PoiResult> searchPoiBound(PoiSearchQuery query) {
    L.p('searchPoiBound dart端参数: query.toJsonString() -> ${query.toJsonString()}');

    return _searchChannel
        .invokeMethod('search#searchPoiBound', {'query': query.toJsonString()})
        .then((result) => result as String)
        .then((jsonString) => PoiResult.fromJson(jsonDecode(jsonString)));
  }

  /// 搜索poi 多边形搜索
  Future<PoiResult> searchPoiPolygon(PoiSearchQuery query) {
    L.p('searchPoiPolygon dart端参数: query.toJsonString() -> ${query.toJsonString()}');

    return _searchChannel
        .invokeMethod(
            'search#searchPoiPolygon', {'query': query.toJsonString()})
        .then((result) => result as String)
        .then((jsonString) => PoiResult.fromJson(jsonDecode(jsonString)));
  }

  /// 按id搜索poi
  Future<PoiItem> searchPoiId(String id) {
    L.p('searchPoiId dart端参数: id -> $id');

    return _searchChannel
        .invokeMethod('search#searchPoiId', {'id': id})
        .then((result) => result as String)
        .then((jsonString) => PoiItem.fromJson(jsonDecode(jsonString)));
  }

  /// 道路沿途直线检索POI
  Future<RoutePoiResult> searchRoutePoiLine(RoutePoiSearchQuery query) {
    L.p('searchRoutePoiLine dart端参数: query.toJsonString() -> ${query.toJsonString()}');

    return _searchChannel
        .invokeMethod(
            'search#searchRoutePoiLine', {'query': query.toJsonString()})
        .then((result) => result as String)
        .then((jsonString) => RoutePoiResult.fromJson(jsonDecode(jsonString)));
  }

  /// 道路沿途多边形检索POI
  Future<RoutePoiResult> searchRoutePoiPolygon(RoutePoiSearchQuery query) {
    L.p('searchRoutePoiPolygon dart端参数: query.toJsonString() -> ${query.toJsonString()}');

    return _searchChannel
        .invokeMethod(
            'search#searchRoutePoiPolygon', {'query': query.toJsonString()})
        .then((result) => result as String)
        .then((jsonString) => RoutePoiResult.fromJson(jsonDecode(jsonString)));
  }
}
