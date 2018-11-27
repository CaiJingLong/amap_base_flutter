//
// Created by Yohom Bao on 2018/11/26.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@class LatLng;
@class CameraPosition;

@interface AMapOptions : JSONModel
/// “高德地图”Logo的位置
@property(nonatomic) NSInteger logoPosition;
@property(nonatomic) BOOL zOrderOnTop;

/// 地图模式
@property(nonatomic) NSInteger mapType;

/// 地图初始化时的地图状态， 默认地图中心点为北京天安门，缩放级别为 10.0f。
@property(nonatomic) CameraPosition *camera;

/// 比例尺功能是否可用
@property(nonatomic) BOOL scaleControlsEnabled;

/// 地图是否允许缩放
@property(nonatomic) BOOL zoomControlsEnabled;

/// 指南针是否可用。
@property(nonatomic) BOOL compassEnabled;

/// 拖动手势是否可用
@property(nonatomic) BOOL scrollGesturesEnabled;

/// 缩放手势是否可用
@property(nonatomic) BOOL zoomGesturesEnabled;

/// 地图倾斜手势（显示3D效果）是否可用
@property(nonatomic) BOOL tiltGesturesEnabled;

/// 地图旋转手势是否可用
@property(nonatomic) BOOL rotateGesturesEnabled;

- (NSString *)description;

@end

@interface CameraPosition : JSONModel
/// 目标位置的屏幕中心点经纬度坐标。默认北京
@property(nonatomic) LatLng *target;

/// 目标可视区域的缩放级别。
@property(nonatomic) CGFloat zoom;

/// 目标可视区域的倾斜度，以角度为单位。
@property(nonatomic) CGFloat tilt;

/// 可视区域指向的方向，以角度为单位，从正北向逆时针方向计算，从0 度到360 度。
@property(nonatomic) CGFloat bearing;

- (NSString *)description;
@end

@interface LatLng : JSONModel

@property(nonatomic) CGFloat latitude;
@property(nonatomic) CGFloat longitude;

- (NSString *)description;

@end

