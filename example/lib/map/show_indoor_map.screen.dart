import 'package:amap_base/amap_base.dart';
import 'package:flutter/material.dart';

class ShowsIndoorMapScreen extends StatelessWidget {
  ShowsIndoorMapScreen();

  factory ShowsIndoorMapScreen.forDesignTime() => ShowsIndoorMapScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('显示室内地图'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: AMapView(
        onAMapViewCreated: (controller) {
          controller.showIndoorMap(true);
        },
        amapOptions: AMapOptions(),
      ),
    );
  }
}
