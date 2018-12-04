import 'package:amap_base/amap_base.dart';
import 'package:flutter/material.dart';

const icon = 'images/amap_start.png';
const markerList = const [
  LatLng(39.992520, 116.336170),
  LatLng(39.992520, 116.336170),
  LatLng(39.998293, 116.352343),
  LatLng(40.004087, 116.348904),
  LatLng(40.004087, 116.348904),
  LatLng(39.989105, 116.353915),
  LatLng(39.998439, 116.360201),
];

class DrawPointScreen extends StatelessWidget {
  DrawPointScreen();

  factory DrawPointScreen.forDesignTime() => DrawPointScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('绘制点标记'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: AMapView(
        onAMapViewCreated: (controller) {
          controller.addMarkers(
            markerList
                .map((latLng) => MarkerOptions(
                      icon: icon,
                      position: latLng,
                      title: '哈哈',
                      snippet: '呵呵',
                    ))
                .toList(),
          );
//          controller.addMarker(MarkerOptions(
//            icon: icon,
//            position: LatLng(39.992520, 116.336170),
//            title: '哈哈',
//            snippet: '呵呵',
//          ));
        },
        amapOptions: AMapOptions(),
      ),
    );
  }
}
