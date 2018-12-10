import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../map/model/latlng.dart';

class OfflineManager {
  static const _channel = MethodChannel('me.yohom/offline');

  /// 打开离线地图管理页
  static Future openOfflineManager() {
    return _channel.invokeMethod('offline#openOfflineManager');
  }
}
