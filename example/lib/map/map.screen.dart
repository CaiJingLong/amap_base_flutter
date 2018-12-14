import 'package:amap_base_search/amap_base.dart';
import 'package:amap_base_example/map/create_map/show_indoor_map.screen.dart';
import 'package:amap_base_example/map/create_map/show_map.screen.dart';
import 'package:amap_base_example/map/create_map/switch_map_layer.screen.dart';
import 'package:amap_base_example/map/interact_with_map/code_interaction.screen.dart';
import 'package:amap_base_example/map/interact_with_map/control_interaction.screen.dart';
import 'package:amap_base_example/map/interact_with_map/gesture_interaction.screen.dart';
import 'package:amap_base_example/map/draw_on_map/draw_point.screen.dart';
import 'package:amap_base_example/map/draw_on_map/draw_polyline.screen.dart';
import 'package:amap_base_example/map/tools/coordinate_transformation_screen.dart';
import 'package:amap_base_example/widgets/dimens.dart';
import 'package:amap_base_example/widgets/function_group.widget.dart';
import 'package:amap_base_example/widgets/function_item.widget.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        FunctionGroup(
          headLabel: '创建地图',
          children: <Widget>[
            FunctionItem(
              label: '显示地图',
              sublabel: 'CreateMapScreen',
              target: ShowMapScreen(),
            ),
            FunctionItem(
              label: '显示室内地图',
              sublabel: 'ShowsIndoorMapScreen',
              target: ShowsIndoorMapScreen(),
            ),
            FunctionItem(
              label: '切换地图图层',
              sublabel: 'SwitchMapLayerScreen',
              target: SwitchMapLayerScreen(),
            ),
            Column(
              children: <Widget>[
                ListTile(
                  title: Text('使用离线地图'),
                  subtitle: Text('使用离线地图'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () => OfflineManager().openOfflineManager(),
                ),
                Divider(height: 1, indent: 16),
              ],
            ),
          ],
        ),
        SPACE_BIG,
        FunctionGroup(
          headLabel: '与地图交互',
          children: <Widget>[
            FunctionItem(
              label: '控件交互',
              sublabel: 'ControlInteractionScreen',
              target: ControlInteractionScreen(),
            ),
            FunctionItem(
              label: '手势交互',
              sublabel: 'GestureInteractionScreen',
              target: GestureInteractionScreen(),
            ),
            FunctionItem(
              label: '调用方法交互',
              sublabel: 'CodeInteractionScreen',
              target: CodeInteractionScreen(),
            ),
          ],
        ),
        SPACE_BIG,
        FunctionGroup(
          headLabel: '在地图上绘制',
          children: <Widget>[
            FunctionItem(
              label: '绘制点标记',
              sublabel: 'DrawPointScreen',
              target: DrawPointScreen(),
            ),
            FunctionItem(
              label: '绘制线',
              sublabel: 'DrawPolylineScreen',
              target: DrawPolylineScreen(),
            ),
          ],
        ),
        SPACE_BIG,
        FunctionGroup(
          headLabel: "工具",
          children: <Widget>[
            FunctionItem(
              label: "坐标转换",
              sublabel: "CoordinateTransformationScreen",
              target: CoordinateTransformationScreen(),
            ),
          ],
        ),
      ],
    );
  }
}
