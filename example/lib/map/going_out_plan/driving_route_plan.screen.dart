import 'package:amap_base_search/amap_base.dart';
import 'package:amap_base_example/utils/misc.dart';
import 'package:amap_base_example/utils/view.dart';
import 'package:amap_base_example/widgets/button.widget.dart';
import 'package:amap_base_example/widgets/dimens.dart';
import 'package:flutter/material.dart';

class DrivingRoutPlanScreen extends StatefulWidget {
  DrivingRoutPlanScreen();

  factory DrivingRoutPlanScreen.forDesignTime() => DrivingRoutPlanScreen();

  @override
  _DrivingRoutPlanScreenState createState() => _DrivingRoutPlanScreenState();
}

class _DrivingRoutPlanScreenState extends State<DrivingRoutPlanScreen> {
  AMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('驾车出行路线规划'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: AMapView(
              onAMapViewCreated: (controller) {
                setState(() => _controller = controller);
              },
              amapOptions: AMapOptions(),
            ),
          ),
          Flexible(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              shrinkWrap: true,
              children: <Widget>[
                Text('起点: 39.993291, 116.473188'),
                Text('终点: 39.940474, 116.355426'),
                SPACE_NORMAL,
                Button(
                  label: '开始规划',
                  onPressed: (context) {
                    loading(
                      context,
                      AMapSearch().calculateDriveRoute(
                        RoutePlanParam(
                          from: LatLng(39.993291, 116.473188),
                          to: LatLng(39.940474, 116.355426),
                        ),
                      ),
                    ).then((result) {
                      final allPoint = result.paths[0].steps
                          .expand((step) => step.polyline)
                          .toList();

                      result.paths[0].steps
                          .expand((step) => step.TMCs)
                          .forEach((tmc) {
                        _controller.addPolyline((PolylineOptions(
                          latLngList: tmc.polyline,
                          width: 15,
                          color: _getTmcColor(tmc.status),
                        )));
                      });

                      _controller.zoomToSpan(allPoint);
                    }).catchError((e) => showError(context, e.toString()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTmcColor(String tmc) {
    switch (tmc) {
      case '未知':
        return Colors.cyan;
      case '畅通':
        return Colors.green;
      case '缓行':
        return Colors.yellow;
      case '拥堵':
        return Colors.red;
      default:
        return Colors.cyan;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
