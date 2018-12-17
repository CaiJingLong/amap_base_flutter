//
// Created by Yohom Bao on 2018-12-16.
//

#import <Foundation/Foundation.h>

@class AMapGeoPoint;
@class AMapGeoPoint;
@class AMapRouteSearchResponse;
@class AMapPath;
@class AMapStep;
@class AMapCity;
@class AMapDistrict;
@class AMapTMC;
@class UnifiedDrivePathResult;
@class UnifiedDriveStepResult;
@class UnifiedRouteSearchCityResult;
@class UnifiedTMCResult;
@class UnifiedDistrictResult;
@class UnifiedGeocodeQuery;
@class AMapGeocodeSearchResponse;
@class UnifiedGeocodeAddress;
@class AMapGeocode;
@class AMapPOISearchResponse;
@class PoiItem;
@class SuggestionCity;
@class AMapPOI;
@class IndoorData;
@class Photo;
@class PoiExtension;
@class SubPoiItem;
@class AMapSubPOI;
@class AMapPOIExtension;
@class AMapImage;
@class AMapIndoorData;
@class UnifiedSearchBound;
@class AMapPOIKeywordsSearchRequest;
@class AMapPOIAroundSearchRequest;
@class AMapPOIPolygonSearchRequest;
@class AMapRoutePOISearchRequest;
@class UnifiedRoutePOIItem;
@class AMapRoutePOISearchResponse;

//region RoutePlanParam
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
//endregion


//region UnifiedDriveRouteResult
@interface UnifiedDriveRouteResult : NSObject

- (instancetype)initWithAMapRouteSearchResponse:(AMapRouteSearchResponse *)response;

@property(nonatomic) AMapGeoPoint *startPos;
@property(nonatomic) AMapGeoPoint *targetPos;
@property(nonatomic) CGFloat taxiCost;
@property(nonatomic) NSArray <UnifiedDrivePathResult *> *paths;
@end

@interface UnifiedDrivePathResult : NSObject

- (instancetype)initWithAMapPath:(AMapPath *)path;

@property(nonatomic) NSString *strategy;
@property(nonatomic) CGFloat tolls;
@property(nonatomic) CGFloat tollDistance;
@property(nonatomic) NSInteger totalTrafficlights;
@property(nonatomic) NSArray <UnifiedDriveStepResult *> *steps;
@property(nonatomic) NSInteger restriction;

@end

@interface UnifiedDriveStepResult : NSObject

- (instancetype)initWithAMapStep:(AMapStep *)step;

@property(nonatomic) NSString *instruction;
@property(nonatomic) NSString *orientation;
@property(nonatomic) NSString *road;
@property(nonatomic) CGFloat distance;
@property(nonatomic) CGFloat tolls;
@property(nonatomic) CGFloat tollDistance;
@property(nonatomic) NSString *tollRoad;
@property(nonatomic) CGFloat duration;
@property(nonatomic) NSArray <AMapGeoPoint *> *polyline;
@property(nonatomic) NSString *action;
@property(nonatomic) NSString *assistantAction;
@property(nonatomic) NSArray<UnifiedRouteSearchCityResult *> *routeSearchCityList;
@property(nonatomic) NSArray <UnifiedTMCResult *> *TMCs;
@end

@interface UnifiedRouteSearchCityResult : NSObject

- (instancetype)initWithAMapCity:(AMapCity *)step;

@property(nonatomic) NSArray <UnifiedDistrictResult *> *districts;
@end

@interface UnifiedTMCResult : NSObject

- (instancetype)initWithAMapTMC:(AMapTMC *)tmc;

@property(nonatomic) NSInteger distance;
@property(nonatomic) NSString *status;
@property(nonatomic) NSArray <AMapGeoPoint *> *polyline;
@end

@interface UnifiedDistrictResult : NSObject

- (instancetype)initWithAMapDistrict:(AMapDistrict *)district;

@property(nonatomic) NSString *districtName;
@property(nonatomic) NSString *districtAdcode;
@end
//endregion


//region UnifiedGeocodeResult
@interface UnifiedGeocodeResult : NSObject

- (instancetype)initWithAMapGeocodeSearchResponse:(AMapGeocodeSearchResponse *)response;

@property(nonatomic) UnifiedGeocodeQuery *geocodeQuery;
@property(nonatomic) NSArray <UnifiedGeocodeAddress *> *geocodeAddressList;
@end

@interface UnifiedGeocodeAddress : NSObject

- (instancetype)initWithAMapGeocode:(AMapGeocode *)geocode;

@property(nonatomic) NSString *formatAddress;
@property(nonatomic) NSString *province;
@property(nonatomic) NSString *city;
@property(nonatomic) NSString *district;
@property(nonatomic) NSString *township;
@property(nonatomic) NSString *neighborhood;
@property(nonatomic) NSString *building;
@property(nonatomic) NSString *adcode;
@property(nonatomic) AMapGeoPoint *latLng;
@property(nonatomic) NSString *level;
@end

@interface UnifiedGeocodeQuery : NSObject
@property(nonatomic) NSString *locationName;
@property(nonatomic) NSString *city;
@end
//endregion


//region UnifiedPoiResult
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
//endregion


//region UnifiedPoiSearchQuery
/// 搜索请求参数 Android是合并在一个类里的, iOS分裂成了多个类, 在这里也并在一起, 然后提供各自的生成方法
@interface UnifiedPoiSearchQuery : NSObject
/// 查询字符串，多个关键字用“|”分割
@property(nonatomic) NSString *query;
/// 待查询建筑物的标识
@property(nonatomic) NSString *building;
/// 待查分类组合
@property(nonatomic) NSString *category;
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
@property(nonatomic) AMapGeoPoint *location;
/// 搜索边界
@property(nonatomic) UnifiedSearchBound *searchBound;

/// 转换为关键字搜索对象
- (AMapPOIKeywordsSearchRequest *)toAMapPOIKeywordsSearchRequest;

/// 转换为周边搜索对象
- (AMapPOIAroundSearchRequest *)toAMapPOIAroundSearchRequest;

/// 转换为周边搜索对象
- (AMapPOIPolygonSearchRequest *)toAMapPOIPolygonSearchRequest;

@end
//endregion


//region UnifiedRoutePoiSearchQuery
@interface UnifiedRoutePoiSearchQuery : NSObject
@property(nonatomic) AMapGeoPoint *from;
@property(nonatomic) AMapGeoPoint *to;
@property(nonatomic) NSInteger mode;
@property(nonatomic) NSInteger searchType;
@property(nonatomic) NSInteger range;
@property(nonatomic) NSArray <AMapGeoPoint *> *polylines;

- (AMapRoutePOISearchRequest *)toAMapRoutePOISearchRequestLine;

- (AMapRoutePOISearchRequest *)toAMapRoutePOISearchRequestPolygon;

@end
//endregion


//region UnifiedRoutePOISearchResult
@interface UnifiedRoutePOISearchResult : NSObject

- (instancetype)initWithAMapRoutePOISearchResponse:(AMapRoutePOISearchResponse *)result;

@property(nonatomic) NSArray <UnifiedRoutePOIItem *> *routePoiList;
@property(nonatomic) NSString *query;
@end

@interface UnifiedRoutePOIItem : NSObject

- (instancetype)initWithAMapPOI:(AMapPOI *)aMapPOI;

@property(nonatomic) NSString *id;
@property(nonatomic) NSString *title;
@property(nonatomic) AMapGeoPoint *point;
@property(nonatomic) NSInteger distance;
@property(nonatomic) NSInteger duration;

@end
//endregion


//region UnifiedSearchBound
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
//endregion