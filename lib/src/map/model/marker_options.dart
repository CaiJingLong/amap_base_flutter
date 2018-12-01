import 'dart:convert';

import 'package:amap_base/amap_base.dart';

class MarkerOptions {
  /// Marker覆盖物的图标 [Android]
  final String icon;

  /// Marker覆盖物的动画帧图标列表，动画的描点和大小以第一帧为准，建议图片大小保持一致 [Android]
  final List<String> icons;

  /// Marker覆盖物的透明度 [Android]
  final double alpha;

  /// Marker覆盖物锚点在水平范围的比例 [Android]
  final double anchorU;

  /// Marker覆盖物锚点垂直范围的比例 [Android]
  final double anchorV;

  /// Marker覆盖物是否可拖拽 [Android]
  final bool draggable;

  /// Marker覆盖物的InfoWindow是否允许显示, 可以通过 MarkerOptions.infoWindowEnable(boolean) 进行设置 [Android]
  final bool infoWindowEnable;

  /// 设置多少帧刷新一次图片资源，Marker动画的间隔时间，值越小动画越快 [Android]
  final int period;

  /// Marker覆盖物的位置坐标 [Android]
  final LatLng position;

  /// Marker覆盖物的图片旋转角度，从正北开始，逆时针计算 [Android]
  final double rotateAngle;

  /// Marker覆盖物是否平贴地图 [Android]
  final bool isFlat;

  /// Marker覆盖物的坐标是否是Gps，默认为false [Android]
  final bool isGps;

  /// Marker覆盖物的水平偏移距离 [Android]
  final int infoWindowOffsetX;

  /// Marker覆盖物的垂直偏移距离 [Android]
  final int infoWindowOffsetY;

  /// 设置 Marker覆盖物的 文字描述 [Android]
  final String snippet;

  /// Marker覆盖物 的标题 [Android]
  final String title;

  /// Marker覆盖物是否可见 [Android]
  final bool visible;

  /// todo 缺少文档 [Android]
  final bool autoOverturnInfoWindow;

  /// Marker覆盖物 zIndex [Android]
  final double zIndex;

  /// 显示等级 缺少文档 [Android]
  final int displayLevel;

  /// 是否在掩层下 缺少文档 [Android]
  final bool belowMaskLayer;

  MarkerOptions({
    this.icon,
    this.icons = const [],
    this.alpha = 1,
    this.anchorU = 0.5,
    this.anchorV = 1,
    this.draggable = false,
    this.infoWindowEnable = true,
    this.period = 20,
    this.position,
    this.rotateAngle = 0,
    this.isFlat = false,
    this.isGps = false,
    this.infoWindowOffsetX = 0,
    this.infoWindowOffsetY = 0,
    this.snippet = '',
    this.title = '',
    this.visible = true,
    this.autoOverturnInfoWindow = false,
    this.zIndex = 0,
    this.displayLevel = 0,
    this.belowMaskLayer = false,
  });

  Map<String, Object> toJson() {
    return {
      'icon': icon,
      'icons': icons,
      'alpha': alpha,
      'anchorU': anchorU,
      'anchorV': anchorV,
      'draggable': draggable,
      'infoWindowEnable': infoWindowEnable,
      'period': period,
      'position': position,
      'rotateAngle': rotateAngle,
      'isFlat': isFlat,
      'isGps': isGps,
      'infoWindowOffsetX': infoWindowOffsetX,
      'infoWindowOffsetY': infoWindowOffsetY,
      'snippet': snippet,
      'title': title,
      'visible': visible,
      'autoOverturnInfoWindow': autoOverturnInfoWindow,
      'zIndex': zIndex,
      'displayLevel': displayLevel,
      'belowMaskLayer': belowMaskLayer,
    };
  }

  String toJsonString() => jsonEncode(toJson());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarkerOptions &&
          runtimeType == other.runtimeType &&
          icon == other.icon &&
          icons == other.icons &&
          alpha == other.alpha &&
          anchorU == other.anchorU &&
          anchorV == other.anchorV &&
          draggable == other.draggable &&
          infoWindowEnable == other.infoWindowEnable &&
          period == other.period &&
          position == other.position &&
          rotateAngle == other.rotateAngle &&
          isFlat == other.isFlat &&
          isGps == other.isGps &&
          infoWindowOffsetX == other.infoWindowOffsetX &&
          infoWindowOffsetY == other.infoWindowOffsetY &&
          snippet == other.snippet &&
          title == other.title &&
          visible == other.visible &&
          autoOverturnInfoWindow == other.autoOverturnInfoWindow &&
          zIndex == other.zIndex &&
          displayLevel == other.displayLevel &&
          belowMaskLayer == other.belowMaskLayer;

  @override
  int get hashCode =>
      icon.hashCode ^
      icons.hashCode ^
      alpha.hashCode ^
      anchorU.hashCode ^
      anchorV.hashCode ^
      draggable.hashCode ^
      infoWindowEnable.hashCode ^
      period.hashCode ^
      position.hashCode ^
      rotateAngle.hashCode ^
      isFlat.hashCode ^
      isGps.hashCode ^
      infoWindowOffsetX.hashCode ^
      infoWindowOffsetY.hashCode ^
      snippet.hashCode ^
      title.hashCode ^
      visible.hashCode ^
      autoOverturnInfoWindow.hashCode ^
      zIndex.hashCode ^
      displayLevel.hashCode ^
      belowMaskLayer.hashCode;

  @override
  String toString() {
    return 'MarkerOptions{icon: $icon, icons: $icons, alpha: $alpha, anchorU: $anchorU, anchorV: $anchorV, draggable: $draggable, infoWindowEnable: $infoWindowEnable, period: $period, position: $position, rotateAngle: $rotateAngle, isFlat: $isFlat, isGps: $isGps, infoWindowOffsetX: $infoWindowOffsetX, infoWindowOffsetY: $infoWindowOffsetY, snippet: $snippet, title: $title, visible: $visible, autoOverturnInfoWindow: $autoOverturnInfoWindow, zIndex: $zIndex, displayLevel: $displayLevel, belowMaskLayer: $belowMaskLayer}';
  }
}
