//
// Created by Yohom Bao on 2018-12-03.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class AMapGeoPoint;
@class IndoorData;
@class Photo;
@class SubPoiItem;
@class PoiItem;
@class SuggestionCity;
@class PoiExtension;

@class AMapCity;
@class AMapPOISearchResponse;
@class AMapPOI;
@class AMapIndoorData;
@class AMapImage;
@class AMapPOIExtension;
@class AMapSubPOI;

@interface UnifiedPoiResult : NSObject

- (instancetype)initWithPoiResult:(AMapPOISearchResponse *)result;

/// 返回的POI数目
@property NSInteger pageCount;
/// POI结果，AMapPOI 数组
@property(nonatomic) NSArray <PoiItem *> *pois;
/// 城市建议列表
@property(nonatomic) NSArray <SuggestionCity *> *searchSuggestionCitys;
/// 关键字建议列表
@property(nonatomic) NSArray<NSString *> *searchSuggestionKeywords;

@end

@interface PoiItem : NSObject

- (instancetype)initWithAMapPOI:(AMapPOI *)aMapPOI;

/// POI全局唯一ID
@property(nonatomic) NSString *poiId;
/// 区域编码
@property(nonatomic) NSString *adCode;
/// 区域名称
@property(nonatomic) NSString *adName;
/// 所在商圈
@property(nonatomic) NSString *businessArea;
/// 城市编码
@property(nonatomic) NSString *cityCode;
/// 城市名称
@property(nonatomic) NSString *cityName;
/// 方向
@property(nonatomic) NSString *direction;
/// 距中心点的距离，单位米。在周边搜索时有效
@property NSInteger distance;
/// 电子邮件
@property(nonatomic) NSString *email;
/// 室内信息
@property(nonatomic) IndoorData *indoorData;
/// 是否有室内地图
@property BOOL isIndoorMap;
/// 经纬度
@property(nonatomic) AMapGeoPoint *latLonPoint;
/// 入口经纬度
@property(nonatomic) AMapGeoPoint *enter;
/// 出口经纬度
@property(nonatomic) AMapGeoPoint *exit;
/// 停车场类型，地上、地下、路边
@property(nonatomic) NSString *parkingType;
/// 图片列表
@property(nonatomic) NSArray <Photo *> *photos;
/// 扩展信息 只有在ID查询时有效
@property(nonatomic) PoiExtension *poiExtension;
/// 邮编
@property(nonatomic) NSString *postcode;
/// 省编码
@property(nonatomic) NSString *provinceCode;
/// 省
@property(nonatomic) NSString *provinceName;
/// 商铺id
@property(nonatomic) NSString *shopID;
/// 地址
@property(nonatomic) NSString *snippet;
/// 子POI列表
@property(nonatomic) NSArray <SubPoiItem *> *subPois;
/// 电话
@property(nonatomic) NSString *tel;
/// 名称
@property(nonatomic) NSString *title;
/// 类型编码
@property(nonatomic) NSString *typeCode;
/// 兴趣点类型
@property(nonatomic) NSString *typeDes;
/// 网址
@property(nonatomic) NSString *website;
/// 地理格ID [iOS]
@property(nonatomic) NSString *gridCode;

@end

@interface SuggestionCity : NSObject

- (instancetype)initWithAMapSuggestion:(AMapCity *)suggestion;

/// 城市名称
@property(nonatomic) NSString *cityName;
/// 城市编码
@property(nonatomic) NSString *cityCode;
/// 城市区域编码
@property(nonatomic) NSString *adCode;
/// 此区域的建议结果数目
@property NSInteger suggestionNum;
/// 途径区域
@property(nonatomic) NSObject *districts;

@end

@interface SubPoiItem : NSObject

- (instancetype)initWithSubPoi:(AMapSubPOI *)subPOI;

/// POI全局唯一ID
@property(nonatomic) NSString *poiId;
/// POI全称，如“北京大学(西2门)”
@property(nonatomic) NSString *title;
/// 子POI的子名称，如“西2门”
@property(nonatomic) NSString *subName;
/// 距中心点距离
@property NSInteger distance;
/// 经纬度
@property(nonatomic) AMapGeoPoint *latLonPoint;
/// 地址
@property(nonatomic) NSString *snippet;
/// 子POI类型
@property(nonatomic) NSString *subTypeDes;

@end

@interface PoiExtension : NSObject

- (instancetype)initWithAMapPOIExtension:(AMapPOIExtension *)poiExtension;

/// 营业时间
@property(nonatomic) NSString *opentime;
/// 评分
@property NSString *rating;
/// 人均消费
@property CGFloat cost;

@end

@interface Photo : NSObject

- (instancetype)initWithAMapImage:(AMapImage *)image;

/// 标题
@property(nonatomic) NSString *title;
/// url
@property(nonatomic) NSString *url;

@end

@interface IndoorData : NSObject

- (instancetype)initWithAMapIndoorData:(AMapIndoorData *)indoorData;

/// 楼层，为0时为POI本身
@property NSInteger floor;
/// 楼层名称
@property(nonatomic) NSString *floorName;
/// 建筑物ID
@property(nonatomic) NSString *poiId;

@end
