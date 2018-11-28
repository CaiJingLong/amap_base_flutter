import 'package:amap_base_example/map/control_interaction.screen.dart';
import 'package:amap_base_example/map/create_map.screen.dart';
import 'package:amap_base_example/navi/navi.dart';
import 'package:flutter/material.dart';
import 'package:framework/framework.dart';

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
          DecoratedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            padding: EdgeInsets.all(kSpaceLittleBig),
            children: <Widget>[
              Text('创建地图', style: Theme.of(context).textTheme.headline),
              FlatButton(
                child: Text('显示地图', style: Theme.of(context).textTheme.subhead),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CreateMapScreen()),
                  );
                },
              ),
            ],
          ),
          DecoratedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            padding: EdgeInsets.all(kSpaceLittleBig),
            children: <Widget>[
              Text('与地图交互', style: Theme.of(context).textTheme.headline),
              FlatButton(
                child: Text('控件交互', style: Theme.of(context).textTheme.subhead),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ControlInteractionScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
