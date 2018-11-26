import 'src/map/model/amap_options.dart';

const _viewType = 'me.yohom/AMapView';

class AMapView extends StatelessWidget {
  const AMapView({
    Key key,
    this.onAMapViewCreated,
    this.hitTestBehavior = PlatformViewHitTestBehavior.opaque,
    this.layoutDirection,
    this.amapOptions = const AMapOptions(),
  }) : super(key: key);

  final PlatformViewCreatedCallback onAMapViewCreated;
  final PlatformViewHitTestBehavior hitTestBehavior;
  final TextDirection layoutDirection;
  final AMapOptions amapOptions;

  @override
  Widget build(BuildContext context) {
    final gestureRecognizers = <Factory<OneSequenceGestureRecognizer>>[
      Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
    ].toSet();

//    final String params = jsonEncode(amapOptions.toJson());
//    final messageCodec = StandardMessageCodec();
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: _viewType,
//        hitTestBehavior: hitTestBehavior,
//        gestureRecognizers: gestureRecognizers,
//        onPlatformViewCreated: onAMapViewCreated,
//        layoutDirection: layoutDirection,
//        creationParams: params,
//        creationParamsCodec: messageCodec,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: _viewType,
//        hitTestBehavior: hitTestBehavior,
//        gestureRecognizers: gestureRecognizers,
//        onPlatformViewCreated: onAMapViewCreated,
//        layoutDirection: layoutDirection,
//        creationParams: params,
//        creationParamsCodec: messageCodec,
      );
    } else {
      return Text(
        '$defaultTargetPlatform is not yet supported by the maps plugin',
      );
    }
  }
}
