import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../map/model/latlng.dart';

class AMapTools {
  static final _channel = MethodChannel('me.yohom/tools');
  static const _convert = 'convert';

  /// 转换坐标系
  ///
  /// [lat] 纬度
  /// [lon] 经度
  ///
  /// [type] 原坐标类型, 这部分请查阅高德地图官方文档
  static Future<LatLng> convertLatlng({
    @required double lat,
    @required double lon,
    @required LatlngType type,
  }) async {
    int intType = LatlngType.values.indexOf(type);

    String result = await _channel.invokeMethod(_convert, {
      'lat': lat,
      'lon': lon,
      'type': intType,
    });

    if (result == null) {
      return null;
    }

    List<String> resultList = result.split("|");

    if (resultList.length != 2) {
      return null;
    }

    return LatLng(double.tryParse(resultList[0]) ?? 0.0,
        double.tryParse(resultList[1]) ?? 0.0);
  }
}

enum LatlngType {
  gps,
  baidu,
  mapBar,
  mapABC,
  soSoMap,
  aliYun,
  google,
}
