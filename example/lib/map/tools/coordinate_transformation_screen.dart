import 'package:amap_base/amap_base.dart';
import 'package:flutter/material.dart';

class CoordinateTransformationScreen extends StatefulWidget {
  @override
  _CoordinateTransformationStateScreen createState() =>
      _CoordinateTransformationStateScreen();
}

class _CoordinateTransformationStateScreen
    extends State<CoordinateTransformationScreen> {
  TextEditingController lat;
  TextEditingController lng;

  LatLngType type = LatLngType.baidu;

  LatLng current = LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    lat = TextEditingController(text: "116.403988");
    lng = TextEditingController(text: "39.914266");
    lat.addListener(update);
    lng.addListener(update);
  }

  void update() {
    var lat = double.tryParse(this.lat.text) ?? 0;
    var lng = double.tryParse(this.lng.text) ?? 0;

    CalculateTools.convertCoordinate(lat: lat, lon: lng, type: type)
        .then((latlng) {
      print('latlng: $latlng');
      setState(() {
        this.current = latlng;
      });
    });
  }

  @override
  void dispose() {
    lat.removeListener(update);
    lng.removeListener(update);
    lat?.dispose();
    lng.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('坐标转换'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: "纬度 latitude"),
            controller: lat,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "经度 lon"),
            controller: lng,
          ),
          DropdownButtonFormField(
            items: _buildTypeItem(),
            value: type,
            onChanged: (type) {
              this.type = type;
              update();
            },
          ),
          Text("当前坐标" + (current?.toString() ?? "")),
        ],
      ),
    );
  }

  List<DropdownMenuItem<LatLngType>> _buildTypeItem() {
    return LatLngType.values.map((type) => _buildItem(type)).toList();
  }

  DropdownMenuItem<LatLngType> _buildItem(LatLngType type) {
    return DropdownMenuItem(
      child: Text(type.toString()),
      value: type,
    );
  }
}
