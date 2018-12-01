import 'dart:convert';

import 'package:amap_base/amap_base.dart';
import 'package:meta/meta.dart';

class MarkerOptions {
  /// Marker覆盖物的图标 [Android, iOS]
  final String icon;

  /// Marker覆盖物的动画帧图标列表，动画的描点和大小以第一帧为准，建议图片大小保持一致 [Android]
  final List<String> icons;

  /// Marker覆盖物的透明度 [Android]
  final double alpha;

  /// Marker覆盖物锚点在水平范围的比例 [Android, iOS]
  final double anchorU;

  /// Marker覆盖物锚点垂直范围的比例 [Android, iOS]
  final double anchorV;

  /// Marker覆盖物是否可拖拽 [Android, iOS]
  final bool draggable;

  /// Marker覆盖物的InfoWindow是否允许显示, 可以通过 MarkerOptions.infoWindowEnable(boolean) 进行设置 [Android, iOS]
  final bool infoWindowEnable;

  /// 设置多少帧刷新一次图片资源，Marker动画的间隔时间，值越小动画越快 [Android]
  final int period;

  /// Marker覆盖物的位置坐标 [Android, iOS]
  final LatLng position;

  /// Marker覆盖物的图片旋转角度，从正北开始，逆时针计算 [Android]
  final double rotateAngle;

  /// Marker覆盖物是否平贴地图 [Android]
  final bool isFlat;

  /// Marker覆盖物的坐标是否是Gps，默认为false [Android]
  final bool isGps;

  /// Marker覆盖物的水平偏移距离 [Android, iOS]
  final int infoWindowOffsetX;

  /// Marker覆盖物的垂直偏移距离 [Android, iOS]
  final int infoWindowOffsetY;

  /// 设置 Marker覆盖物的文字描述 [Android, iOS]
  final String snippet;

  /// Marker覆盖物的标题 [Android, iOS]
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

  /// 是否固定在屏幕一点, 注意，拖动或者手动改变经纬度，都会导致设置失效 [iOS暂未实现]
  final bool lockedToScreen;

  /// 固定屏幕点的坐标 [iOS暂未实现]
  final Object lockedScreenPoint;

  /// 自定制弹出框view, 用于替换默认弹出框. [iOS暂未实现]
  final Object customCalloutView;

  /// 默认为YES,当为NO时view忽略触摸事件 [iOS]
  final bool enabled;

  /// 是否高亮 [iOS]
  final bool highlighted;

  /// 设置是否处于选中状态, 外部如果要选中请使用mapView的selectAnnotation方法 [iOS]
  final bool selected;

  /// 显示在默认弹出框左侧的view [iOS暂未实现]
  final Object leftCalloutAccessoryView;

  /// 显示在默认弹出框右侧的view [iOS暂未实现]
  final Object rightCalloutAccessoryView;

  MarkerOptions({
    @required this.position,
    this.icon,
    this.icons = const [],
    this.alpha = 1,
    this.anchorU = 0.5,
    this.anchorV = 1,
    this.draggable = false,
    this.infoWindowEnable = true,
    this.period = 20,
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
    this.lockedToScreen = false,
    this.lockedScreenPoint = false,
    this.customCalloutView,
    this.enabled = true,
    this.highlighted = false,
    this.selected = false,
    this.leftCalloutAccessoryView,
    this.rightCalloutAccessoryView,
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
      'lockedToScreen': lockedToScreen,
      'lockedScreenPoint': lockedScreenPoint,
      'customCalloutView': customCalloutView,
      'enabled': enabled,
      'highlighted': highlighted,
      'selected': selected,
      'leftCalloutAccessoryView': leftCalloutAccessoryView,
      'rightCalloutAccessoryView': rightCalloutAccessoryView,
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
          belowMaskLayer == other.belowMaskLayer &&
          lockedToScreen == other.lockedToScreen &&
          lockedScreenPoint == other.lockedScreenPoint &&
          customCalloutView == other.customCalloutView &&
          enabled == other.enabled &&
          highlighted == other.highlighted &&
          selected == other.selected &&
          leftCalloutAccessoryView == other.leftCalloutAccessoryView &&
          rightCalloutAccessoryView == other.rightCalloutAccessoryView;

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
      belowMaskLayer.hashCode ^
      lockedToScreen.hashCode ^
      lockedScreenPoint.hashCode ^
      customCalloutView.hashCode ^
      enabled.hashCode ^
      highlighted.hashCode ^
      selected.hashCode ^
      leftCalloutAccessoryView.hashCode ^
      rightCalloutAccessoryView.hashCode;

  @override
  String toString() {
    return 'MarkerOptions{icon: $icon, icons: $icons, alpha: $alpha, anchorU: $anchorU, anchorV: $anchorV, draggable: $draggable, infoWindowEnable: $infoWindowEnable, period: $period, position: $position, rotateAngle: $rotateAngle, isFlat: $isFlat, isGps: $isGps, infoWindowOffsetX: $infoWindowOffsetX, infoWindowOffsetY: $infoWindowOffsetY, snippet: $snippet, title: $title, visible: $visible, autoOverturnInfoWindow: $autoOverturnInfoWindow, zIndex: $zIndex, displayLevel: $displayLevel, belowMaskLayer: $belowMaskLayer, lockedToScreen: $lockedToScreen, lockedScreenPoint: $lockedScreenPoint, customCalloutView: $customCalloutView, enabled: $enabled, highlighted: $highlighted, selected: $selected, leftCalloutAccessoryView: $leftCalloutAccessoryView, rightCalloutAccessoryView: $rightCalloutAccessoryView}';
  }
}
