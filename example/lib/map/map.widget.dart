import 'package:amap_base/amap_base.dart';
import 'package:amap_base_example/widgets/setting.widget.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  AMapController _controller;
  MyLocationStyle _myLocationStyle = MyLocationStyle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map')),
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
                  head: '显示自己的位置',
                  onSelected: _controller?.setMyLocationEnabled,
                ),
                ContinuousSetting(
                  head: '横坐标偏移量',
                  onChanged: (value) {
                    _updateMyLocationStyle(anchorU: value);
                  },
                ),
                ContinuousSetting(
                  head: '纵坐标偏移量',
                  onChanged: (value) {
                    _updateMyLocationStyle(anchorV: value);
                  },
                ),
                DiscreteSetting(
                  head: '圆形区域（以定位位置为圆心，定位半径的圆形区域）的填充颜色值',
                  options: ['绿色', '红色', '黄色'],
                  onSelected: (value) {
                    Color color;
                    switch (value) {
                      case '绿色':
                        color = Colors.green;
                        break;
                      case '红色':
                        color = Colors.red;
                        break;
                      case '黄色':
                        color = Colors.yellow;
                        break;
                    }
                    _updateMyLocationStyle(radiusFillColor: color);
                  },
                ),
                DiscreteSetting(
                  head: '圆形区域（以定位位置为圆心，定位半径的圆形区域）边框的颜色值',
                  options: ['绿色', '红色', '黄色'],
                  onSelected: (value) {
                    Color color;
                    switch (value) {
                      case '绿色':
                        color = Colors.green;
                        break;
                      case '红色':
                        color = Colors.red;
                        break;
                      case '黄色':
                        color = Colors.yellow;
                        break;
                    }
                    _updateMyLocationStyle(strokeColor: color);
                  },
                ),
                ContinuousSetting(
                  head: '圆形区域（以定位位置为圆心，定位半径的圆形区域）边框的宽度',
                  max: 50,
                  onChanged: (value) {
                    _updateMyLocationStyle(strokeWidth: value);
                  },
                ),
                DiscreteSetting(
                  head: '我的位置展示模式',
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
                        locationType = MyLocationStyle.LOCATION_TYPE_FOLLOW;
                        break;
                      case '定位、但不会移动到地图中心点，并且会跟随设备移动':
                        locationType =
                            MyLocationStyle.LOCATION_TYPE_FOLLOW_NO_CENTER;
                        break;
                      case '定位、且将视角移动到地图中心点':
                        locationType = MyLocationStyle.LOCATION_TYPE_LOCATE;
                        break;
                      case '定位、且将视角移动到地图中心点，定位点依照设备方向旋转，并且会跟随设备移动':
                        locationType =
                            MyLocationStyle.LOCATION_TYPE_LOCATION_ROTATE;
                        break;
                      case '定位、但不会移动到地图中心点，定位点依照设备方向旋转，并且会跟随设备移动':
                        locationType = MyLocationStyle
                            .LOCATION_TYPE_LOCATION_ROTATE_NO_CENTER;
                        break;
                      case '定位、且将视角移动到地图中心点，地图依照设备方向旋转，定位点会跟随设备移动':
                        locationType = MyLocationStyle.LOCATION_TYPE_MAP_ROTATE;
                        break;
                      case '定位、但不会移动到地图中心点，地图依照设备方向旋转，并且会跟随设备移动':
                        locationType =
                            MyLocationStyle.LOCATION_TYPE_MAP_ROTATE_NO_CENTER;
                        break;
                      case '只定位':
                        locationType = MyLocationStyle.LOCATION_TYPE_SHOW;
                        break;
                    }
                    _updateMyLocationStyle(myLocationType: locationType);
                  },
                ),
                Builder(
                  builder: (context) {
                    return ContinuousSetting(
                      head: '定位请求时间间隔, 单位毫秒',
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
                )
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
    );
    _controller.setMyLocationEnabled(
      true,
      style: _myLocationStyle,
    );
  }
}
