import 'dart:convert';

import 'package:amap_base_location/amap_base.dart';
import 'package:amap_base_location/src/search/model/drive_route_result.dart';
import 'package:meta/meta.dart';

class RouteOverlay {
  static const drive = '0';
  static const walk = '1';
  static const ride = '2';

  final String type;
  final LatLng from;
  final LatLng to;
  final List<LatLng> passby;
  final DrivePath drivePath;

  RouteOverlay({
    @required this.from,
    @required this.to,
    @required this.drivePath,
    this.type = drive,
    this.passby = const [],
  });

  Map<String, Object> toJson() {
    return {
      'type': type,
      'from': from.toJson(),
      'to': to.toJson(),
      'passby': passby.map((it) => it.toJson()).toList(),
      'drivePath': drivePath.toJson()
    };
  }

  String toJsonString() => jsonEncode(toJson());

  @override
  String toString() {
    return 'RouteOverlay{type: $type, from: $from, to: $to, passby: $passby, drivePath: $drivePath}';
  }
}
