import 'dart:convert';

import 'package:amap_base/amap_base.dart';
import 'package:amap_base/src/map/model/marker_options.dart';
import 'package:amap_base/src/map/model/my_location_style.dart';
import 'package:amap_base/src/map/model/poi_result.dart';
import 'package:amap_base/src/map/model/poi_search_query.dart';
import 'package:amap_base/src/map/model/route_plan_param.dart';
import 'package:amap_base/src/map/model/ui_settings.dart';
import 'package:amap_base/src/utils/log.dart';
import 'package:flutter/services.dart';

class AMapController {
  final MethodChannel _mapChannel;

  AMapController.withId(int id)
      : _mapChannel = MethodChannel('me.yohom/map$id');

  void setMyLocationStyle(MyLocationStyle style) {
    final _styleJson =
        jsonEncode(style?.toJson() ?? MyLocationStyle().toJson());

    L.p('方法setMyLocationStyle dart端参数: styleJson -> $_styleJson');
    _mapChannel.invokeMethod(
      'map#setMyLocationStyle',
      {'myLocationStyle': _styleJson},
    );
  }

  void setUiSettings(UiSettings uiSettings) {
    final _uiSettings = jsonEncode(uiSettings.toJson());

    L.p('方法setUiSettings dart端参数: _uiSettings -> $_uiSettings');
    _mapChannel.invokeMethod(
      'map#setUiSettings',
      {'uiSettings': _uiSettings},
    );
  }

  Future calculateDriveRoute(RoutePlanParam param) {
    final _routePlanParam = param.toJsonString();
    L.p('方法calculateDriveRoute dart端参数: _routePlanParam -> $_routePlanParam');
    return _mapChannel.invokeMethod(
      'map#calculateDriveRoute',
      {'routePlanParam': _routePlanParam},
    );
  }

  void addMarker(MarkerOptions options) {
    final _optionsJson = options.toJsonString();
    L.p('方法addMarker dart端参数: _optionsJson -> $_optionsJson');
    _mapChannel.invokeMethod(
      'marker#addMarker',
      {'markerOptions': _optionsJson},
    );
  }

  void addMarkers(List<MarkerOptions> optionsList,
      {bool moveToCenter = true, bool clear = true}) {
    final _optionsListJson =
        jsonEncode(optionsList.map((it) => it.toJson()).toList());
    L.p('方法addMarkers dart端参数: _optionsListJson -> $_optionsListJson');
    _mapChannel.invokeMethod(
      'marker#addMarkers',
      {
        'moveToCenter': moveToCenter,
        'markerOptionsList': _optionsListJson,
        'clear': clear,
      },
    );
  }

  void showIndoorMap(bool enable) {
    _mapChannel.invokeMethod(
      'map#showIndoorMap',
      {'showIndoorMap': enable},
    );
  }

  void setMapType(int mapType) {
    _mapChannel.invokeMethod(
      'map#setMapType',
      {'mapType': mapType},
    );
  }

  void setLanguage(int language) {
    _mapChannel.invokeMethod(
      'map#setLanguage',
      {'language': language},
    );
  }

  void clearMarkers() {
    _mapChannel.invokeMethod('marker#clear');
  }

  void clearMap() {
    _mapChannel.invokeMethod('map#clear');
  }

  Future<PoiResult> searchPoi(PoiSearchQuery query) {
    L.p('方法searchPoi dart端参数: query.toJsonString() -> ${query.toJsonString()}');

    return _mapChannel
        .invokeMethod(
          'map#searchPoi',
          {'query': query.toJsonString()},
        )
        .then((result) => result as String)
        .then((resultJsonString) =>
            PoiResult.fromJson(jsonDecode(resultJsonString)));
  }
}
