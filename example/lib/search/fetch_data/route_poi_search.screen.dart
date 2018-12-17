import 'package:amap_base/amap_base.dart';
import 'package:amap_base_example/utils/misc.dart';
import 'package:amap_base_example/utils/view.dart';
import 'package:amap_base_example/widgets/button.widget.dart';
import 'package:amap_base_example/widgets/dimens.dart';
import 'package:flutter/material.dart';

class RoutePoiSearchScreen extends StatefulWidget {
  RoutePoiSearchScreen();

  factory RoutePoiSearchScreen.forDesignTime() => RoutePoiSearchScreen();

  @override
  _RoutePoiSearchScreenState createState() => _RoutePoiSearchScreenState();
}

class _RoutePoiSearchScreenState extends State<RoutePoiSearchScreen> {
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('道路沿途检索POI'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Text(
              '出发点: LatLng(39.993291, 116.473188),\n终点: LatLng(39.940474, 116.355426)',
              textAlign: TextAlign.center,
            ),
            SPACE_NORMAL,
            Button(
              label: '开始搜索',
              onPressed: (context) async {
                if (!Form.of(context).validate()) {
                  return;
                }

                loading(
                  context,
                  AMapSearch().searchRoutePoiLine(
                    RoutePoiSearchQuery.line(
                      from: LatLng(39.993291, 116.473188),
                      to: LatLng(39.940474, 116.355426),
                      searchType: 0,
                    ),
                  ),
                ).then((routePoiResult) {
                  setState(() {
                    _result = jsonFormat(routePoiResult.toJson());
                  });
                }).catchError((e) => showError(context, e.toString()));
              },
            ),
            SPACE_NORMAL,
            Text(_result),
          ],
        ),
      ),
    );
  }
}
