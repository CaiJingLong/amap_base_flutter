import 'package:amap_base/amap_base.dart';
import 'package:amap_base_example/utils/misc.dart';
import 'package:amap_base_example/utils/view.dart';
import 'package:amap_base_example/widgets/button.widget.dart';
import 'package:amap_base_example/widgets/dimens.dart';
import 'package:flutter/material.dart';

class DrivingRoutPlanScreen extends StatefulWidget {
  DrivingRoutPlanScreen();

  factory DrivingRoutPlanScreen.forDesignTime() => DrivingRoutPlanScreen();

  @override
  DrivingRoutPlanScreenState createState() => DrivingRoutPlanScreenState();
}

class DrivingRoutPlanScreenState extends State<DrivingRoutPlanScreen> {
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('驾车出行路线规划'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  setState(() {
                    _result = result.toString();
                  });
                }).catchError((e) => showError(context, e.toString()));
              },
            ),
            SPACE_NORMAL,
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[Text(_result)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
