import 'package:amap_base/amap_base.dart';
import 'package:flutter/material.dart';

class NaviScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('开始导航'),
        onPressed: () {
          AMapNavi.startNavi(lat: 29.12, lon: 119.64, naviType: AMapNavi.ride);
        },
      ),
    );
  }
}
