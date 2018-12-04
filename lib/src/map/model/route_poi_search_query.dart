import 'dart:convert';

import 'package:amap_base/amap_base.dart';

class RoutePoiSearchQuery {
  LatLng from;
  LatLng to;
  int mode;
  int searchType;
  int range;
  List<LatLng> polylines;

  RoutePoiSearchQuery.line({
    this.from,
    this.to,
    this.mode,
    this.searchType,
    this.range = 250,
  });

  RoutePoiSearchQuery.polygon({
    this.searchType,
    this.range = 250,
    this.polylines,
  });

  Map<String, Object> toJson() {
    return {
      'from': from,
      'to': to,
      'mode': mode,
      'searchType': searchType,
      'range': range,
      'polylines': polylines,
    };
  }

  String toJsonString() => jsonEncode(toJson());

  @override
  String toString() {
    return 'RoutePOISearchQuery{from: $from, to: $to, mode: $mode, searchType: $searchType, range: $range, polylines: $polylines}';
  }
}
