import 'dart:convert';

class LocationClientOptions {
  /// 是否允许模拟位置
  /// 从3.4.0开始，默认值为true，允许模拟;
  /// 3.4.0之前的版本，默认值为false，不允许模拟
  final bool isMockEnable;

  /// 发起定位请求的时间间隔 默认值：2000毫秒
  final int interval;

  /// 是否单次单次定位
  /// 默认值：false
  final bool isOnceLocation;

  /// 是否需要地址信息
  /// 默认值：true 返回地址信息
  /// 2.9.0之前的版本定位类型为AMapLocation.LOCATION_TYPE_GPS时不会返回地址信息
  /// 自2.9.0版本开始，当类型为AMapLocation.LOCATION_TYPE_GPS时也可以返回地址信息(需要网络通畅，第一次有可能没有地址信息返回）
  final bool isNeedAddress;

  /// 是否允许主动调用WIFI刷新
  final bool isWifiScan;

  /// 定位模式 默认值：Hight_Accuracy 高精度模式
  final LocationMode locationMode;

  /// 定位协议 默认值：HTTP http协议
  final LocationProtocol locationProtocol;

  /// 退出时是否杀死进程
  /// 默认值:false, 不杀死
  /// 注意：如果设置为true，并且配置的service不是remote的则会杀死当前页面进程，请慎重使用
  final bool isKillProcess;

  /// 高精度模式下单次定位是否优先返回卫星定位信息
  /// 默认值：false
  /// 只有在单次定位高精度定位模式下有效
  /// 为true时，会等待卫星定位结果返回，最多等待30秒，若30秒后仍无卫星定位结果返回，返回网络定位结果
  final bool isGpsFirst;

  /// 联网超时时间 单位：毫秒 默认值：30000毫秒
  final int httpTimeOut;
  final bool isOffset;

  /// 是否使用缓存策略, 默认为true 使用缓存策略
  final bool isLocationCacheEnable;

  /// 定位是否等待WIFI列表刷新 定位精度会更高，但是定位速度会变慢1-3秒 从3.7.0版本开始，
  /// 支持连续定位（连续定位时首次会等待刷新） 3.7.0之前的版本，仅适用于单次定位，当设置为true时，连续定位会自动变为单次定位,
  final bool isOnceLocationLatest;
  final bool isSensorEnable;
  final int lastLocationLifeCycle;

  /// 逆地理信息的语言,目前之中中文和英文
  final GeoLanguage geoLanguage;
  final bool isDownloadCoordinateConvertLibrary;
  final double deviceModeDistanceFilter;

  /// 定位场景
  final AMapLocationPurpose locationPurpose;

  /// 是否开启始终wifi扫描 只有设置了android.permission.WRITE_SECURE_SETTINGS权限后才会开启
  /// 开启后，即使关闭wifi开关的情况下也会扫描wifi 默认值为：true, 开启wifi始终扫描
  final bool isOpenAlwaysScanWifi;
  final int scanWifiInterval;

  LocationClientOptions({
    this.isMockEnable = true,
    this.interval = 2000,
    this.isOnceLocation = false,
    this.isNeedAddress = true,
    this.isWifiScan = true,
    this.locationMode = LocationMode.Hight_Accuracy,
    this.locationProtocol = LocationProtocol.HTTP,
    this.isKillProcess = false,
    this.isGpsFirst = false,
    this.httpTimeOut = 30000,
    this.isOffset = true,
    this.isLocationCacheEnable = true,
    this.isOnceLocationLatest = false,
    this.isSensorEnable = false,
    this.lastLocationLifeCycle = 30000,
    this.geoLanguage = GeoLanguage.ZH,
    this.isDownloadCoordinateConvertLibrary,
    this.deviceModeDistanceFilter = 0.0,
    this.locationPurpose, // 可以为空
    this.isOpenAlwaysScanWifi = true,
    this.scanWifiInterval = 30000,
  });

  Map<String, Object> toJson() {
    return {
      'isMockEnable': isMockEnable,
      'interval': interval,
      'isOnceLocation': isOnceLocation,
      'isNeedAddress': isNeedAddress,
      'isWifiScan': isWifiScan,
      'locationMode': locationMode.index,
      'locationProtocol': locationProtocol.index,
      'isKillProcess': isKillProcess,
      'isGpsFirst': isGpsFirst,
      'httpTimeOut': httpTimeOut,
      'isOffset': isOffset,
      'isLocationCacheEnable': isLocationCacheEnable,
      'isOnceLocationLatest': isOnceLocationLatest,
      'isSensorEnable': isSensorEnable,
      'lastLocationLifeCycle': lastLocationLifeCycle,
      'geoLanguage': geoLanguage.index,
      'isDownloadCoordinateConvertLibrary': isDownloadCoordinateConvertLibrary,
      'deviceModeDistanceFilter': deviceModeDistanceFilter,
      'locationPurpose': locationPurpose?.index,
      'isOpenAlwaysScanWifi': isOpenAlwaysScanWifi,
      'scanWifiInterval': scanWifiInterval,
    };
  }

  String toJsonString() => jsonEncode(toJson());

  @override
  String toString() {
    return 'LocationClientOptions{isMockEnable: $isMockEnable, interval: $interval, isOnceLocation: $isOnceLocation, isNeedAddress: $isNeedAddress, isWifiScan: $isWifiScan, locationMode: $locationMode, locationProtocol: $locationProtocol, isKillProcess: $isKillProcess, isGpsFirst: $isGpsFirst, httpTimeOut: $httpTimeOut, isOffset: $isOffset, isLocationCacheEnable: $isLocationCacheEnable, isOnceLocationLatest: $isOnceLocationLatest, isSensorEnable: $isSensorEnable, lastLocationLifeCycle: $lastLocationLifeCycle, geoLanguage: $geoLanguage, isDownloadCoordinateConvertLibrary: $isDownloadCoordinateConvertLibrary, deviceModeDistanceFilter: $deviceModeDistanceFilter, locationPurpose: $locationPurpose, isOpenAlwaysScanWifi: $isOpenAlwaysScanWifi, scanWifiInterval: $scanWifiInterval}';
  }
}

enum LocationProtocol { HTTP, HTTPS }
enum LocationMode { Battery_Saving, Device_Sensors, Hight_Accuracy }
enum GeoLanguage { DEFAULT, ZH, EN }
enum AMapLocationPurpose { SignIn, Transport, Sport }
