import 'package:amap_base/amap_base.dart';

class PoiResult {
  int pageCount;
  SearchBound bound;
  List<PoiItem> pois;
  Query query;
  List<SuggestionCity> searchSuggestionCitys;
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

class SearchBound {
  LatLng lowerLeft;
  LatLng upperRight;
  LatLng center;
  int range;
  String shape;
  bool isDistanceSort;
  List<LatLng> polyGonList;

  SearchBound({
    this.lowerLeft,
    this.upperRight,
    this.center,
    this.range,
    this.shape,
    this.isDistanceSort,
    this.polyGonList,
  });

  SearchBound.fromJson(Map<String, dynamic> json)
      : lowerLeft = json['lowerLeft'] != null
            ? LatLng.fromJson(json['lowerLeft'] as Map<String, Object>)
            : null,
        upperRight = json['upperRight'] != null
            ? LatLng.fromJson(json['upperRight'] as Map<String, Object>)
            : null,
        center = json['center'] != null
            ? LatLng.fromJson(json['center'] as Map<String, Object>)
            : null,
        range = json['range'] as int,
        shape = json['shape'] as String,
        isDistanceSort = json['isDistanceSort'] as bool {
    if (json['polyGonList'] != null) {
      polyGonList = List<LatLng>();
      json['polyGonList'].forEach((v) {
        polyGonList.add(LatLng.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lowerLeft'] = this.lowerLeft?.toJson();
    data['upperRight'] = this.upperRight?.toJson();
    data['center'] = this.center?.toJson();
    data['range'] = this.range;
    data['shape'] = this.shape;
    data['isDistanceSort'] = this.isDistanceSort;
    data['polyGonList'] = this.polyGonList?.map((it) => it.toJson());
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchBound &&
          runtimeType == other.runtimeType &&
          lowerLeft == other.lowerLeft &&
          upperRight == other.upperRight &&
          center == other.center &&
          range == other.range &&
          shape == other.shape &&
          isDistanceSort == other.isDistanceSort &&
          polyGonList == other.polyGonList;

  @override
  int get hashCode =>
      lowerLeft.hashCode ^
      upperRight.hashCode ^
      center.hashCode ^
      range.hashCode ^
      shape.hashCode ^
      isDistanceSort.hashCode ^
      polyGonList.hashCode;

  @override
  String toString() {
    return 'SearchBound{lowerLeft: $lowerLeft, upperRight: $upperRight, center: $center, range: $range, shape: $shape, isDistanceSort: $isDistanceSort, polyGonList: $polyGonList}';
  }
}

class PoiItem {
  String adCode;
  String adName;
  String businessArea;
  String cityCode;
  String cityName;
  String direction;
  int distance;
  String email;
  IndoorData indoorData;
  bool isIndoorMap;
  LatLng latLonPoint;
  String parkingType;
  List<Photos> photos;
  PoiExtension poiExtension;
  String poiId;
  String postcode;
  String provinceCode;
  String provinceName;
  String shopID;
  String snippet;
  List<SubPoiItem> subPois;
  String tel;
  String title;
  String typeCode;
  String typeDes;
  String website;

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
    parkingType = json['parkingType'] as String;
    if (json['photos'] != null) {
      photos = List<Photos>();
      json['photos'].forEach((v) {
        photos.add(Photos.fromJson(v as Map<String, dynamic>));
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
      subPois = List<Null>();
      json['subPois'].forEach((v) {
        subPois.add(SubPoiItem.fromJson(v as Map<String, dynamic>));
      });
    }
    tel = json['tel'] as String;
    title = json['title'] as String;
    typeCode = json['typeCode'] as String;
    typeDes = json['typeDes'] as String;
    website = json['website'] as String;
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
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PoiItem &&
          runtimeType == other.runtimeType &&
          adCode == other.adCode &&
          adName == other.adName &&
          businessArea == other.businessArea &&
          cityCode == other.cityCode &&
          cityName == other.cityName &&
          direction == other.direction &&
          distance == other.distance &&
          email == other.email &&
          indoorData == other.indoorData &&
          isIndoorMap == other.isIndoorMap &&
          latLonPoint == other.latLonPoint &&
          parkingType == other.parkingType &&
          photos == other.photos &&
          poiExtension == other.poiExtension &&
          poiId == other.poiId &&
          postcode == other.postcode &&
          provinceCode == other.provinceCode &&
          provinceName == other.provinceName &&
          shopID == other.shopID &&
          snippet == other.snippet &&
          subPois == other.subPois &&
          tel == other.tel &&
          title == other.title &&
          typeCode == other.typeCode &&
          typeDes == other.typeDes &&
          website == other.website;

  @override
  int get hashCode =>
      adCode.hashCode ^
      adName.hashCode ^
      businessArea.hashCode ^
      cityCode.hashCode ^
      cityName.hashCode ^
      direction.hashCode ^
      distance.hashCode ^
      email.hashCode ^
      indoorData.hashCode ^
      isIndoorMap.hashCode ^
      latLonPoint.hashCode ^
      parkingType.hashCode ^
      photos.hashCode ^
      poiExtension.hashCode ^
      poiId.hashCode ^
      postcode.hashCode ^
      provinceCode.hashCode ^
      provinceName.hashCode ^
      shopID.hashCode ^
      snippet.hashCode ^
      subPois.hashCode ^
      tel.hashCode ^
      title.hashCode ^
      typeCode.hashCode ^
      typeDes.hashCode ^
      website.hashCode;

  @override
  String toString() {
    return '''Pois{
		adCode: $adCode,
		adName: $adName,
		businessArea: $businessArea,
		cityCode: $cityCode,
		cityName: $cityName,
		direction: $direction,
		distance: $distance,
		email: $email,
		indoorData: $indoorData,
		isIndoorMap: $isIndoorMap,
		latLonPoint: $latLonPoint,
		parkingType: $parkingType,
		photos: $photos,
		poiExtension: $poiExtension,
		poiId: $poiId,
		postcode: $postcode,
		provinceCode: $provinceCode,
		provinceName: $provinceName,
		shopID: $shopID,
		snippet: $snippet,
		subPois: $subPois,
		tel: $tel,
		title: $title,
		typeCode: $typeCode,
		typeDes: $typeDes,
		website: $website}''';
  }
}

class IndoorData {
  int floor;
  String floorName;
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndoorData &&
          runtimeType == other.runtimeType &&
          floor == other.floor &&
          floorName == other.floorName &&
          poiId == other.poiId;

  @override
  int get hashCode => floor.hashCode ^ floorName.hashCode ^ poiId.hashCode;

  @override
  String toString() {
    return '''IndoorData{
		floor: $floor,
		floorName: $floorName,
		poiId: $poiId}''';
  }
}

class Photos {
  String title;
  String url;

  Photos({
    this.title,
    this.url,
  });

  Photos.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String;
    url = json['url'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }

  Photos copyWith({
    String title,
    String url,
  }) {
    return Photos(
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Photos &&
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
  String opentime;
  String rating;

  PoiExtension({
    this.opentime,
    this.rating,
  });

  PoiExtension.fromJson(Map<String, dynamic> json) {
    opentime = json['opentime'] as String;
    rating = json['rating'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['opentime'] = this.opentime;
    data['rating'] = this.rating;
    return data;
  }

  PoiExtension copyWith({
    String opentime,
    String rating,
  }) {
    return PoiExtension(
      opentime: opentime ?? this.opentime,
      rating: rating ?? this.rating,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PoiExtension &&
          runtimeType == other.runtimeType &&
          opentime == other.opentime &&
          rating == other.rating;

  @override
  int get hashCode => opentime.hashCode ^ rating.hashCode;

  @override
  String toString() {
    return '''PoiExtension{
		opentime: $opentime,
		rating: $rating}''';
  }
}

class SubPoiItem {
  String poiId;
  String title;
  String subName;
  int distance;
  LatLng latLonPoint;
  String snippet;
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubPoiItem &&
          runtimeType == other.runtimeType &&
          poiId == other.poiId &&
          title == other.title &&
          subName == other.subName &&
          distance == other.distance &&
          latLonPoint == other.latLonPoint &&
          snippet == other.snippet &&
          subTypeDes == other.subTypeDes;

  @override
  int get hashCode =>
      poiId.hashCode ^
      title.hashCode ^
      subName.hashCode ^
      distance.hashCode ^
      latLonPoint.hashCode ^
      snippet.hashCode ^
      subTypeDes.hashCode;

  @override
  String toString() {
    return 'SubPoiItem{poiId: $poiId, title: $title, subName: $subName, distance: $distance, latLonPoint: $latLonPoint, snippet: $snippet, subTypeDes: $subTypeDes}';
  }
}

class SuggestionCity {
  String cityName;
  String cityCode;
  String adCode;
  int suggestionNum;

  SuggestionCity({
    this.cityName,
    this.cityCode,
    this.adCode,
    this.suggestionNum,
  });

  SuggestionCity.fromJson(Map<String, Object> json) {
    cityName = json['cityName'] as String;
    cityCode = json['cityCode'] as String;
    adCode = json['adCode'] as String;
    suggestionNum = json['suggestionNum'] as int;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cityName'] = this.cityName;
    data['cityCode'] = this.cityCode;
    data['adCode'] = this.adCode;
    data['suggestionNum'] = this.suggestionNum;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SuggestionCity &&
          runtimeType == other.runtimeType &&
          cityName == other.cityName &&
          cityCode == other.cityCode &&
          adCode == other.adCode &&
          suggestionNum == other.suggestionNum;

  @override
  int get hashCode =>
      cityName.hashCode ^
      cityCode.hashCode ^
      adCode.hashCode ^
      suggestionNum.hashCode;

  @override
  String toString() {
    return 'SuggestionCity{cityName: $cityName, cityCode: $cityCode, adCode: $adCode, suggestionNum: $suggestionNum}';
  }
}

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
