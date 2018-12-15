import 'dart:convert';

import 'package:amap_base_location/src/common/log.dart';
import 'package:amap_base_location/src/location/model/location.dart';
import 'package:amap_base_location/src/location/model/location_client_options.dart';
import 'package:flutter/services.dart';

class AMapLocation {
  static AMapLocation _instance;

  static const _locationChannel = MethodChannel('me.yohom/location');
  static const _locationEventChannel = EventChannel('me.yohom/location_event');

  AMapLocation._();

  factory AMapLocation() {
    if (_instance == null) {
      _instance = AMapLocation._();
      return _instance;
    } else {
      return _instance;
    }
  }

  /// 初始化
  Future init() {
    return _locationChannel.invokeMethod('location#init');
  }

  /// 开始定位, 返回定位 结果流
  Stream<Location> startLocate(LocationClientOptions options) {
    L.p('startLocate dart端参数: options.toJsonString() -> ${options.toJsonString()}');

    _locationChannel.invokeMethod(
        'location#startLocate', {'options': options.toJsonString()});

    return _locationEventChannel
        .receiveBroadcastStream()
        .map((result) => result as String)
        .map((resultJson) => Location.fromJson(jsonDecode(resultJson)));
  }

  /// 结束定位, 但是仍然可以打开, 其实严格说是暂停
  Future stopLocate() {
    return _locationChannel.invokeMethod('location#stopLocate');
  }
}
