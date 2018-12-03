import 'dart:convert';

import 'package:amap_base/amap_base.dart';
import 'package:meta/meta.dart';

class PoiSearchQuery {
  /// 查询字符串，多个关键字用“|”分割
  final String query;

  /// 待查询建筑物的标识 [Android]
  final String building;

  /// 待查分类组合 [Android]
  final String category;

  /// 待查城市（地区）的电话区号 [Android]
  final String city;

  /// 设置查询的是第几页，从0开始 [Android]
  final int pageNum;

  /// 设置的查询页面的结果数目 [Android]
  final int pageSize;

  /// 是否严格按照设定城市搜索 [Android]
  final bool cityLimit;

  /// 是否按照父子关系展示POI [Android]
  final bool requireSubPois;

  /// 是否按照距离排序 [Android]
  final bool distanceSort;

  /// 设置的经纬度 [Android]
  final LatLng location;

  PoiSearchQuery({
    @required this.query,
    @required this.city,
    this.category,
    this.building,
    this.pageNum = 1,
    this.pageSize = 20,
    this.cityLimit = false,
    this.requireSubPois = false,
    this.distanceSort = true,
    this.location,
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
      'location': location,
    };
  }

  String toJsonString() => jsonEncode(toJson());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PoiSearchQuery &&
          runtimeType == other.runtimeType &&
          query == other.query &&
          building == other.building &&
          category == other.category &&
          city == other.city &&
          pageNum == other.pageNum &&
          pageSize == other.pageSize &&
          cityLimit == other.cityLimit &&
          requireSubPois == other.requireSubPois &&
          distanceSort == other.distanceSort &&
          location == other.location;

  @override
  int get hashCode =>
      query.hashCode ^
      building.hashCode ^
      category.hashCode ^
      city.hashCode ^
      pageNum.hashCode ^
      pageSize.hashCode ^
      cityLimit.hashCode ^
      requireSubPois.hashCode ^
      distanceSort.hashCode ^
      location.hashCode;

  @override
  String toString() {
    return 'PoiSearchQuery{query: $query, building: $building, category: $category, city: $city, pageNum: $pageNum, pageSize: $pageSize, cityLimit: $cityLimit, requireSubPois: $requireSubPois, distanceSort: $distanceSort, location: $location}';
  }
}
