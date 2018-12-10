import 'dart:convert';
import 'dart:ui';

import 'package:amap_base/amap_base.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class PolylineOptions {
  static const DOTTEDLINE_TYPE_CIRCLE = 1;
  static const DOTTEDLINE_TYPE_SQUARE = 0;

  static const LINE_CAP_TYPE_BUTT = 0;
  static const LINE_CAP_TYPE_SQUARE = 1;
  static const LINE_CAP_TYPE_ARROW = 2;
  static const LINE_CAP_TYPE_ROUND = 3;

  static const LINE_JOIN_BEVEL = 0;
  static const LINE_JOIN_MITER = 1;
  static const LINE_JOIN_ROUND = 2;

  /// 顶点
  final List<LatLng> latLngList;

  /// 线段的宽度
  final double width;

  /// 线段的颜色
  final Color color;

  /// 线段的Z轴值
  final double zIndex;

  /// 线段的可见属性
  final bool isVisible;

  /// 线段是否画虚线，默认为false，画实线
  final bool isDottedLine;

  /// 线段是否为大地曲线，默认false，不画大地曲线
  final bool isGeodesic;

  /// 虚线形状
  final int dottedLineType;

  /// Polyline尾部形状
  final int lineCapType;

  /// Polyline连接处形状
  final int lineJoinType;

  /// 线段是否使用渐变色
  final bool isUseGradient;

  /// 线段是否使用纹理贴图
  final bool isUseTexture;

  PolylineOptions({
    @required this.latLngList,
    @required this.width,
    this.color = Colors.black,
    this.zIndex = 0,
    this.isVisible = true,
    this.isDottedLine = false,
    this.isGeodesic = false,
    this.dottedLineType = DOTTEDLINE_TYPE_SQUARE,
    this.lineCapType = LINE_CAP_TYPE_BUTT,
    this.lineJoinType = LINE_JOIN_BEVEL,
    this.isUseGradient = false,
    this.isUseTexture = false,
  });

  Map<String, Object> toJson() {
    return {
      'latLngList': latLngList?.map((it) => it.toJson())?.toList() ?? List(),
      'width': width,
      'color': color.value.toRadixString(16),
      'zIndex': zIndex,
      'isVisible': isVisible,
      'isDottedLine': isDottedLine,
      'isGeodesic': isGeodesic,
      'dottedLineType': dottedLineType,
      'lineCapType': lineCapType,
      'lineJoinType': lineJoinType,
      'isUseGradient': isUseGradient,
      'isUseTexture': isUseTexture,
    };
  }

  String toJsonString() => jsonEncode(toJson());

  @override
  String toString() {
    return 'PolylineOptions{latLngList: $latLngList, width: $width, color: $color, zIndex: $zIndex, isVisible: $isVisible, isDottedLine: $isDottedLine, isGeodesic: $isGeodesic, dottedLineType: $dottedLineType, lineCapType: $lineCapType, lineJoinType: $lineJoinType, isUseGradient: $isUseGradient, isUseTexture: $isUseTexture}';
  }
}
