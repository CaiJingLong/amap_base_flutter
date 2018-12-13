//
// Created by Yohom Bao on 2018-11-29.
//

#import <Foundation/Foundation.h>

@class AMapGeoPoint;

@interface RoutePlanParam : NSObject

/// 起点
@property(nonatomic) AMapGeoPoint *from;

/// 终点
@property(nonatomic) AMapGeoPoint *to;

/// 计算路径的模式，可选，默认为速度优先=0
@property(nonatomic) NSInteger mode;

/// 途经点，可选
@property(nonatomic) NSArray<AMapGeoPoint *> *passedByPoints;

/// 避让区域，可选，支持32个避让区域，每个区域最多可有16个顶点。如果是四边形则有4个坐标点，如果是五边形则有5个坐标点
@property(nonatomic) NSArray<NSArray<AMapGeoPoint *> *> *avoidPolygons;

/// 避让道路，只支持一条避让道路，避让区域和避让道路同时设置，只有避让道路生效
@property(nonatomic) NSString *avoidRoad;

- (NSString *)description;

@end