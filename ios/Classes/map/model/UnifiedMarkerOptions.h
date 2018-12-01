//
// Created by Yohom Bao on 2018-12-01.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@class LatLng;
@class MAPointAnnotation;

@interface UnifiedMarkerOptions : JSONModel
/// Marker覆盖物的图标
@property(nonatomic) NSString <Optional> *icon;

/// Marker覆盖物锚点在水平范围的比例
@property(nonatomic) CGFloat anchorU;

/// Marker覆盖物锚点垂直范围的比例
@property(nonatomic) CGFloat anchorV;

/// Marker覆盖物是否可拖拽
@property(nonatomic) BOOL draggable;

/// Marker覆盖物的InfoWindow是否允许显示, 可以通过 MarkerOptions.infoWindowEnable(BOOLean) 进行设置
@property(nonatomic) BOOL infoWindowEnable;

/// Marker覆盖物的位置坐标
@property(nonatomic) LatLng *position;

/// Marker覆盖物的水平偏移距离
@property(nonatomic) NSInteger infoWindowOffsetX;

/// Marker覆盖物的垂直偏移距离
@property(nonatomic) NSInteger infoWindowOffsetY;

/// 设置 Marker覆盖物的 文字描述
@property(nonatomic) NSString *snippet;

/// Marker覆盖物 的标题
@property(nonatomic) NSString *title;

/// Marker覆盖物 zIndex
@property(nonatomic) CGFloat zIndex;

/// 是否固定在屏幕一点, 注意，拖动或者手动改变经纬度，都会导致设置失效 [暂未实现]
@property(nonatomic) BOOL lockedToScreen;

/// 固定屏幕点的坐标 [iOS暂未实现]
@property(nonatomic) NSObject <Optional> *lockedScreenPoint;

/// 自定制弹出框view, 用于替换默认弹出框. [暂未实现]
@property(nonatomic) NSObject <Optional> *customCalloutView;

/// 默认为YES,当为NO时view忽略触摸事件
@property(nonatomic) BOOL enabled;

/// 是否高亮
@property(nonatomic) BOOL highlighted;

/// 设置是否处于选中状态, 外部如果要选中请使用mapView的selectAnnotation方法
@property(nonatomic) BOOL selected;

/// 显示在默认弹出框左侧的view [暂未实现]
@property(nonatomic) NSObject <Optional> *leftCalloutAccessoryView;

/// 显示在默认弹出框右侧的view [暂未实现]
@property(nonatomic) NSObject <Optional> *rightCalloutAccessoryView;

- (NSString *)description;

@end