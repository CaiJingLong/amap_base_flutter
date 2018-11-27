import 'package:amap_base/amap_flutter.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      body: AMapView(
        onAMapViewCreated: (controller) {
          controller.setMyLocationEnabled(
            true,
            style: MyLocationStyle(
              radiusFillColor: Colors.green,
              strokeColor: Colors.amberAccent,
              strokeWidth: 10,
            ),
          );
        },
        amapOptions: AMapOptions(),
      ),
    );
  }
}
