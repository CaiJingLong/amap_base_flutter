import 'dart:convert';

import 'package:amap_base/amap_base.dart';
import 'package:amap_base/src/map/model/amap_options.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

const _viewType = 'me.yohom/AMapView';

typedef void MapCreatedCallback(AMapController controller);

class AMapView extends StatelessWidget {
  const AMapView({
    Key key,
    this.onAMapViewCreated,
    this.hitTestBehavior = PlatformViewHitTestBehavior.opaque,
    this.layoutDirection,
    this.amapOptions = const AMapOptions(),
  }) : super(key: key);

  final MapCreatedCallback onAMapViewCreated;
  final PlatformViewHitTestBehavior hitTestBehavior;
  final TextDirection layoutDirection;
  final AMapOptions amapOptions;

  @override
  Widget build(BuildContext context) {
    final gestureRecognizers = <Factory<OneSequenceGestureRecognizer>>[
      Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
    ].toSet();

    final String params = jsonEncode(amapOptions.toJson());
    final messageCodec = StandardMessageCodec();
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: _viewType,
        hitTestBehavior: hitTestBehavior,
        gestureRecognizers: gestureRecognizers,
        onPlatformViewCreated: _onViewCreated,
        layoutDirection: layoutDirection,
        creationParams: params,
        creationParamsCodec: messageCodec,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: _viewType,
        hitTestBehavior: hitTestBehavior,
        gestureRecognizers: gestureRecognizers,
        onPlatformViewCreated: _onViewCreated,
        layoutDirection: layoutDirection,
        creationParams: params,
        creationParamsCodec: messageCodec,
      );
    } else {
      return Text(
        '$defaultTargetPlatform is not yet supported by the maps plugin',
      );
    }
  }

  void _onViewCreated(int id) {
    final controller = AMapController.withId(id);
    if (onAMapViewCreated != null) {
      onAMapViewCreated(controller);
    }
  }
}
