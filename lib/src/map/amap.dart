part of amap_flutter;

const _viewType = 'me.yohom/AMapView';

class AMapView extends StatelessWidget {
  const AMapView({
    Key key,
    this.onAMapViewCreated,
    this.hitTestBehavior = PlatformViewHitTestBehavior.opaque,
    this.layoutDirection,
  }) : super(key: key);

  final PlatformViewCreatedCallback onAMapViewCreated;
  final PlatformViewHitTestBehavior hitTestBehavior;
  final TextDirection layoutDirection;

  @override
  Widget build(BuildContext context) {
    final gestureRecognizers = <Factory<OneSequenceGestureRecognizer>>[
      Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
    ].toSet();
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: _viewType,
        hitTestBehavior: hitTestBehavior,
        gestureRecognizers: gestureRecognizers,
        onPlatformViewCreated: onAMapViewCreated,
        layoutDirection: layoutDirection,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: _viewType,
        hitTestBehavior: hitTestBehavior,
        gestureRecognizers: gestureRecognizers,
        onPlatformViewCreated: onAMapViewCreated,
        layoutDirection: layoutDirection,
      );
    } else {
      return Text(
        '$defaultTargetPlatform is not yet supported by the maps plugin',
      );
    }
  }
}
