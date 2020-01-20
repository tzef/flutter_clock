import 'package:analog_clock/HandsAngelData/weatherClockHandAnglesData.dart';
import 'package:analog_clock/HandsAngelData/clockHandAnglesModel.dart';
import 'package:analog_clock/HandsAngelData/clockHandAnglesData.dart';
import 'package:analog_clock/GroupsClock/numeric_clock_model.dart';
import 'package:analog_clock/compositional_clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColonGroupClock extends StatefulWidget {
  final double singleSize;
  final NumericClockModel model;

  const ColonGroupClock({Key key, this.singleSize, this.model}) : super(key: key);

  _ColonGroupClock createState() => _ColonGroupClock(singleSize);
}

class _ColonGroupClock extends State<ColonGroupClock> {
  final double size;
  List<ClockHandAngle> angles;
  List<CompositionalClock> compositionalClocks;

  _ColonGroupClock(this.size);

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    angles = numericHandAngles[widget.model.key];
    compositionalClocks = Iterable<int>.generate(16).map((i) => CompositionalClock(radius: size / 2, clockNumber: i, model: CompositionalClockModel(angles))).toList();
  }

  @override
  void didUpdateWidget(ColonGroupClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  void _updateModel() {
    setState(() {
      angles = numericHandAngles[widget.model.key];
      if (angles == null) {
        angles = weatherHandAngles[widget.model.key];
      }
      compositionalClocks.forEach((clock) {
        clock.model.angles = angles;
        clock.model.notifyListeners();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(8, (index) {
      return Column(children: <Widget>[
        Row(
          children: <Widget>[
            Container(width: size, height: size, child: compositionalClocks[index * 2 + 0]),
            SizedBox(width: 4),
            Container(width: size, height: size, child: compositionalClocks[index * 2 + 1]),
            SizedBox(width: 4),
          ],
        ),
        SizedBox(height: 4),
      ]);
    }));
  }
}
