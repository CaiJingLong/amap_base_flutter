//
// Created by Yohom Bao on 2018-12-04.
//

#import <Foundation/Foundation.h>

@class LatLng;

@interface UnifiedSearchBound : NSObject

/// 左下
@property(nonatomic) LatLng *lowerLeft;
/// 右上
@property(nonatomic) LatLng *upperRight;
/// 中心点
@property(nonatomic) LatLng *center;
/// 半径范围
@property(nonatomic) NSInteger range;
/// 形状
@property(nonatomic) NSString *shape;
/// 按距离排序
@property(nonatomic) BOOL isDistanceSort;
/// 多边形的顶点坐标
@property(nonatomic) NSArray <LatLng *> *polyGonList;

@end