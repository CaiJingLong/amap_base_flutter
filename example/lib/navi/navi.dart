import 'package:flutter/services.dart';

class AMapNavi {
  static final _channel = MethodChannel('me.yohom/amap_navi');

  static void start(double lat, double lon) {
    _channel.invokeMethod('startNavi', {'lat': lat, 'lon': lon});
  }

  static Future setKey(String key) {
    return _channel.invokeMethod('setKey', {'key': key});
  }
}
