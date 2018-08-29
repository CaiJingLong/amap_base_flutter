part of amap_flutter;

typedef void MapCreatedCallback(AMapController controller);

class AMapView extends StatefulWidget {
  AMapView({
    @required this.onMapCreated,
    AMapOptions options,
    this.hitTestBehavior = PlatformViewHitTestBehavior.opaque,
  }) : this.options = AMapOptions.defaultOptions.copyWith(options);

  final MapCreatedCallback onMapCreated;
  final AMapOptions options;
  final PlatformViewHitTestBehavior hitTestBehavior;

  @override
  State createState() => _AMapState();
}

class _AMapState extends State<AMapView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'me.yohom/AMapView',
        hitTestBehavior: widget.hitTestBehavior,
        onPlatformViewCreated: onPlatformViewCreated,
        creationParams: widget.options._toJson(),
        creationParamsCodec: const StandardMessageCodec(),
      );
    }

    return Text(
        '$defaultTargetPlatform is not yet supported by the maps plugin');
  }

  Future<void> onPlatformViewCreated(int id) async {
    final AMapController controller =
        await AMapController.init(id, widget.options);
    widget.onMapCreated(controller);
  }
}
