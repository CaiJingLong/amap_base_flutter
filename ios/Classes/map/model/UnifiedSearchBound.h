//
// Created by Yohom Bao on 2018-12-04.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@class LatLng;
@protocol LatLng;
@protocol Optional;


@interface UnifiedSearchBound : JSONModel

/// 左下
@property(nonatomic) LatLng <Optional> *lowerLeft;
/// 右上
@property(nonatomic) LatLng <Optional> *upperRight;
/// 中心点
@property(nonatomic) LatLng *center;
/// 半径范围
@property(nonatomic) NSInteger range;
/// 形状
@property(nonatomic) NSString <Optional> *shape;
/// 按距离排序
@property(nonatomic) BOOL isDistanceSort;
/// 多边形的顶点坐标
@property(nonatomic) NSArray <LatLng> *polyGonList;

@end