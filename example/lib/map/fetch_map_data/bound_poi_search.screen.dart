import 'package:amap_base_search/amap_base.dart';
import 'package:amap_base_example/utils/misc.dart';
import 'package:amap_base_example/utils/view.dart';
import 'package:amap_base_example/widgets/button.widget.dart';
import 'package:amap_base_example/widgets/dimens.dart';
import 'package:flutter/material.dart';

class BoundPoiSearchScreen extends StatefulWidget {
  BoundPoiSearchScreen();

  factory BoundPoiSearchScreen.forDesignTime() => BoundPoiSearchScreen();

  @override
  _BoundPoiSearchScreenState createState() => _BoundPoiSearchScreenState();
}

class _BoundPoiSearchScreenState extends State<BoundPoiSearchScreen> {
  AMapController _controller;

  TextEditingController _centerController = TextEditingController(text: '天安门');
  TextEditingController _keywordController = TextEditingController(text: '厕所');
  TextEditingController _rangeController = TextEditingController(text: '1000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('周边检索POI'),
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
                TextFormField(
                  decoration: InputDecoration(
                    hintText: '输入中心',
                    border: OutlineInputBorder(),
                  ),
                  enabled: false,
                  controller: _centerController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return '请输入中心';
                    }
                  },
                ),
                SPACE_NORMAL,
                TextFormField(
                  decoration: InputDecoration(
                    hintText: '输入关键字',
                    border: OutlineInputBorder(),
                  ),
                  controller: _keywordController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return '请输入关键字';
                    }
                  },
                ),
                SPACE_NORMAL,
                TextFormField(
                  decoration: InputDecoration(
                    hintText: '输入半径/米',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  controller: _rangeController,
                  validator: (value) {
                    try {
                      int.parse(value);
                    } catch (e) {
                      return '请输入数字';
                    }
                  },
                ),
                SPACE_NORMAL,
                Button(
                  label: '开始搜索',
                  onPressed: (context) async {
                    if (!Form.of(context).validate()) {
                      return;
                    }

                    loading(
                      context,
                      AMapSearch().searchPoiBound(
                        PoiSearchQuery(
                          query: _keywordController.text,
                          location: LatLng(39.909604, 116.397228), // iOS必须
                          searchBound: SearchBound(
                            center: LatLng(39.909604, 116.397228),
                            range: int.parse(_rangeController.text),
                          ), // Android必须
                        ),
                      ),
                    ).then((poiResult) {
                      _controller.addMarkers(poiResult.pois
                          .map((it) => it.latLonPoint)
                          .toList()
                          .map((position) => MarkerOptions(position: position))
                          .toList());
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
