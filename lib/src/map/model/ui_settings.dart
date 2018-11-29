import 'dart:convert';

class UiSettings {
  /// 是否允许显示缩放按钮 [Android]
  final bool isZoomControlsEnabled;

  /// 设置缩放按钮的位置 [Android]
  final int zoomPosition;

  /// 指南针 [Android, iOS]
  final bool isCompassEnabled;

  /// 定位按钮 [Android]
  final bool isMyLocationButtonEnabled;

  /// 比例尺控件 [Android, iOS]
  final bool isScaleControlsEnabled;

  /// 地图Logo [Android, iOS暂未实现]
  final int logoPosition;

  UiSettings({
    this.isZoomControlsEnabled,
    this.zoomPosition,
    this.isCompassEnabled,
    this.isMyLocationButtonEnabled,
    this.isScaleControlsEnabled,
    this.logoPosition,
  });

  Map<String, Object> toJson() {
    return {
      'isZoomControlsEnabled': isZoomControlsEnabled,
      'zoomPosition': zoomPosition,
      'isCompassEnabled': isCompassEnabled,
      'isMyLocationButtonEnabled': isMyLocationButtonEnabled,
      'isScaleControlsEnabled': isScaleControlsEnabled,
      'logoPosition': logoPosition
    };
  }

  String toJsonString() => jsonEncode(toJson());

  UiSettings copyWith({
    bool isZoomControlsEnabled,
    int zoomPosition,
    bool isCompassEnabled,
    bool isMyLocationButtonEnabled,
    bool isScaleControlsEnabled,
    int logoPosition,
  }) {
    return UiSettings(
      isZoomControlsEnabled:
          isZoomControlsEnabled ?? this.isZoomControlsEnabled,
      zoomPosition: zoomPosition ?? this.zoomPosition,
      isCompassEnabled: isCompassEnabled ?? this.isCompassEnabled,
      isMyLocationButtonEnabled:
          isMyLocationButtonEnabled ?? this.isMyLocationButtonEnabled,
      isScaleControlsEnabled:
          isScaleControlsEnabled ?? this.isScaleControlsEnabled,
      logoPosition: logoPosition ?? this.logoPosition,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UiSettings &&
          runtimeType == other.runtimeType &&
          isZoomControlsEnabled == other.isZoomControlsEnabled &&
          zoomPosition == other.zoomPosition &&
          isCompassEnabled == other.isCompassEnabled &&
          isMyLocationButtonEnabled == other.isMyLocationButtonEnabled &&
          isScaleControlsEnabled == other.isScaleControlsEnabled &&
          logoPosition == other.logoPosition;

  @override
  int get hashCode =>
      isZoomControlsEnabled.hashCode ^
      zoomPosition.hashCode ^
      isCompassEnabled.hashCode ^
      isMyLocationButtonEnabled.hashCode ^
      isScaleControlsEnabled.hashCode ^
      logoPosition.hashCode;

  @override
  String toString() {
    return 'UiSettings{isZoomControlsEnabled: $isZoomControlsEnabled, zoomPosition: $zoomPosition, isCompassEnabled: $isCompassEnabled, isMyLocationButtonEnabled: $isMyLocationButtonEnabled, isScaleControlsEnabled: $isScaleControlsEnabled, isLogoPosition: $logoPosition}';
  }
}
