import 'package:amap_base/amap_base.dart';
import 'package:amap_base_example/widgets/setting.widget.dart';
import 'package:flutter/material.dart';

class ControlInteractionScreen extends StatefulWidget {
  @override
  _ControlInteractionScreenState createState() =>
      _ControlInteractionScreenState();
}

class _ControlInteractionScreenState extends State<ControlInteractionScreen> {
  AMapController _controller;
  UiSettings _uiSettings = UiSettings();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ControlInteraction')),
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
            child: ListView(
              children: <Widget>[
                BooleanSetting(
                  head: '显示自己的位置',
                  onSelected: _controller?.setMyLocationEnabled,
                ),
                BooleanSetting(
                  head: '缩放按钮',
                  selected: true,
                  onSelected: (value) {
                    _controller?.setUiSettings(
                        _uiSettings.copyWith(isZoomControlsEnabled: value));
                  },
                ),
                BooleanSetting(
                  head: '指南针',
                  selected: false,
                  onSelected: (value) {
                    _controller?.setUiSettings(
                        _uiSettings.copyWith(isCompassEnabled: value));
                  },
                ),
                BooleanSetting(
                  head: '定位按钮',
                  selected: false,
                  onSelected: (value) {
                    _controller?.setUiSettings(
                        _uiSettings.copyWith(isMyLocationButtonEnabled: value));
                  },
                ),
                BooleanSetting(
                  head: '比例尺控件',
                  selected: false,
                  onSelected: (value) {
                    _controller?.setUiSettings(
                        _uiSettings.copyWith(isScaleControlsEnabled: value));
                  },
                ),
                DiscreteSetting(
                  head: '地图Logo',
                  options: ['左下', '中下', '右下'],
                  onSelected: (value) {
                    int position;
                    switch (value) {
                      case '左下':
                        position = AMapOptions.LOGO_POSITION_BOTTOM_LEFT;
                        break;
                      case '中下':
                        position = AMapOptions.LOGO_POSITION_BOTTOM_CENTER;
                        break;
                      case '右下':
                        position = AMapOptions.LOGO_POSITION_BOTTOM_RIGHT;
                        break;
                    }
                    _controller?.setUiSettings(
                        _uiSettings.copyWith(logoPosition: position));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
