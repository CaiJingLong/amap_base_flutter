import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../map/model/latlng.dart';

class CalculateTools {
  static const _channel = MethodChannel('me.yohom/tool');

  /// 转换坐标系
  ///
  /// [lat] 纬度
  /// [lon] 经度
  ///
  /// [type] 原坐标类型, 这部分请查阅高德地图官方文档
  static Future<LatLng> convertCoordinate({
    @required double lat,
    @required double lon,
    @required LatLngType type,
  }) async {
    int intType = LatLngType.values.indexOf(type);

    String result = await _channel.invokeMethod(
      'tool#convertCoordinate',
      {
        'lat': lat,
        'lon': lon,
        'type': intType,
      },
    );

    if (result == null) {
      return null;
    }

    return LatLng.fromJson(json.decode(result));
  }
}

enum LatLngType {
  gps,
  baidu,
  mapBar,
  mapABC,
  soSoMap,
  aliYun,
  google,
}
