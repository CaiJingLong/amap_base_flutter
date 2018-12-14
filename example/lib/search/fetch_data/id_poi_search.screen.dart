import 'package:amap_base/amap_base.dart';
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
  String _result = '';

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
                      setState(() {
                        _result = poiResult.toString();
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
}
