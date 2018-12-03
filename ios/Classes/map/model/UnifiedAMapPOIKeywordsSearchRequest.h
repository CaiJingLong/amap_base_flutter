//
// Created by Yohom Bao on 2018-12-03.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@class AMapPOIKeywordsSearchRequest;

@class LatLng;


@interface UnifiedAMapPOIKeywordsSearchRequest : JSONModel

/// 查询字符串，多个关键字用“|”分割
@property(nonatomic) NSString *query;

/// 待查询建筑物的标识
@property(nonatomic) NSString <Optional> *building;

/// 待查分类组合
@property(nonatomic) NSString <Optional> *category;

/// 待查城市（地区）的电话区号
@property(nonatomic) NSString *city;

/// 设置查询的是第几页，从0开始
@property(nonatomic) NSInteger pageNum;

/// 设置的查询页面的结果数目
@property(nonatomic) NSInteger pageSize;

/// 是否严格按照设定城市搜索
@property(nonatomic) BOOL cityLimit;

/// 是否按照父子关系展示POI
@property(nonatomic) BOOL requireSubPois;

/// 是否返回扩展信息
@property(nonatomic) BOOL requireExtension;

/// 是否按照距离排序
@property(nonatomic) BOOL distanceSort;

/// 设置的经纬度
@property(nonatomic) LatLng <Optional> *location;

- (AMapPOIKeywordsSearchRequest *)toAMapPOIKeywordsSearchRequest;

@end