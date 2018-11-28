import 'dart:convert';

import 'package:amap_base/src/map/model/my_location_style.dart';
import 'package:amap_base/src/map/model/ui_settings.dart';
import 'package:amap_base/src/utils/log.dart';
import 'package:flutter/services.dart';

class AMapController {
  final MethodChannel _mapChannel;

  AMapController.withId(int id)
      : _mapChannel = MethodChannel('me.yohom/map$id');

  void setMyLocationEnabled(bool enabled, {MyLocationStyle style}) {
    final _enabled = enabled;
    final _styleJson =
        jsonEncode(style?.toJson() ?? MyLocationStyle().toJson());

    L.p('方法setMyLocationEnabled dart端参数: enabled -> $enabled, styleJson -> $_styleJson');
    _mapChannel.invokeMethod(
      'map#setMyLocationEnabled',
      {
        'enabled': _enabled,
        'myLocationStyle': _styleJson,
      },
    );
  }

  /// 缩放按钮
  void setUiSettings(UiSettings uiSettings) {
    final _uiSettings = jsonEncode(uiSettings.toJson());

    L.p('方法setUiSettings dart端参数: _uiSettings -> $_uiSettings');
    _mapChannel.invokeMethod(
      'map#setUiSettings',
      {'uiSettings': _uiSettings},
    );
  }
}
