import 'package:amap_base/amap_base.dart';
import 'package:amap_base_example/widgets/setting.widget.dart';
import 'package:flutter/material.dart';

class DrivingRoutPlanScreen extends StatefulWidget {
  @override
  _DrivingRoutPlanScreenState createState() => _DrivingRoutPlanScreenState();
}

class _DrivingRoutPlanScreenState extends State<DrivingRoutPlanScreen> {
  AMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('驾车出行路线规划')),
      body: Column(
        children: <Widget>[
          Flexible(
            child: AMapView(
              onAMapViewCreated: (controller) {
                setState(() => _controller = controller
                  ..setMyLocationStyle(MyLocationStyle()));
              },
              amapOptions: AMapOptions(),
            ),
          ),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                TextSetting(
                  leadingString: '起点',
                  hintString: '输入经纬度 格式: 12.34,56.78',
                ),
                TextSetting(
                  leadingString: '终点',
                  hintString: '输入经纬度 格式: 12.34,56.78',
                ),
                TextSetting(
                  leadingString: '途径点',
                  hintString: '输入经纬度 格式: 12.34,56.78',
                ),
                TextSetting(
                  leadingString: '避让区域',
                  hintString: '输入经纬度 格式: 12.34,56.78',
                ),
                TextSetting(
                  leadingString: '避让道路',
                  hintString: '输入经纬度 格式: 12.34,56.78',
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {
                      _controller.calculateDriveRoute(RoutePlanParam(
                        from: LatLng(29.079208, 119.647229),
                        to: LatLng(29.05115, 119.641907),
                      ));
                    },
                    child: Text('开始规划'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
