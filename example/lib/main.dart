import 'package:amap_base/amap_base.dart';
import 'package:amap_base_example/map/get_map_data/bound_poi_search.screen.dart';
import 'package:amap_base_example/map/get_map_data/id_poi_search.screen.dart';
import 'package:amap_base_example/map/get_map_data/polygon_poi_search.screen.dart';
import 'package:amap_base_example/map/get_map_data/route_poi_search.screen.dart';
import 'package:amap_base_example/map/interact_with_map/code_interaction.screen.dart';
import 'package:amap_base_example/map/map.screen.dart';
import 'package:amap_base_example/map/paint_on_map/draw_point.screen.dart';
import 'package:amap_base_example/map/going_out_plan/driving_route_plan.screen.dart';
import 'package:amap_base_example/map/interact_with_map/control_interaction.screen.dart';
import 'package:amap_base_example/map/interact_with_map/gesture_interaction.screen.dart';
import 'package:amap_base_example/map/get_map_data/keyword_poi_search.screen.dart';
import 'package:amap_base_example/map/create_map/show_indoor_map.screen.dart';
import 'package:amap_base_example/map/create_map/show_map.screen.dart';
import 'package:amap_base_example/map/tools/coordinate_transformation_screen.dart';
import 'package:amap_base_example/navi/navi.screen.dart';
import 'package:amap_base_example/widgets/dimens.dart';
import 'package:amap_base_example/widgets/function_group.widget.dart';
import 'package:amap_base_example/widgets/function_item.widget.dart';
import 'package:flutter/material.dart';

void main() async {
  await AMap.init('27d67839721288be2ddd87b4fd868822');
  runApp(MaterialApp(home: LauncherScreen()));
}

class LauncherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AMaps examples'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade200,
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Flexible(
              child: TabBarView(children: [
                MapScreen(),
                NaviScreen(),
              ]),
            ),
            SPACE_TINY,
            Container(
              color: Colors.white,
              height: 48,
              child: TabBar(
                tabs: [
                  Text('地图', style: TextStyle(color: Colors.black)),
                  Text('导航', style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
