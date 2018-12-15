import 'package:amap_base_example/location/location.screen.dart';
import 'package:amap_base_location/amap_base.dart';
import 'package:amap_base_example/map/map.screen.dart';
import 'package:amap_base_example/navi/navi.screen.dart';
import 'package:amap_base_example/widgets/dimens.dart';
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
        length: 3,
        child: Column(
          children: <Widget>[
            Flexible(
              child: TabBarView(children: [
                MapScreen(),
                LocationScreen(),
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
                  Text('定位', style: TextStyle(color: Colors.black)),
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
