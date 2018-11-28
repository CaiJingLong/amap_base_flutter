import 'package:amap_base_example/map/map.widget.dart';
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('创建地图', style: Theme.of(context).textTheme.headline),
              FlatButton(
                child: Text('显示地图', style: Theme.of(context).textTheme.subhead),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MapScreen()),
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
