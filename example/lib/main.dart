import 'package:amap_base_example/map/control_interaction.screen.dart';
import 'package:amap_base_example/map/create_map.screen.dart';
import 'package:amap_base_example/map/draw_point.screen.dart';
import 'package:amap_base_example/map/driving_route_plan.screen.dart';
import 'package:amap_base_example/map/gesture_interaction.screen.dart';
import 'package:amap_base_example/map/poi_search.screen.dart';
import 'package:amap_base_example/map/show_indoor_map.screen.dart';
import 'package:amap_base_example/navi/navi.dart';
import 'package:flutter/material.dart';

void main() async {
  final result = await AMapNavi.setKey('27d67839721288be2ddd87b4fd868822');
  print('设置key的结果: $result');
  runApp(MaterialApp(home: MapsDemo()));
}

class MapsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AMaps examples')),
      body: ListView(
        children: <Widget>[
          _FunctionGroup(
            headLabel: '创建地图',
            children: <Widget>[
              _FunctionItem(label: '显示地图', target: CreateMapScreen()),
              _FunctionItem(label: '显示室内地图', target: ShowsIndoorMapScreen()),
            ],
          ),
          _FunctionGroup(
            headLabel: '与地图交互',
            children: <Widget>[
              _FunctionItem(label: '控件交互', target: ControlInteractionScreen()),
              _FunctionItem(label: '手势交互', target: GestureInteractionScreen()),
            ],
          ),
          _FunctionGroup(
            headLabel: '出行路线规划',
            children: <Widget>[
              _FunctionItem(label: '驾车出行路线规划', target: DrivingRoutPlanScreen()),
            ],
          ),
          _FunctionGroup(
            headLabel: '在地图上绘制',
            children: <Widget>[
              _FunctionItem(label: '绘制点标记', target: DrawPointScreen()),
            ],
          ),
          _FunctionGroup(
            headLabel: '获取地图数据',
            children: <Widget>[
              _FunctionItem(label: '获取POI数据', target: PoiSearchScreen()),
            ],
          ),
        ],
      ),
    );
  }
}

class _FunctionGroup extends StatelessWidget {
  const _FunctionGroup({
    Key key,
    @required this.headLabel,
    this.children = const [],
  }) : super(key: key);

  final String headLabel;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(headLabel, style: Theme.of(context).textTheme.headline),
        ]..addAll(children),
      ),
    );
  }
}

class _FunctionItem extends StatelessWidget {
  const _FunctionItem({
    Key key,
    @required this.label,
    @required this.target,
  }) : super(key: key);

  final String label;
  final Widget target;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(label, style: Theme.of(context).textTheme.subhead),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => target),
        );
      },
    );
  }
}
