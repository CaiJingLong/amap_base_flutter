import 'dart:convert';

import 'package:amap_base/amap_base.dart';
import 'package:meta/meta.dart';

class RoutePlanParam {
  final LatLng from;
  final LatLng to;
  final int mode;
  final List<LatLng> passedByPoints;
  final List<List<LatLng>> avoidPolygons;
  final String avoidRoad;

  RoutePlanParam({
    @required this.from,
    @required this.to,
    this.mode = 0,
    this.passedByPoints,
    this.avoidPolygons,
    this.avoidRoad,
  });

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
