import 'dart:ui';

class MyLocationStyle {
  /// 定位、且将视角移动到地图中心点，定位点跟随设备移动
  static const LOCATION_TYPE_FOLLOW = 2;

  /// 定位、但不会移动到地图中心点，并且会跟随设备移动
  static const LOCATION_TYPE_FOLLOW_NO_CENTER = 6;

  /// 定位、且将视角移动到地图中心点
  static const LOCATION_TYPE_LOCATE = 1;

  /// 定位、且将视角移动到地图中心点，定位点依照设备方向旋转，并且会跟随设备移动
  static const LOCATION_TYPE_LOCATION_ROTATE = 4;

  /// 定位、但不会移动到地图中心点，定位点依照设备方向旋转，并且会跟随设备移动
  static const LOCATION_TYPE_LOCATION_ROTATE_NO_CENTER = 5;

  /// 定位、且将视角移动到地图中心点，地图依照设备方向旋转，定位点会跟随设备移动
  static const LOCATION_TYPE_MAP_ROTATE = 3;

  /// 定位、但不会移动到地图中心点，地图依照设备方向旋转，并且会跟随设备移动
  static const LOCATION_TYPE_MAP_ROTATE_NO_CENTER = 7;

  /// 只定位
  static const LOCATION_TYPE_SHOW = 0;

  /// 当前位置的图标
  final String myLocationIcon;

  /// 锚点横坐标方向的偏移量
  final double anchorU;

  /// 锚点纵坐标方向的偏移量
  final double anchorV;

  /// 由于颜色的int值传递到android端后超出了int范围, 造成无法解析, 这里用String代替一下
  /// 圆形区域（以定位位置为圆心，定位半径的圆形区域）的填充颜色值
  final Color radiusFillColor;

  /// 由于颜色的int值传递到android端后超出了int范围, 造成无法解析, 这里用String代替一下
  /// 圆形区域（以定位位置为圆心，定位半径的圆形区域）边框的颜色值
  final Color strokeColor;

  /// 圆形区域（以定位位置为圆心，定位半径的圆形区域）边框的宽度
  final double strokeWidth;

  /// 我的位置展示模式
  final int myLocationType;

  /// 定位请求时间间隔
  final int interval;

  /// 是否显示定位小蓝点
  final bool showMyLocation;

  MyLocationStyle({
    this.myLocationIcon,
    this.anchorU = 0.5,
    this.anchorV = 0.5,
    this.radiusFillColor = const Color(0xff0000dc),
    this.strokeColor = const Color(0x640000b4),
    this.strokeWidth = 1,
    this.myLocationType = LOCATION_TYPE_LOCATION_ROTATE,
    this.interval = 2000,
    this.showMyLocation = true,
  });

  Map<String, Object> toJson() {
    return {
      'myLocationIcon': myLocationIcon,
      'anchorU': anchorU,
      'anchorV': anchorV,
      'radiusFillColor': radiusFillColor.value.toRadixString(16),
      'strokeColor': strokeColor.value.toRadixString(16),
      'strokeWidth': strokeWidth,
      'myLocationType': myLocationType,
      'interval': interval,
      'showMyLocation': showMyLocation,
    };
  }

  MyLocationStyle copyWith({
    String myLocationIcon,
    double anchorU,
    double anchorV,
    Color radiusFillColor,
    Color strokeColor,
    double strokeWidth,
    int myLocationType,
    int interval,
    bool showMyLocation,
  }) {
    return MyLocationStyle(
      myLocationIcon: myLocationIcon ?? this.myLocationIcon,
      anchorU: anchorU ?? this.anchorU,
      anchorV: anchorV ?? this.anchorV,
      radiusFillColor: radiusFillColor ?? this.radiusFillColor,
      strokeColor: strokeColor ?? this.strokeColor,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      myLocationType: myLocationType ?? this.myLocationType,
      interval: interval ?? this.interval,
      showMyLocation: showMyLocation ?? this.showMyLocation,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyLocationStyle &&
          runtimeType == other.runtimeType &&
          myLocationIcon == other.myLocationIcon &&
          anchorU == other.anchorU &&
          anchorV == other.anchorV &&
          radiusFillColor == other.radiusFillColor &&
          strokeColor == other.strokeColor &&
          strokeWidth == other.strokeWidth &&
          myLocationType == other.myLocationType &&
          interval == other.interval &&
          showMyLocation == other.showMyLocation;

  @override
  int get hashCode =>
      myLocationIcon.hashCode ^
      anchorU.hashCode ^
      anchorV.hashCode ^
      radiusFillColor.hashCode ^
      strokeColor.hashCode ^
      strokeWidth.hashCode ^
      myLocationType.hashCode ^
      interval.hashCode ^
      showMyLocation.hashCode;

  @override
  String toString() {
    return 'MyLocationStyle{myLocationIcon: $myLocationIcon, anchorU: $anchorU, anchorV: $anchorV, radiusFillColor: $radiusFillColor, strokeColor: $strokeColor, strokeWidth: $strokeWidth, myLocationType: $myLocationType, interval: $interval, showMyLocation: $showMyLocation}';
  }
}
