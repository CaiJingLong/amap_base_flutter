import 'package:amap_base_example/map/control_interaction.screen.dart';
import 'package:amap_base_example/map/create_map.screen.dart';
import 'package:amap_base_example/map/draw_point.screen.dart';
import 'package:amap_base_example/map/driving_route_plan.screen.dart';
import 'package:amap_base_example/map/gesture_interaction.screen.dart';
import 'package:amap_base_example/map/show_indoor_map.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp(home: MapsDemo()));
}

class MapsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AMaps examples')),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('创建地图', style: Theme.of(context).textTheme.headline),
                FlatButton(
                  child:
                      Text('显示地图', style: Theme.of(context).textTheme.subhead),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CreateMapScreen()),
                    );
                  },
                ),
                FlatButton(
                  child: Text(
                    '显示室内地图',
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ShowsIndoorMapScreen()),
                    );
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('与地图交互', style: Theme.of(context).textTheme.headline),
                FlatButton(
                  child:
                      Text('控件交互', style: Theme.of(context).textTheme.subhead),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ControlInteractionScreen(),
                      ),
                    );
                  },
                ),
                FlatButton(
                  child:
                      Text('手势交互', style: Theme.of(context).textTheme.subhead),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GestureInteractionScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('出行路线规划', style: Theme.of(context).textTheme.headline),
                FlatButton(
                  child: Text(
                    '驾车出行路线规划',
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DrivingRoutPlanScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('在地图上绘制', style: Theme.of(context).textTheme.headline),
                FlatButton(
                  child: Text(
                    '绘制点标记',
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DrawPointScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
