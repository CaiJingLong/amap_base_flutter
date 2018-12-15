import 'package:amap_base_location/amap_base.dart';
import 'package:amap_base_example/utils/misc.dart';
import 'package:amap_base_example/utils/view.dart';
import 'package:amap_base_example/widgets/button.widget.dart';
import 'package:amap_base_example/widgets/dimens.dart';
import 'package:flutter/material.dart';

class GeocodeScreen extends StatefulWidget {
  GeocodeScreen();

  factory GeocodeScreen.forDesignTime() => GeocodeScreen();

  @override
  _GeocodeScreenState createState() => _GeocodeScreenState();
}

class _GeocodeScreenState extends State<GeocodeScreen> {
  String _result = '';

  TextEditingController _nameController = TextEditingController(text: '方恒国际中心');
  TextEditingController _cityController = TextEditingController(text: '北京');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('地理编码（地址转坐标）'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Form(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: '输入目标地址',
                    border: OutlineInputBorder(),
                  ),
                  controller: _nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return '输入目标地址';
                    }
                  },
                ),
                SPACE_NORMAL,
                TextFormField(
                  decoration: InputDecoration(
                    hintText: '输入所在城市',
                    border: OutlineInputBorder(),
                  ),
                  controller: _cityController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return '输入所在城市';
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
                      AMapSearch().searchGeocode(
                        _nameController.text,
                        _cityController.text,
                      ),
                    ).then((result) {
                      setState(() {
                        _result = result.toString();
                      });
                    }).catchError((e) => showError(context, e.toString()));
                  },
                ),
                SPACE_NORMAL,
                Text(_result),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    super.dispose();
  }
}
