import 'package:amap_base_search/amap_base.dart';
import 'package:amap_base_example/utils/misc.dart';
import 'package:amap_base_example/utils/view.dart';
import 'package:amap_base_example/widgets/button.widget.dart';
import 'package:amap_base_example/widgets/dimens.dart';
import 'package:flutter/material.dart';

class IdPoiSearchScreen extends StatefulWidget {
  IdPoiSearchScreen();

  factory IdPoiSearchScreen.forDesignTime() => IdPoiSearchScreen();

  @override
  _IdPoiSearchScreenState createState() => _IdPoiSearchScreenState();
}

class _IdPoiSearchScreenState extends State<IdPoiSearchScreen> {
  AMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ID检索POI'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: AMapView(
              onAMapViewCreated: (controller) {
                setState(() => _controller = controller);
              },
              amapOptions: AMapOptions(),
            ),
          ),
          Form(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Text('ID: B0FFJD44SX', textAlign: TextAlign.center),
                SPACE_NORMAL,
                Button(
                  label: '开始搜索',
                  onPressed: (context) async {
                    if (!Form.of(context).validate()) {
                      return;
                    }

                    loading(
                      context,
                      AMapSearch().searchPoiId('B0FFJD44SX'),
                    ).then((poiResult) {
                      _controller.addMarker(
                        MarkerOptions(position: poiResult.latLonPoint),
                      );
                    }).catchError((e) => showError(context, e.toString()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
