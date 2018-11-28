import 'package:amap_base/src/map/model/camera_position.dart';

class AMapOptions {
  const AMapOptions({
    this.logoPosition = LOGO_POSITION_BOTTOM_LEFT,
    this.zOrderOnTop = false,
    this.mapType = MAP_TYPE_NORMAL,
    this.camera,
    this.scaleControlsEnabled = false,
    this.zoomControlsEnabled = true,
    this.compassEnabled = false,
    this.scrollGesturesEnabled = true,
    this.zoomGesturesEnabled = true,
    this.tiltGesturesEnabled = true,
    this.rotateGesturesEnabled = true,
    this.myLocationEnabled = false,
  });

  /// Logo位置常量（地图左下角）。
  static const int LOGO_POSITION_BOTTOM_LEFT = 0;

  /// Logo位置常量（地图底部居中）。
  static const int LOGO_POSITION_BOTTOM_CENTER = 1;

  /// Logo位置常量（地图右下角）。
  static const int LOGO_POSITION_BOTTOM_RIGHT = 2;

  /// 普通地图
  static const int MAP_TYPE_NORMAL = 1;

  /// 卫星地图
  static const int MAP_TYPE_SATELLITE = 2;

  /// 黑夜地图
  static const int MAP_TYPE_NIGHT = 3;

  /// 导航模式
  static const int MAP_TYPE_NAVI = 4;

  /// 公交模式
  static const int MAP_TYPE_BUS = 5;

  /// “高德地图”Logo的位置
  final int logoPosition;
  final bool zOrderOnTop;

  /// 地图模式
  final int mapType;

  /// 地图初始化时的地图状态， 默认地图中心点为北京天安门，缩放级别为 10.0f。
  final CameraPosition camera;

  /// 比例尺功能是否可用
  final bool scaleControlsEnabled;

  /// 地图是否允许缩放
  final bool zoomControlsEnabled;

  /// 指南针是否可用。
  final bool compassEnabled;

  /// 拖动手势是否可用
  final bool scrollGesturesEnabled;

  /// 缩放手势是否可用
  final bool zoomGesturesEnabled;

  /// 地图倾斜手势（显示3D效果）是否可用
  final bool tiltGesturesEnabled;

  /// 地图旋转手势是否可用
  final bool rotateGesturesEnabled;

  /// 是否启动显示定位蓝点, 默认false
  final bool myLocationEnabled;

  Map<String, Object> toJson() {
    return {
      'logoPosition': logoPosition,
      'zOrderOnTop': zOrderOnTop,
      'mapType': mapType,
      'camera': camera?.toJson(),
      'scaleControlsEnabled': scaleControlsEnabled,
      'zoomControlsEnabled': zoomControlsEnabled,
      'compassEnabled': compassEnabled,
      'scrollGesturesEnabled': scrollGesturesEnabled,
      'zoomGesturesEnabled': zoomGesturesEnabled,
      'tiltGesturesEnabled': tiltGesturesEnabled,
      'rotateGesturesEnabled': rotateGesturesEnabled,
      'myLocationEnabled': myLocationEnabled,
    };
  }

  AMapOptions copyWith({
    int logoPosition,
    bool zOrderOnTop,
    int mapType,
    CameraPosition camera,
    bool scaleControlsEnabled,
    bool zoomControlsEnabled,
    bool compassEnabled,
    bool scrollGesturesEnabled,
    bool zoomGesturesEnabled,
    bool tiltGesturesEnabled,
    bool rotateGesturesEnabled,
    bool myLocationEnabled,
  }) {
    return AMapOptions(
      logoPosition: logoPosition ?? this.logoPosition,
      zOrderOnTop: zOrderOnTop ?? this.zOrderOnTop,
      mapType: mapType ?? this.mapType,
      camera: camera ?? this.camera,
      scaleControlsEnabled: scaleControlsEnabled ?? this.scaleControlsEnabled,
      zoomControlsEnabled: zoomControlsEnabled ?? this.zoomControlsEnabled,
      compassEnabled: compassEnabled ?? this.compassEnabled,
      scrollGesturesEnabled:
          scrollGesturesEnabled ?? this.scrollGesturesEnabled,
      zoomGesturesEnabled: zoomGesturesEnabled ?? this.zoomGesturesEnabled,
      tiltGesturesEnabled: tiltGesturesEnabled ?? this.tiltGesturesEnabled,
      rotateGesturesEnabled:
          rotateGesturesEnabled ?? this.rotateGesturesEnabled,
      myLocationEnabled: myLocationEnabled ?? this.myLocationEnabled,
    );
  }

  @override
  String toString() {
    return 'AMapOptions{logoPosition: $logoPosition, zOrderOnTop: $zOrderOnTop, mapType: $mapType, camera: $camera, scaleControlsEnabled: $scaleControlsEnabled, zoomControlsEnabled: $zoomControlsEnabled, compassEnabled: $compassEnabled, scrollGesturesEnabled: $scrollGesturesEnabled, zoomGesturesEnabled: $zoomGesturesEnabled, tiltGesturesEnabled: $tiltGesturesEnabled, rotateGesturesEnabled: $rotateGesturesEnabled, myLocationEnabled: $myLocationEnabled}';
  }
}
