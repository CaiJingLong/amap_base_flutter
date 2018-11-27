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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            onPressed: () => AMapNavi.start(29.12, 119.64),
            child: Text('导航'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MapScreen()),
              );
            },
            child: Text('地图'),
          ),
        ],
      ),
    );
  }
}
