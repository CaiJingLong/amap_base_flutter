import 'package:amap_base_example/map/control_interaction.screen.dart';
import 'package:amap_base_example/map/show_map.screen.dart';
import 'package:amap_base_example/map/draw_point.screen.dart';
import 'package:amap_base_example/map/driving_route_plan.screen.dart';
import 'package:amap_base_example/map/gesture_interaction.screen.dart';
import 'package:amap_base_example/map/poi_search.screen.dart';
import 'package:amap_base_example/map/show_indoor_map.screen.dart';
import 'package:amap_base_example/navi/navi.dart';
import 'package:amap_base_example/widgets/dimens.dart';
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
      appBar: AppBar(
        title: const Text('AMaps examples'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade200,
      body: ListView(
        children: <Widget>[
          _FunctionGroup(
            headLabel: '创建地图',
            children: <Widget>[
              _FunctionItem(
                label: '显示地图',
                sublabel: 'CreateMapScreen',
                target: ShowMapScreen(),
              ),
              _FunctionItem(
                label: '显示室内地图',
                sublabel: 'ShowsIndoorMapScreen',
                target: ShowsIndoorMapScreen(),
              ),
            ],
          ),
          SPACE_BIG,
          _FunctionGroup(
            headLabel: '与地图交互',
            children: <Widget>[
              _FunctionItem(
                label: '控件交互',
                sublabel: 'ControlInteractionScreen',
                target: ControlInteractionScreen(),
              ),
              _FunctionItem(
                label: '手势交互',
                sublabel: 'GestureInteractionScreen',
                target: GestureInteractionScreen(),
              ),
            ],
          ),
          SPACE_BIG,
          _FunctionGroup(
            headLabel: '出行路线规划',
            children: <Widget>[
              _FunctionItem(
                label: '驾车出行路线规划',
                sublabel: 'DrivingRoutPlanScreen',
                target: DrivingRoutPlanScreen(),
              ),
            ],
          ),
          SPACE_BIG,
          _FunctionGroup(
            headLabel: '在地图上绘制',
            children: <Widget>[
              _FunctionItem(
                label: '绘制点标记',
                sublabel: 'DrawPointScreen',
                target: DrawPointScreen(),
              ),
            ],
          ),
          SPACE_BIG,
          _FunctionGroup(
            headLabel: '获取地图数据',
            children: <Widget>[
              _FunctionItem(
                label: '获取POI数据',
                sublabel: 'PoiSearchScreen',
                target: PoiSearchScreen(),
              ),
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
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(headLabel,
                    style: Theme.of(context).textTheme.headline),
              ),
              Divider(height: 1, indent: 16),
            ],
          ),
        ]..addAll(children),
      ),
    );
  }
}

class _FunctionItem extends StatelessWidget {
  const _FunctionItem({
    Key key,
    @required this.label,
    @required this.sublabel,
    @required this.target,
  }) : super(key: key);

  final String label;
  final String sublabel;
  final Widget target;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(label),
          subtitle: Text(sublabel),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => target),
            );
          },
        ),
        Divider(height: 1, indent: 16),
      ],
    );
  }
}
