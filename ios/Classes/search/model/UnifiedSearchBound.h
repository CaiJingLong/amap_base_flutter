//
// Created by Yohom Bao on 2018-12-04.
//

#import <Foundation/Foundation.h>

@class AMapGeoPoint;

@interface UnifiedSearchBound : NSObject

/// 左下
@property(nonatomic) AMapGeoPoint *lowerLeft;
/// 右上
@property(nonatomic) AMapGeoPoint *upperRight;
/// 中心点
@property(nonatomic) AMapGeoPoint *center;
/// 半径范围
@property(nonatomic) NSInteger range;
/// 形状
@property(nonatomic) NSString *shape;
/// 按距离排序
@property(nonatomic) BOOL isDistanceSort;
/// 多边形的顶点坐标
@property(nonatomic) NSArray <AMapGeoPoint *> *polyGonList;

@end