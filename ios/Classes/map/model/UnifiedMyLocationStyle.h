//
// Created by Yohom Bao on 2018/11/27.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@class MAUserLocationRepresentation;

@interface UnifiedMyLocationStyle : JSONModel
/// 当前位置的图标
@property(nonatomic) NSString <Optional> *myLocationIcon;

/// 锚点横坐标方向的偏移量
@property(nonatomic) CGFloat anchorU;

/// 锚点纵坐标方向的偏移量
@property(nonatomic) CGFloat anchorV;

/// 由于颜色的int值传递到android端后超出了int范围, 造成无法解析, 这里用String代替一下
/// 圆形区域（以定位位置为圆心，定位半径的圆形区域）的填充颜色值
@property(nonatomic) NSString *radiusFillColor;

/// 由于颜色的int值传递到android端后超出了int范围, 造成无法解析, 这里用String代替一下
/// 圆形区域（以定位位置为圆心，定位半径的圆形区域）边框的颜色值
@property(nonatomic) NSString *strokeColor;

/// 圆形区域（以定位位置为圆心，定位半径的圆形区域）边框的宽度
@property(nonatomic) CGFloat strokeWidth;

/// 我的位置展示模式
@property(nonatomic) NSInteger myLocationType;

/// 定位请求时间间隔
@property(nonatomic) NSInteger interval;

/// 是否显示定位小蓝点
@property(nonatomic) BOOL showMyLocation;

- (NSString *)description;

- (MAUserLocationRepresentation *)toMAUserLocationRepresentation;

@end