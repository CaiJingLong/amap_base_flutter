import 'package:amap_base/amap_base.dart';

class SearchBound {
  /// 左下
  LatLng lowerLeft;

  /// 右上
  LatLng upperRight;

  /// 中心点
  LatLng center;

  /// 半径范围
  int range;

  /// 形状
  String shape;

  /// 按距离排序
  bool isDistanceSort;

  /// 多边形的顶点坐标
  List<LatLng> polyGonList;

  SearchBound({
    this.lowerLeft,
    this.upperRight,
    this.center,
    this.range,
    this.shape,
    this.isDistanceSort,
    this.polyGonList,
  });

  SearchBound.fromJson(Map<String, dynamic> json)
      : lowerLeft = json['lowerLeft'] != null
            ? LatLng.fromJson(json['lowerLeft'] as Map<String, Object>)
            : null,
        upperRight = json['upperRight'] != null
            ? LatLng.fromJson(json['upperRight'] as Map<String, Object>)
            : null,
        center = json['center'] != null
            ? LatLng.fromJson(json['center'] as Map<String, Object>)
            : null,
        range = json['range'] as int,
        shape = json['shape'] as String,
        isDistanceSort = json['isDistanceSort'] as bool {
    if (json['polyGonList'] != null) {
      polyGonList = List<LatLng>();
      json['polyGonList'].forEach((v) {
        polyGonList.add(LatLng.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lowerLeft'] = this.lowerLeft?.toJson();
    data['upperRight'] = this.upperRight?.toJson();
    data['center'] = this.center?.toJson();
    data['range'] = this.range;
    data['shape'] = this.shape;
    data['isDistanceSort'] = this.isDistanceSort;
    data['polyGonList'] = this.polyGonList?.map((it) => it.toJson());
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchBound &&
          runtimeType == other.runtimeType &&
          lowerLeft == other.lowerLeft &&
          upperRight == other.upperRight &&
          center == other.center &&
          range == other.range &&
          shape == other.shape &&
          isDistanceSort == other.isDistanceSort &&
          polyGonList == other.polyGonList;

  @override
  int get hashCode =>
      lowerLeft.hashCode ^
      upperRight.hashCode ^
      center.hashCode ^
      range.hashCode ^
      shape.hashCode ^
      isDistanceSort.hashCode ^
      polyGonList.hashCode;

  @override
  String toString() {
    return 'SearchBound{lowerLeft: $lowerLeft, upperRight: $upperRight, center: $center, range: $range, shape: $shape, isDistanceSort: $isDistanceSort, polyGonList: $polyGonList}';
  }
}
