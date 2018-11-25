part of amap_flutter;

const _viewType = 'me.yohom/AMapView';

class AMapView extends StatelessWidget {
  const AMapView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gestureRecognizers = Set.of([
      Factory<OneSequenceGestureRecognizer>(
        () => EagerGestureRecognizer(),
      ),
    ]);
    final onPlatformViewCreated = () {};
    final hitTestBehavior = PlatformViewHitTestBehavior.opaque;
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: _viewType,
        gestureRecognizers: gestureRecognizers,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: _viewType,
        gestureRecognizers: gestureRecognizers,
      );
    } else {
      return Text(
        '$defaultTargetPlatform is not yet supported by the maps plugin',
      );
    }
  }
}
