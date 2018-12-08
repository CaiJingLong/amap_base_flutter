import 'package:amap_base/amap_base.dart';
import 'package:amap_base_example/utils/misc.dart';
import 'package:amap_base_example/utils/view.dart';
import 'package:flutter/material.dart';

const markerList = const [
  LatLng(39.992520, 116.336170),
  LatLng(39.992520, 116.336170),
  LatLng(39.998293, 116.352343),
  LatLng(40.004087, 116.348904),
  LatLng(40.004087, 116.348904),
  LatLng(39.989105, 116.353915),
  LatLng(39.998439, 116.360201),
];

class DrawPointScreen extends StatefulWidget {
  DrawPointScreen();

  factory DrawPointScreen.forDesignTime() => DrawPointScreen();

  @override
  DrawPointScreenState createState() => DrawPointScreenState();
}

class DrawPointScreenState extends State<DrawPointScreen> {
  AMapController _controller;

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
          _controller = controller;
          _controller.markerClickedEvent.listen(print);
          loading(
            context,
            controller.addMarkers(
              markerList
                  .map((latLng) => MarkerOptions(
                        position: latLng,
                        title: '哈哈',
                        snippet: '呵呵',
                      ))
                  .toList(),
            ),
          ).catchError((e) => showError(context, e.toString()));
        },
        amapOptions: AMapOptions(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
