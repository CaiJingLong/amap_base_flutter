//
// Created by Yohom Bao on 2018/11/27.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@class MAUserLocationRepresentation;
@class MAMapView;

@interface UnifiedMyLocationStyle : JSONModel

/// 圆形区域（以定位位置为圆心，定位半径的圆形区域）的填充颜色值
@property(nonatomic) NSString *radiusFillColor;

/// 圆形区域（以定位位置为圆心，定位半径的圆形区域）边框的颜色值
@property(nonatomic) NSString *strokeColor;

/// 圆形区域（以定位位置为圆心，定位半径的圆形区域）边框的宽度
@property(nonatomic) CGFloat strokeWidth;

/// 是否显示定位小蓝点
@property(nonatomic) BOOL showMyLocation;

/// 精度圈是否显示，默认YES
@property(nonatomic) BOOL showsAccuracyRing;

/// 是否显示方向指示(MAUserTrackingModeFollowWithHeading模式开启)。默认为YES
@property(nonatomic) BOOL showsHeadingIndicator;

/// 定位点背景色，不设置默认白色
@property(nonatomic) NSString *locationDotBgColor;

/// 定位点蓝色圆点颜色，不设置默认蓝色
@property(nonatomic) NSString *locationDotFillColor;

/// 内部蓝色圆点是否使用律动效果, 默认YES
@property(nonatomic) BOOL enablePulseAnnimation;

/// 定位图标, 与蓝色原点互斥
@property(nonatomic) NSString<Optional> *image;

- (NSString *)description;

- (void)applyTo: (MAMapView *) mapView;

@end
