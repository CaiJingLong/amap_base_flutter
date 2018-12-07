library amap_base;

import 'package:flutter/services.dart';

export 'amap_base.dart';
export 'src/map/amap_controller.dart';
export 'src/map/amap_view.dart';
export 'src/map/calculate_tool.dart';
export 'src/map/model/amap_options.dart';
export 'src/map/model/camera_position.dart';
export 'src/map/model/latlng.dart';
export 'src/map/model/marker_options.dart';
export 'src/map/model/my_location_style.dart';
export 'src/map/model/poi_search_query.dart';
export 'src/map/model/route_plan_param.dart';
export 'src/map/model/route_poi_result.dart';
export 'src/map/model/route_poi_search_query.dart';
export 'src/map/model/search_bound.dart';
export 'src/map/model/ui_settings.dart';
export 'src/navi/amap_navi.dart';

class AMap {
  static final _channel = MethodChannel('me.yohom/amap_base');

  static Future setKey(String key) {
    return _channel.invokeMethod('setKey', {'key': key});
  }
}
