import 'package:amap_base/amap_base.dart';
import 'package:amap_base_example/map/get_map_data/bound_poi_search.screen.dart';
import 'package:amap_base_example/map/get_map_data/id_poi_search.screen.dart';
import 'package:amap_base_example/map/get_map_data/polygon_poi_search.screen.dart';
import 'package:amap_base_example/map/get_map_data/route_poi_search.screen.dart';
import 'package:amap_base_example/map/interact_with_map/code_interaction.screen.dart';
import 'package:amap_base_example/map/paint_on_map/draw_point.screen.dart';
import 'package:amap_base_example/map/going_out_plan/driving_route_plan.screen.dart';
import 'package:amap_base_example/map/interact_with_map/control_interaction.screen.dart';
import 'package:amap_base_example/map/interact_with_map/gesture_interaction.screen.dart';
import 'package:amap_base_example/map/get_map_data/keyword_poi_search.screen.dart';
import 'package:amap_base_example/map/create_map/show_indoor_map.screen.dart';
import 'package:amap_base_example/map/create_map/show_map.screen.dart';
import 'package:amap_base_example/map/tools/coordinate_transformation_screen.dart';
import 'package:amap_base_example/widgets/dimens.dart';
import 'package:flutter/material.dart';

void main() async {
  // final result = await AMap.setKey('27d67839721288be2ddd87b4fd868822');
  final result = await AMap.setKey('27d67839721288be2ddd87b4fd868822');
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
              _FunctionItem(
                label: '调用方法交互',
                sublabel: 'CodeInteractionScreen',
                target: CodeInteractionScreen(),
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
                label: '关键字检索POI',
                sublabel: 'KeywordPoiSearchScreen',
                target: KeywordPoiSearchScreen(),
              ),
              _FunctionItem(
                label: '周边检索POI',
                sublabel: 'BoundPoiSearchScreen',
                target: BoundPoiSearchScreen(),
              ),
              _FunctionItem(
                label: '多边形内检索的POI',
                sublabel: 'PolygonPoiSearchScreen',
                target: PolygonPoiSearchScreen(),
              ),
              _FunctionItem(
                label: 'ID检索POI',
                sublabel: 'IdPoiSearchScreen',
                target: IdPoiSearchScreen(),
              ),
              _FunctionItem(
                label: '道路沿途检索POI',
                sublabel: 'RoutePoiSearchScreen',
                target: RoutePoiSearchScreen(),
              ),
            ],
          ),
          SPACE_BIG,
          _FunctionGroup(
            headLabel: "工具",
            children: <Widget>[
              _FunctionItem(
                label: "坐标转换",
                sublabel: "CoordinateTransformationScreen",
                target: CoordinateTransformationScreen(),
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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(headLabel, style: Theme.of(context).textTheme.headline),
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
