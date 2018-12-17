import 'package:amap_base/amap_base.dart';

class GeocodeResult {
  List<GeocodeAddressList> geocodeAddressList;
  GeocodeQuery geocodeQuery;

  GeocodeResult({
    this.geocodeAddressList,
    this.geocodeQuery,
  });

  GeocodeResult.fromJson(Map<String, dynamic> json) {
    if (json['geocodeAddressList'] != null) {
      geocodeAddressList = List<GeocodeAddressList>();
      json['geocodeAddressList'].forEach((v) {
        geocodeAddressList
            .add(GeocodeAddressList.fromJson(v as Map<String, dynamic>));
      });
    }
    geocodeQuery = json['geocodeQuery'] != null
        ? GeocodeQuery.fromJson(json['geocodeQuery'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (this.geocodeAddressList != null) {
      data['geocodeAddressList'] =
          this.geocodeAddressList.map((v) => v.toJson()).toList();
    }
    if (this.geocodeQuery != null) {
      data['geocodeQuery'] = this.geocodeQuery.toJson();
    }
    return data;
  }

  GeocodeResult copyWith({
    List geocodeAddressList,
    GeocodeQuery geocodeQuery,
  }) {
    return GeocodeResult(
      geocodeAddressList: geocodeAddressList ?? this.geocodeAddressList,
      geocodeQuery: geocodeQuery ?? this.geocodeQuery,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeocodeResult &&
          runtimeType == other.runtimeType &&
          geocodeAddressList == other.geocodeAddressList &&
          geocodeQuery == other.geocodeQuery;

  @override
  int get hashCode => geocodeAddressList.hashCode ^ geocodeQuery.hashCode;

  @override
  String toString() {
    return '''GeocodeResult{
		geocodeAddressList: $geocodeAddressList,
		geocodeQuery: $geocodeQuery}''';
  }
}

class GeocodeAddressList {
  String adcode;
  String building;
  String city;
  String district;
  String formatAddress;
  LatLng latLng;
  String level;
  String neighborhood;
  String province;
  String township;

  GeocodeAddressList({
    this.adcode,
    this.building,
    this.city,
    this.district,
    this.formatAddress,
    this.latLng,
    this.level,
    this.neighborhood,
    this.province,
    this.township,
  });

  GeocodeAddressList.fromJson(Map<String, dynamic> json) {
    adcode = json['adcode'] as String;
    building = json['building'] as String;
    city = json['city'] as String;
    district = json['district'] as String;
    formatAddress = json['formatAddress'] as String;
    latLng = json['latLng'] != null ? LatLng.fromJson(json['latLng']) : null;
    level = json['level'] as String;
    neighborhood = json['neighborhood'] as String;
    province = json['province'] as String;
    township = json['township'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['adcode'] = this.adcode;
    data['building'] = this.building;
    data['city'] = this.city;
    data['district'] = this.district;
    data['formatAddress'] = this.formatAddress;
    if (this.latLng != null) {
      data['latLng'] = this.latLng.toJson();
    }
    data['level'] = this.level;
    data['neighborhood'] = this.neighborhood;
    data['province'] = this.province;
    data['township'] = this.township;
    return data;
  }

  GeocodeAddressList copyWith({
    String adcode,
    String building,
    String city,
    String district,
    String formatAddress,
    LatLng latLng,
    String level,
    String neighborhood,
    String province,
    String township,
  }) {
    return GeocodeAddressList(
      adcode: adcode ?? this.adcode,
      building: building ?? this.building,
      city: city ?? this.city,
      district: district ?? this.district,
      formatAddress: formatAddress ?? this.formatAddress,
      latLng: latLng ?? this.latLng,
      level: level ?? this.level,
      neighborhood: neighborhood ?? this.neighborhood,
      province: province ?? this.province,
      township: township ?? this.township,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeocodeAddressList &&
          runtimeType == other.runtimeType &&
          adcode == other.adcode &&
          building == other.building &&
          city == other.city &&
          district == other.district &&
          formatAddress == other.formatAddress &&
          latLng == other.latLng &&
          level == other.level &&
          neighborhood == other.neighborhood &&
          province == other.province &&
          township == other.township;

  @override
  int get hashCode =>
      adcode.hashCode ^
      building.hashCode ^
      city.hashCode ^
      district.hashCode ^
      formatAddress.hashCode ^
      latLng.hashCode ^
      level.hashCode ^
      neighborhood.hashCode ^
      province.hashCode ^
      township.hashCode;

  @override
  String toString() {
    return '''GeocodeAddressList{
		adcode: $adcode,
		building: $building,
		city: $city,
		district: $district,
		formatAddress: $formatAddress,
		latLng: $latLng,
		level: $level,
		neighborhood: $neighborhood,
		province: $province,
		township: $township}''';
  }
}

class GeocodeQuery {
  String city;
  String locationName;

  GeocodeQuery({
    this.city,
    this.locationName,
  });

  GeocodeQuery.fromJson(Map<String, dynamic> json) {
    city = json['city'] as String;
    locationName = json['locationName'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['city'] = this.city;
    data['locationName'] = this.locationName;
    return data;
  }

  GeocodeQuery copyWith({
    String city,
    String locationName,
  }) {
    return GeocodeQuery(
      city: city ?? this.city,
      locationName: locationName ?? this.locationName,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeocodeQuery &&
          runtimeType == other.runtimeType &&
          city == other.city &&
          locationName == other.locationName;

  @override
  int get hashCode => city.hashCode ^ locationName.hashCode;

  @override
  String toString() {
    return '''GeocodeQuery{
		city: $city,
		locationName: $locationName}''';
  }
}
