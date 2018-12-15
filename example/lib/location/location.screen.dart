import 'package:amap_base_location/amap_base.dart';
import 'package:amap_base_example/map/create_map/show_indoor_map.screen.dart';
import 'package:amap_base_example/map/create_map/show_map.screen.dart';
import 'package:amap_base_example/map/create_map/switch_map_layer.screen.dart';
import 'package:amap_base_example/map/get_map_data/bound_poi_search.screen.dart';
import 'package:amap_base_example/map/get_map_data/id_poi_search.screen.dart';
import 'package:amap_base_example/map/get_map_data/keyword_poi_search.screen.dart';
import 'package:amap_base_example/map/get_map_data/polygon_poi_search.screen.dart';
import 'package:amap_base_example/map/get_map_data/route_poi_search.screen.dart';
import 'package:amap_base_example/map/going_out_plan/driving_route_plan.screen.dart';
import 'package:amap_base_example/map/interact_with_map/code_interaction.screen.dart';
import 'package:amap_base_example/map/interact_with_map/control_interaction.screen.dart';
import 'package:amap_base_example/map/interact_with_map/gesture_interaction.screen.dart';
import 'package:amap_base_example/map/draw_on_map/draw_point.screen.dart';
import 'package:amap_base_example/map/draw_on_map/draw_polyline.screen.dart';
import 'package:amap_base_example/map/tools/coordinate_transformation_screen.dart';
import 'package:amap_base_example/widgets/dimens.dart';
import 'package:amap_base_example/widgets/function_group.widget.dart';
import 'package:amap_base_example/widgets/function_item.widget.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          child: Text('单次定位'),
          onPressed: () {
            AMapLocation()
                .startLocate(LocationClientOptions(
                    isOnceLocation: true, locatingWithReGeocode: true))
                .listen((result) {
              print(result.toString());
              setState(() {
                _result = result.toString();
              });
            });
          },
        ),
        RaisedButton(
          child: Text('连续定位'),
          onPressed: () async {
            await AMapLocation().init();
            AMapLocation()
                .startLocate(LocationClientOptions(
              isOnceLocation: false,
              locatingWithReGeocode: true,
            ))
                .listen((result) {
              print(result.toString());
              setState(() {
                _result = result.toString();
              });
            });
          },
        ),
        RaisedButton(
          child: Text('停止定位'),
          onPressed: () async {
            await AMapLocation().init();
            AMapLocation().stopLocate();
          },
        ),
        Flexible(child: ListView(children: <Widget>[Text(_result)])),
      ],
    );
  }

  @override
  void dispose() {
    AMapLocation().stopLocate();
    super.dispose();
  }
}
