import 'package:amap_base/amap_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  final List<NavigatorObserver> observers = <NavigatorObserver>[];
  runApp(MaterialApp(home: MapsDemo(), navigatorObservers: observers));
}

class MapsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AMaps examples')),
      body: AMapView(),
    );
  }
}
