import 'package:amap_base/amap_base.dart';

class RoutePoiResult {
  List<RoutePoiItem> routePoiList;
  Map query;

  RoutePoiResult.fromJson(Map<String, dynamic> json) {
    if (json['routePoiList'] != null) {
      routePoiList = List<RoutePoiItem>();
      json['routePoiList'].forEach((v) {
        routePoiList.add(RoutePoiItem.fromJson(v as Map<String, dynamic>));
      });
    }
    query = json['query'] as Map;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['routePoiList'] = routePoiList.map((it) => it.toJson()).toList();
    data['query'] = query;
    return data;
  }

  @override
  String toString() {
    return 'RoutePoiResult{routePoiList: $routePoiList, query: $query}';
  }
}

class RoutePoiItem {
  String id;
  String title;
  LatLng point;
  num distance;
  num duration;

  RoutePoiItem.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    title = json['title'] as String;
    point = LatLng.fromJson(json['point'] as Map<String, Object>);
    distance = json['distance'] as num;
    duration = json['duration'] as num;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['point'] = point.toJson();
    data['distance'] = distance;
    data['duration'] = duration;
    return data;
  }

  @override
  String toString() {
    return 'RoutePoiItem{id: $id, title: $title, point: $point, distance: $distance, duration: $duration}';
  }
}
