import 'package:flutter/material.dart';
import 'package:framework/framework.dart';

/// 连续设置
class ContinuousSetting extends StatefulWidget {
  const ContinuousSetting({
    Key key,
    @required this.head,
    @required this.onChanged,
    this.min = 0,
    this.max = 1,
  }) : super(key: key);

  final String head;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;

  @override
  _ContinuousSettingState createState() => new _ContinuousSettingState();
}

class _ContinuousSettingState extends State<ContinuousSetting> {
  double _value;

  @override
  void initState() {
    super.initState();
    _value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedColumn(
      padding: const EdgeInsets.only(
        left: 16,
        top: 16,
        right: 16,
      ),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.head, style: Theme.of(context).textTheme.subhead),
        SPACE_NORMAL,
        Slider(
          value: _value,
          min: widget.min,
          max: widget.max,
          onChanged: (_) {},
          onChangeEnd: (value) {
            setState(() {
              _value = value;
              widget.onChanged(value);
            });
          },
        ),
        kDividerTiny,
      ],
    );
  }
}

/// 离散设置
class DiscreteSetting extends StatelessWidget {
  const DiscreteSetting({
    Key key,
    @required this.head,
    @required this.options,
    @required this.onSelected,
  }) : super(key: key);

  final String head;
  final List<String> options;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PopupMenuButton<String>(
          onSelected: onSelected,
          child: Padding(
            padding: const EdgeInsets.all(kSpaceBig),
            child: Text(head, style: Theme.of(context).textTheme.subhead),
          ),
          itemBuilder: (context) {
            return options
                .map((value) => PopupMenuItem<String>(
                      child: Text(value),
                      value: value,
                    ))
                .toList();
          },
        ),
        kDividerTiny,
      ],
    );
  }
}

/// 二元设置
class BooleanSetting extends StatefulWidget {
  const BooleanSetting({
    Key key,
    @required this.head,
    @required this.onSelected,
  }) : super(key: key);

  final String head;
  final ValueChanged<bool> onSelected;

  @override
  _BooleanSettingState createState() => _BooleanSettingState();
}

class _BooleanSettingState extends State<BooleanSetting> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SwitchListTile(
          title: Text(widget.head),
          value: _selected,
          onChanged: (selected) {
            setState(() {
              _selected = selected;
              widget.onSelected(selected);
            });
          },
        ),
        kDividerTiny,
      ],
    );
  }
}
