import 'dart:convert';

import 'package:amap_base_map/amap_base.dart';
import 'package:meta/meta.dart';

class RoutePlanParam {
  RoutePlanParam({
    @required this.from,
    @required this.to,
    this.mode = 0,
    this.passedByPoints,
    this.avoidPolygons,
    this.avoidRoad,
  });

  /// 起点
  final LatLng from;

  /// 终点
  final LatLng to;

  /// 计算路径的模式，可选，默认为速度优先=0
  final int mode;

  /// 途经点，可选
  final List<LatLng> passedByPoints;

  /// 避让区域，可选，支持32个避让区域，每个区域最多可有16个顶点。如果是四边形则有4个坐标点，如果是五边形则有5个坐标点
  final List<List<LatLng>> avoidPolygons;

  /// 避让道路，只支持一条避让道路，避让区域和避让道路同时设置，只有避让道路生效
  final String avoidRoad;

  Map<String, Object> toJson() {
    return {
      'from': from.toJson(),
      'to': to.toJson(),
      'mode': mode,
      'passedByPoints': passedByPoints?.map((it) => it.toJson())?.toList(),
      'avoidPolygons': avoidPolygons
          ?.map((list) => list.map((it) => it.toJson()).toList())
          ?.toList(),
      'avoidRoad': avoidRoad,
    };
  }

  String toJsonString() => jsonEncode(toJson());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutePlanParam &&
          runtimeType == other.runtimeType &&
          from == other.from &&
          to == other.to &&
          mode == other.mode &&
          passedByPoints == other.passedByPoints &&
          avoidPolygons == other.avoidPolygons &&
          avoidRoad == other.avoidRoad;

  @override
  int get hashCode =>
      from.hashCode ^
      to.hashCode ^
      mode.hashCode ^
      passedByPoints.hashCode ^
      avoidPolygons.hashCode ^
      avoidRoad.hashCode;

  @override
  String toString() {
    return 'RoutePlanParam{from: $from, to: $to, mode: $mode, passedByPoints: $passedByPoints, avoidPolygons: $avoidPolygons, avoidRoad: $avoidRoad}';
  }
}
