import 'dart:convert';

import 'package:amap_base_location/amap_base.dart';
import 'package:amap_base_location/src/map/model/search_bound.dart';

class PoiSearchQuery {
  /// Android: 查询字符串，多个关键字用“|”分割
  final String query;

  /// 待查询建筑物的标识 [Android, iOS]
  final String building;

  /// 待查分类组合 [Android, iOS]
  final String category;

  /// 待查城市（地区）的电话区号 [Android, iOS]
  final String city;

  /// 设置查询的是第几页，从0开始 [Android, iOS]
  final int pageNum;

  /// 设置的查询页面的结果数目 [Android, iOS]
  final int pageSize;

  /// 是否严格按照设定城市搜索 [Android, iOS]
  final bool cityLimit;

  /// 是否按照父子关系展示POI [Android, iOS]
  final bool requireSubPois;

  /// 是否按照距离排序 [Android, iOS]
  final bool distanceSort;

  /// 设置的经纬度 [iOS]
  final LatLng location;

  /// 是否需要扩展信息 [iOS]
  final bool requireExtension;

  /// 搜索边界, 周边搜索用 [Android]
  final SearchBound searchBound;

  PoiSearchQuery({
    this.query,
    this.city,
    this.category,
    this.building,
    this.pageNum = 1,
    this.pageSize = 20,
    this.cityLimit = false,
    this.requireSubPois = false,
    this.distanceSort = true,
    this.location,
    this.requireExtension = false,
    this.searchBound,
  });

  Map<String, Object> toJson() {
    return {
      'query': query,
      'building': building,
      'category': category,
      'city': city,
      'pageNum': pageNum,
      'pageSize': pageSize,
      'cityLimit': cityLimit,
      'requireSubPois': requireSubPois,
      'distanceSort': distanceSort,
      'location': location?.toJson(),
      'requireExtension': requireExtension,
      'searchBound': searchBound?.toJson(),
    };
  }

  String toJsonString() => jsonEncode(toJson());

  @override
  String toString() {
    return 'PoiSearchQuery{query: $query, building: $building, category: $category, city: $city, pageNum: $pageNum, pageSize: $pageSize, cityLimit: $cityLimit, requireSubPois: $requireSubPois, distanceSort: $distanceSort, location: $location, requireExtension: $requireExtension, searchBound: $searchBound}';
  }
}
