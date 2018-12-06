import 'package:amap_base/amap_base.dart';
import 'package:amap_base_example/widgets/setting.widget.dart';
import 'package:flutter/material.dart';

class ShowMapScreen extends StatefulWidget {
  ShowMapScreen();

  factory ShowMapScreen.forDesignTime() => ShowMapScreen();

  @override
  _ShowMapScreenState createState() => _ShowMapScreenState();
}

class _ShowMapScreenState extends State<ShowMapScreen> {
  AMapController _controller;
  MyLocationStyle _myLocationStyle = MyLocationStyle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('显示地图'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: AMapView(
              onAMapViewCreated: (controller) {
                setState(() => _controller = controller);
              },
              amapOptions: AMapOptions(),
            ),
          ),
          Flexible(
            child: ListView(
              children: <Widget>[
                BooleanSetting(
                  head: '显示自己的位置 [Android, iOS]',
                  selected: false,
                  onSelected: (value) {
                    _updateMyLocationStyle(showMyLocation: value);
                  },
                ),
                ContinuousSetting(
                  head: '横坐标偏移量 [Android]',
                  onChanged: (value) {
                    _updateMyLocationStyle(anchorU: value);
                  },
                ),
                ContinuousSetting(
                  head: '纵坐标偏移量 [Android]',
                  onChanged: (value) {
                    _updateMyLocationStyle(anchorV: value);
                  },
                ),
                ColorSetting(
                  head: '圆形区域（以定位位置为圆心，定位半径的圆形区域）的填充颜色值 [Android, iOS]',
                  onSelected: (color) {
                    _updateMyLocationStyle(radiusFillColor: color);
                  },
                ),
                ColorSetting(
                  head: '圆形区域（以定位位置为圆心，定位半径的圆形区域）边框的颜色值 [Android, iOS]',
                  onSelected: (color) {
                    _updateMyLocationStyle(strokeColor: color);
                  },
                ),
                ContinuousSetting(
                  head: '圆形区域（以定位位置为圆心，定位半径的圆形区域）边框的宽度 [Android, iOS]',
                  max: 50,
                  onChanged: (value) {
                    _updateMyLocationStyle(strokeWidth: value);
                  },
                ),
                DiscreteSetting(
                  head: '我的位置展示模式 [Android]',
                  options: [
                    '定位、且将视角移动到地图中心点，定位点跟随设备移动',
                    '定位、但不会移动到地图中心点，并且会跟随设备移动',
                    '定位、且将视角移动到地图中心点',
                    '定位、且将视角移动到地图中心点，定位点依照设备方向旋转，并且会跟随设备移动',
                    '定位、但不会移动到地图中心点，定位点依照设备方向旋转，并且会跟随设备移动',
                    '定位、且将视角移动到地图中心点，地图依照设备方向旋转，定位点会跟随设备移动',
                    '定位、但不会移动到地图中心点，地图依照设备方向旋转，并且会跟随设备移动',
                    '只定位',
                  ],
                  onSelected: (value) {
                    int locationType;
                    switch (value) {
                      case '定位、且将视角移动到地图中心点，定位点跟随设备移动':
                        locationType = LOCATION_TYPE_FOLLOW;
                        break;
                      case '定位、但不会移动到地图中心点，并且会跟随设备移动':
                        locationType = LOCATION_TYPE_FOLLOW_NO_CENTER;
                        break;
                      case '定位、且将视角移动到地图中心点':
                        locationType = LOCATION_TYPE_LOCATE;
                        break;
                      case '定位、且将视角移动到地图中心点，定位点依照设备方向旋转，并且会跟随设备移动':
                        locationType = LOCATION_TYPE_LOCATION_ROTATE;
                        break;
                      case '定位、但不会移动到地图中心点，定位点依照设备方向旋转，并且会跟随设备移动':
                        locationType = LOCATION_TYPE_LOCATION_ROTATE_NO_CENTER;
                        break;
                      case '定位、且将视角移动到地图中心点，地图依照设备方向旋转，定位点会跟随设备移动':
                        locationType = LOCATION_TYPE_MAP_ROTATE;
                        break;
                      case '定位、但不会移动到地图中心点，地图依照设备方向旋转，并且会跟随设备移动':
                        locationType = LOCATION_TYPE_MAP_ROTATE_NO_CENTER;
                        break;
                      case '只定位':
                        locationType = LOCATION_TYPE_SHOW;
                        break;
                    }
                    _updateMyLocationStyle(myLocationType: locationType);
                  },
                ),
                Builder(
                  builder: (context) {
                    return ContinuousSetting(
                      head: '定位请求时间间隔, 单位毫秒 [Android]',
                      max: 5,
                      onChanged: (value) {
                        _updateMyLocationStyle(interval: value.round() * 1000);

                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('定位间隔${value.round()}秒'),
                          duration: Duration(seconds: 1),
                        ));
                      },
                    );
                  },
                ),
                BooleanSetting(
                  head: '精度圈是否显示 [iOS]',
                  selected: _myLocationStyle.showsAccuracyRing,
                  onSelected: (value) {
                    _updateMyLocationStyle(showsAccuracyRing: value);
                  },
                ),
                BooleanSetting(
                  head: '是否显示方向指示 [iOS]',
                  selected: _myLocationStyle.showsHeadingIndicator,
                  onSelected: (value) {
                    _updateMyLocationStyle(showsHeadingIndicator: value);
                  },
                ),
                ColorSetting(
                  head: '定位点背景色，不设置默认白色 [iOS]',
                  onSelected: (value) {
                    _updateMyLocationStyle(locationDotBgColor: value);
                  },
                ),
                ColorSetting(
                  head: '定位点蓝色圆点颜色，不设置默认蓝色 [iOS]',
                  onSelected: (value) {
                    _updateMyLocationStyle(locationDotFillColor: value);
                  },
                ),
                BooleanSetting(
                  head: '内部蓝色圆点是否使用律动效果, 默认YES [iOS]',
                  selected: _myLocationStyle.enablePulseAnnimation,
                  onSelected: (value) {
                    _updateMyLocationStyle(enablePulseAnnimation: value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _updateMyLocationStyle({
    String myLocationIcon,
    double anchorU,
    double anchorV,
    Color radiusFillColor,
    Color strokeColor,
    double strokeWidth,
    int myLocationType,
    int interval,
    bool showMyLocation,
    bool showsAccuracyRing,
    bool showsHeadingIndicator,
    Color locationDotBgColor,
    Color locationDotFillColor,
    bool enablePulseAnnimation,
    String image,
  }) {
    _myLocationStyle = _myLocationStyle.copyWith(
      myLocationIcon: myLocationIcon,
      anchorU: anchorU,
      anchorV: anchorV,
      radiusFillColor: radiusFillColor,
      strokeColor: strokeColor,
      strokeWidth: strokeWidth,
      myLocationType: myLocationType,
      interval: interval,
      showMyLocation: showMyLocation,
      showsAccuracyRing: showsAccuracyRing,
      showsHeadingIndicator: showsHeadingIndicator,
      locationDotBgColor: locationDotBgColor,
      locationDotFillColor: locationDotFillColor,
      enablePulseAnnimation: enablePulseAnnimation,
      image: image,
    );
    _controller.setMyLocationStyle(_myLocationStyle);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
