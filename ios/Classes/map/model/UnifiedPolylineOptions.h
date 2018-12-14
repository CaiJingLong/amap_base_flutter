//
// Created by Yohom Bao on 2018-12-10.
//

#import <Foundation/Foundation.h>

@class LatLng;


@interface UnifiedPolylineOptions : NSObject

+ (instancetype)initWithJson:(NSString *)json;

/// 顶点
@property(nonatomic) NSArray<LatLng *> *latLngList;

/// 线段的宽度
@property(nonatomic) CGFloat width;

/// 线段的颜色
@property(nonatomic) NSString *color;

/// 线段的Z轴值
@property(nonatomic) CGFloat zIndex;

/// 线段的可见属性
@property(nonatomic) BOOL isVisible;

/// 线段是否画虚线，默认为false，画实线
@property(nonatomic) BOOL isDottedLine;

/// 线段是否为大地曲线，默认false，不画大地曲线
@property(nonatomic) BOOL isGeodesic;

/// 虚线形状
@property(nonatomic) NSInteger dottedLineType;

/// Polyline尾部形状
@property(nonatomic) NSInteger lineCapType;

/// Polyline连接处形状
@property(nonatomic) NSInteger lineJoinType;

/// 线段是否使用渐变色
@property(nonatomic) BOOL isUseGradient;

/// 线段是否使用纹理贴图
@property(nonatomic) BOOL isUseTexture;

@end