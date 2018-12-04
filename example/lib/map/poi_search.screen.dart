import 'package:amap_base/amap_base.dart';
import 'package:flutter/material.dart';

class PoiSearchScreen extends StatefulWidget {
  PoiSearchScreen();

  factory PoiSearchScreen.forDesignTime() => PoiSearchScreen();

  @override
  _PoiSearchScreenState createState() => _PoiSearchScreenState();
}

class _PoiSearchScreenState extends State<PoiSearchScreen> {
  AMapController _controller;
  TextEditingController _queryController = TextEditingController(text: '肯德基');
  TextEditingController _cityController = TextEditingController(text: '兰溪');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('获取POI数据')),
      body: Column(
        children: <Widget>[
          Flexible(
            child: AMapView(
              onAMapViewCreated: (controller) {
                setState(() => _controller = controller);
              },
              amapOptions: AMapOptions(),
            ),
          ),
          Flexible(
            child: Form(
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                shrinkWrap: true,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(hintText: '输入关键字'),
                    controller: _queryController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return '请输入关键字';
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: '输入城市'),
                    controller: _cityController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return '请输入城市';
                      }
                    },
                  ),
                  Builder(
                    builder: (context) {
                      return RaisedButton(
                        onPressed: () async {
                          if (!Form.of(context).validate()) {
                            return;
                          }

                          final poiResult =
                              await _controller.searchPoi(PoiSearchQuery(
                            query: _queryController.text,
                            city: _cityController.text,
                          ));
                          _controller.addMarkers(poiResult.pois
                              .map((it) => it.latLonPoint)
                              .toList()
                              .map(
                                (position) => MarkerOptions(position: position),
                              )
                              .toList());
                        },
                        child: Text('开始搜索'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
