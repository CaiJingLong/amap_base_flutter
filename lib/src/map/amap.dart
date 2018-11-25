part of amap_flutter;

class AMapView extends StatefulWidget {
  AMapView();

  @override
  State createState() => _AMapState();
}

class _AMapState extends State<AMapView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(viewType: 'me.yohom/AMapView');
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(viewType: 'me.yohom/AMapView');
    }

    return Text(
      '$defaultTargetPlatform is not yet supported by the maps plugin',
    );
  }
}
