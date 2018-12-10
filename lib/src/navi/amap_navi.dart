import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class AmapNavi {
  static final _channel = MethodChannel('me.yohom/amap_navi');

  static void startNavi({
    @required double lat,
    @required double lon,
  }) {
    _channel.invokeMethod(
      'startNavi',
      {
        'lat': lat,
        'lon': lon,
      },
    );
  }
}
