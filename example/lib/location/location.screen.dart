import 'package:amap_base/amap_base.dart';
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
