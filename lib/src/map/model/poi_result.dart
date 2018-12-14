import 'package:amap_base_navi/amap_base.dart';
import 'package:amap_base_navi/src/map/model/search_bound.dart';

class PoiResult {
  /// 返回的POI数目 [Android, iOS]
  int pageCount;

  /// 搜索边界 [Android]
  SearchBound bound;

  /// POI结果，AMapPOI 数组 [Android, iOS]
  List<PoiItem> pois;

  /// 请求参数 [Android]
  Query query;

  /// 城市建议列表 [Android, iOS]
  List<SuggestionCity> searchSuggestionCitys;

  /// 关键字建议列表 [Android, iOS]
  List<String> searchSuggestionKeywords;

  PoiResult({
    this.pageCount,
    this.bound,
    this.pois,
    this.query,
    this.searchSuggestionCitys,
    this.searchSuggestionKeywords,
  });

  PoiResult.fromJson(Map<String, dynamic> json) {
    pageCount = json['pageCount'] as int;
    if (json['bound'] != null) {
      bound = SearchBound.fromJson(json['bound'] as Map<String, Object>);
    }
    if (json['pois'] != null) {
      pois = List<PoiItem>();
      json['pois'].forEach((v) {
        pois.add(PoiItem.fromJson(v as Map<String, dynamic>));
      });
    }
    query = json['query'] != null ? Query.fromJson(json['query']) : null;
    if (json['searchSuggestionCitys'] != null) {
      searchSuggestionCitys = List<SuggestionCity>();
      json['searchSuggestionCitys'].forEach((v) {
        searchSuggestionCitys
            .add(SuggestionCity.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['searchSuggestionKeywords'] != null) {
      searchSuggestionKeywords = List<Null>();
      json['searchSuggestionKeywords'].forEach((v) {
        searchSuggestionKeywords.add(v as String);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pageCount'] = this.pageCount;
    data['bound'] = this.bound.toJson();
    if (this.pois != null) {
      data['pois'] = this.pois.map((v) => v.toJson()).toList();
    }
    if (this.query != null) {
      data['query'] = this.query.toJson();
    }
    if (this.searchSuggestionCitys != null) {
      data['searchSuggestionCitys'] =
          this.searchSuggestionCitys.map((v) => v.toJson()).toList();
    }
    if (this.searchSuggestionKeywords != null) {
      data['searchSuggestionKeywords'] = this.searchSuggestionKeywords;
    }
    return data;
  }

  PoiResult copyWith({
    int pageCount,
    List pois,
    Query query,
    List searchSuggestionCitys,
    List searchSuggestionKeywords,
  }) {
    return PoiResult(
      pageCount: pageCount ?? this.pageCount,
      pois: pois ?? this.pois,
      query: query ?? this.query,
      searchSuggestionCitys:
          searchSuggestionCitys ?? this.searchSuggestionCitys,
      searchSuggestionKeywords:
          searchSuggestionKeywords ?? this.searchSuggestionKeywords,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PoiResult &&
          runtimeType == other.runtimeType &&
          pageCount == other.pageCount &&
          pois == other.pois &&
          query == other.query &&
          searchSuggestionCitys == other.searchSuggestionCitys &&
          searchSuggestionKeywords == other.searchSuggestionKeywords;

  @override
  int get hashCode =>
      pageCount.hashCode ^
      pois.hashCode ^
      query.hashCode ^
      searchSuggestionCitys.hashCode ^
      searchSuggestionKeywords.hashCode;

  @override
  String toString() {
    return '''PoiResult{
		pageCount: $pageCount,
		pois: $pois,
		query: $query,
		searchSuggestionCitys: $searchSuggestionCitys,
		searchSuggestionKeywords: $searchSuggestionKeywords}''';
  }
}

class PoiItem {
  /// POI全局唯一ID [Android, iOS]
  String poiId;

  /// 区域编码 [Android, iOS]
  String adCode;

  /// 区域名称 [Android, iOS]
  String adName;

  /// 所在商圈 [Android, iOS]
  String businessArea;

  /// 城市编码 [Android, iOS]
  String cityCode;

  /// 城市名称 [Android, iOS]
  String cityName;

  /// 方向 [Android, iOS]
  String direction;

  /// 距中心点的距离，单位米。在周边搜索时有效 [Android, iOS]
  int distance;

  /// 电子邮件 [Android, iOS]
  String email;

  /// 室内信息 [Android, iOS]
  IndoorData indoorData;

  /// 是否有室内地图 [Android, iOS]
  bool isIndoorMap;

  /// 经纬度 [Android, iOS]
  LatLng latLonPoint;

  /// 入口经纬度 [Android, iOS]
  LatLng enter;

  /// 出口经纬度 [Android, iOS]
  LatLng exit;

  /// 停车场类型，地上、地下、路边 [Android, iOS]
  String parkingType;

  /// 图片列表 [Android, iOS]
  List<Photo> photos;

  /// 扩展信息 只有在ID查询时有效 [Android, iOS]
  PoiExtension poiExtension;

  /// 邮编 [Android, iOS]
  String postcode;

  /// 省编码 [Android, iOS]
  String provinceCode;

  /// 省 [Android, iOS]
  String provinceName;

  /// 商铺id [Android, iOS]
  String shopID;

  /// 地址 [Android, iOS]
  String snippet;

  /// 子POI列表 [Android, iOS]
  List<SubPoiItem> subPois;

  /// 电话 [Android, iOS]
  String tel;

  /// 名称 [Android, iOS]
  String title;

  /// 类型编码 [Android, iOS]
  String typeCode;

  /// 兴趣点类型 [Android, iOS]
  String typeDes;

  /// 网址 [Android, iOS]
  String website;

  /// 地理格ID [iOS]
  String gridCode;

  PoiItem({
    this.adCode,
    this.adName,
    this.businessArea,
    this.cityCode,
    this.cityName,
    this.direction,
    this.distance,
    this.email,
    this.indoorData,
    this.isIndoorMap,
    this.latLonPoint,
    this.enter,
    this.exit,
    this.parkingType,
    this.photos,
    this.poiExtension,
    this.poiId,
    this.postcode,
    this.provinceCode,
    this.provinceName,
    this.shopID,
    this.snippet,
    this.subPois,
    this.tel,
    this.title,
    this.typeCode,
    this.typeDes,
    this.website,
    this.gridCode,
  });

  PoiItem.fromJson(Map<String, dynamic> json) {
    adCode = json['adCode'] as String;
    adName = json['adName'] as String;
    businessArea = json['businessArea'] as String;
    cityCode = json['cityCode'] as String;
    cityName = json['cityName'] as String;
    direction = json['direction'] as String;
    distance = json['distance'] as int;
    email = json['email'] as String;
    indoorData = json['indoorData'] != null
        ? IndoorData.fromJson(json['indoorData'])
        : null;
    isIndoorMap = json['isIndoorMap'] as bool;
    latLonPoint = json['latLonPoint'] != null
        ? LatLng.fromJson(json['latLonPoint'])
        : null;
    enter = json['enter'] != null ? LatLng.fromJson(json['enter']) : null;
    exit = json['exit'] != null ? LatLng.fromJson(json['exit']) : null;
    parkingType = json['parkingType'] as String;
    if (json['photos'] != null) {
      photos = List<Photo>();
      json['photos'].forEach((v) {
        photos.add(Photo.fromJson(v as Map<String, dynamic>));
      });
    }
    poiExtension = json['poiExtension'] != null
        ? PoiExtension.fromJson(json['poiExtension'])
        : null;
    poiId = json['poiId'] as String;
    postcode = json['postcode'] as String;
    provinceCode = json['provinceCode'] as String;
    provinceName = json['provinceName'] as String;
    shopID = json['shopID'] as String;
    snippet = json['snippet'] as String;
    if (json['subPois'] != null) {
      subPois = List<SubPoiItem>();
      json['subPois'].forEach((v) {
        subPois.add(SubPoiItem.fromJson(v as Map<String, dynamic>));
      });
    }
    tel = json['tel'] as String;
    title = json['title'] as String;
    typeCode = json['typeCode'] as String;
    typeDes = json['typeDes'] as String;
    website = json['website'] as String;
    gridCode = json['gridCode'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['adCode'] = this.adCode;
    data['adName'] = this.adName;
    data['businessArea'] = this.businessArea;
    data['cityCode'] = this.cityCode;
    data['cityName'] = this.cityName;
    data['direction'] = this.direction;
    data['distance'] = this.distance;
    data['email'] = this.email;
    if (this.indoorData != null) {
      data['indoorData'] = this.indoorData.toJson();
    }
    data['isIndoorMap'] = this.isIndoorMap;
    if (this.latLonPoint != null) {
      data['latLonPoint'] = this.latLonPoint.toJson();
    }
    if (this.enter != null) {
      data['enter'] = this.enter.toJson();
    }
    if (this.exit != null) {
      data['exit'] = this.exit.toJson();
    }
    data['parkingType'] = this.parkingType;
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    if (this.poiExtension != null) {
      data['poiExtension'] = this.poiExtension.toJson();
    }
    data['poiId'] = this.poiId;
    data['postcode'] = this.postcode;
    data['provinceCode'] = this.provinceCode;
    data['provinceName'] = this.provinceName;
    data['shopID'] = this.shopID;
    data['snippet'] = this.snippet;
    if (this.subPois != null) {
      data['subPois'] = this.subPois.map((v) => v.toJson()).toList();
    }
    data['tel'] = this.tel;
    data['title'] = this.title;
    data['typeCode'] = this.typeCode;
    data['typeDes'] = this.typeDes;
    data['website'] = this.website;
    data['gridCode'] = this.gridCode;
    return data;
  }

  PoiItem copyWith({
    String adCode,
    String adName,
    String businessArea,
    String cityCode,
    String cityName,
    String direction,
    int distance,
    String email,
    IndoorData indoorData,
    bool isIndoorMap,
    LatLng latLonPoint,
    LatLng enter,
    LatLng exit,
    String parkingType,
    List photos,
    PoiExtension poiExtension,
    String poiId,
    String postcode,
    String provinceCode,
    String provinceName,
    String shopID,
    String snippet,
    List subPois,
    String tel,
    String title,
    String typeCode,
    String typeDes,
    String website,
    String gridCode,
  }) {
    return PoiItem(
      adCode: adCode ?? this.adCode,
      adName: adName ?? this.adName,
      businessArea: businessArea ?? this.businessArea,
      cityCode: cityCode ?? this.cityCode,
      cityName: cityName ?? this.cityName,
      direction: direction ?? this.direction,
      distance: distance ?? this.distance,
      email: email ?? this.email,
      indoorData: indoorData ?? this.indoorData,
      isIndoorMap: isIndoorMap ?? this.isIndoorMap,
      latLonPoint: latLonPoint ?? this.latLonPoint,
      enter: enter ?? this.enter,
      exit: exit ?? this.exit,
      parkingType: parkingType ?? this.parkingType,
      photos: photos ?? this.photos,
      poiExtension: poiExtension ?? this.poiExtension,
      poiId: poiId ?? this.poiId,
      postcode: postcode ?? this.postcode,
      provinceCode: provinceCode ?? this.provinceCode,
      provinceName: provinceName ?? this.provinceName,
      shopID: shopID ?? this.shopID,
      snippet: snippet ?? this.snippet,
      subPois: subPois ?? this.subPois,
      tel: tel ?? this.tel,
      title: title ?? this.title,
      typeCode: typeCode ?? this.typeCode,
      typeDes: typeDes ?? this.typeDes,
      website: website ?? this.website,
      gridCode: gridCode ?? this.gridCode,
    );
  }

  @override
  String toString() {
    return 'PoiItem{poiId: $poiId, adCode: $adCode, adName: $adName, businessArea: $businessArea, cityCode: $cityCode, cityName: $cityName, direction: $direction, distance: $distance, email: $email, indoorData: $indoorData, isIndoorMap: $isIndoorMap, latLonPoint: $latLonPoint, enter: $enter, exit: $exit, parkingType: $parkingType, photos: $photos, poiExtension: $poiExtension, postcode: $postcode, provinceCode: $provinceCode, provinceName: $provinceName, shopID: $shopID, snippet: $snippet, subPois: $subPois, tel: $tel, title: $title, typeCode: $typeCode, typeDes: $typeDes, website: $website, gridCode: $gridCode}';
  }
}

class IndoorData {
  /// 楼层，为0时为POI本身 [Android, iOS]
  int floor;

  /// 楼层名称 [Android, iOS]
  String floorName;

  /// 建筑物ID [Android, iOS]
  String poiId;

  IndoorData({
    this.floor,
    this.floorName,
    this.poiId,
  });

  IndoorData.fromJson(Map<String, dynamic> json) {
    floor = json['floor'] as int;
    floorName = json['floorName'] as String;
    poiId = json['poiId'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['floor'] = this.floor;
    data['floorName'] = this.floorName;
    data['poiId'] = this.poiId;
    return data;
  }

  IndoorData copyWith({
    int floor,
    String floorName,
    String poiId,
  }) {
    return IndoorData(
      floor: floor ?? this.floor,
      floorName: floorName ?? this.floorName,
      poiId: poiId ?? this.poiId,
    );
  }

  @override
  String toString() {
    return '''IndoorData{
		floor: $floor,
		floorName: $floorName,
		poiId: $poiId}''';
  }
}

class Photo {
  /// 标题 [Android, iOS]
  String title;

  /// url [Android, iOS]
  String url;

  Photo({
    this.title,
    this.url,
  });

  Photo.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String;
    url = json['url'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }

  Photo copyWith({
    String title,
    String url,
  }) {
    return Photo(
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Photo &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          url == other.url;

  @override
  int get hashCode => title.hashCode ^ url.hashCode;

  @override
  String toString() {
    return '''Photos{
		title: $title,
		url: $url}''';
  }
}

class PoiExtension {
  /// 营业时间 [Android, iOS]
  String opentime;

  /// 评分 [Android, iOS]
  String rating;

  /// 人均消费 [iOS]
  num cost;

  PoiExtension({
    this.opentime,
    this.rating,
    this.cost,
  });

  PoiExtension.fromJson(Map<String, dynamic> json) {
    opentime = json['opentime'] as String;
    rating = json['rating'] as String;
    cost = json['cost'] as num;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['opentime'] = this.opentime;
    data['rating'] = this.rating;
    data['cost'] = this.cost;
    return data;
  }

  PoiExtension copyWith({
    String opentime,
    String rating,
    double cost,
  }) {
    return PoiExtension(
      opentime: opentime ?? this.opentime,
      rating: rating ?? this.rating,
      cost: cost ?? this.cost,
    );
  }

  @override
  String toString() {
    return 'PoiExtension{opentime: $opentime, rating: $rating, cost: $cost}';
  }
}

class SubPoiItem {
  /// POI全局唯一ID [Android, iOS]
  String poiId;

  /// POI全称，如“北京大学(西2门)” [Android, iOS]
  String title;

  /// 子POI的子名称，如“西2门” [Android, iOS]
  String subName;

  /// 距中心点距离 [Android, iOS]
  int distance;

  /// 经纬度 [Android, iOS]
  LatLng latLonPoint;

  /// 地址 [Android, iOS]
  String snippet;

  /// 子POI类型 [Android, iOS]
  String subTypeDes;

  SubPoiItem.fromJson(Map<String, dynamic> json) {
    poiId = json['poiId'] as String;
    title = json['title'] as String;
    subName = json['subName'] as String;
    distance = json['distance'] as int;
    latLonPoint = LatLng.fromJson(json['latLonPoint'] as Map<String, Object>);
    snippet = json['snippet'] as String;
    subTypeDes = json['subTypeDes'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['poiId'] = this.poiId;
    data['title'] = this.title;
    data['subName'] = this.subName;
    data['distance'] = this.distance;
    data['latLonPoint'] = this.latLonPoint.toJson();
    data['snippet'] = this.snippet;
    data['subTypeDes'] = this.subTypeDes;
    return data;
  }

  @override
  String toString() {
    return 'SubPoiItem{poiId: $poiId, title: $title, subName: $subName, distance: $distance, latLonPoint: $latLonPoint, snippet: $snippet, subTypeDes: $subTypeDes}';
  }
}

class SuggestionCity {
  /// 城市名称 [Android, iOS]
  String cityName;

  /// 城市编码 [Android, iOS]
  String cityCode;

  /// 城市区域编码 [Android, iOS]
  String adCode;

  /// 此区域的建议结果数目 [Android, iOS]
  int suggestionNum;

  /// 途径区域 [iOS暂未实现]
  Object districts;

  SuggestionCity({
    this.cityName,
    this.cityCode,
    this.adCode,
    this.suggestionNum,
    this.districts,
  });

  SuggestionCity.fromJson(Map<String, Object> json) {
    cityName = json['cityName'] as String;
    cityCode = json['cityCode'] as String;
    adCode = json['adCode'] as String;
    suggestionNum = json['suggestionNum'] as int;
    districts = json['districts'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cityName'] = this.cityName;
    data['cityCode'] = this.cityCode;
    data['adCode'] = this.adCode;
    data['suggestionNum'] = this.suggestionNum;
    data['districts'] = this.districts;
    return data;
  }

  @override
  String toString() {
    return 'SuggestionCity{cityName: $cityName, cityCode: $cityCode, adCode: $adCode, suggestionNum: $suggestionNum, districts: $districts}';
  }
}

/// [Android]
class Query {
  String a;
  String c;
  int d;
  int e;
  String f;
  bool g;
  bool h;
  bool j;

  Query({
    this.a,
    this.c,
    this.d,
    this.e,
    this.f,
    this.g,
    this.h,
    this.j,
  });

  Query.fromJson(Map<String, dynamic> json) {
    a = json['a'] as String;
    c = json['c'] as String;
    d = json['d'] as int;
    e = json['e'] as int;
    f = json['f'] as String;
    g = json['g'] as bool;
    h = json['h'] as bool;
    j = json['j'] as bool;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['a'] = this.a;
    data['c'] = this.c;
    data['d'] = this.d;
    data['e'] = this.e;
    data['f'] = this.f;
    data['g'] = this.g;
    data['h'] = this.h;
    data['j'] = this.j;
    return data;
  }

  Query copyWith({
    String a,
    String c,
    int d,
    int e,
    String f,
    bool g,
    bool h,
    bool j,
  }) {
    return Query(
      a: a ?? this.a,
      c: c ?? this.c,
      d: d ?? this.d,
      e: e ?? this.e,
      f: f ?? this.f,
      g: g ?? this.g,
      h: h ?? this.h,
      j: j ?? this.j,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Query &&
          runtimeType == other.runtimeType &&
          a == other.a &&
          c == other.c &&
          d == other.d &&
          e == other.e &&
          f == other.f &&
          g == other.g &&
          h == other.h &&
          j == other.j;

  @override
  int get hashCode =>
      a.hashCode ^
      c.hashCode ^
      d.hashCode ^
      e.hashCode ^
      f.hashCode ^
      g.hashCode ^
      h.hashCode ^
      j.hashCode;

  @override
  String toString() {
    return '''Query{
		a: $a,
		c: $c,
		d: $d,
		e: $e,
		f: $f,
		g: $g,
		h: $h,
		j: $j}''';
  }
}
