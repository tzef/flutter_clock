import 'package:analog_clock/HandsAngelData/clockHandAnglesModel.dart';
import 'package:analog_clock/HandsAngelData/clockHandAnglesData.dart';
import 'package:analog_clock/compositional_clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumericModel extends ChangeNotifier {
  int number;

  NumericModel(this.number);
}

class NumericGroupClock extends StatefulWidget {
  final double singleSize;
  final NumericModel model;

  const NumericGroupClock({Key key, this.singleSize, this.model}) : super(key: key);

  _NumericGroupClock createState() => _NumericGroupClock(singleSize);
}

class _NumericGroupClock extends State<NumericGroupClock> {
  final double size;
  List<ClockHandAngle> angles;
  _NumericGroupClock(this.size);
  List<CompositionalClock> compositionalClocks;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    angles = numericHandAngles[widget.model.number];
    compositionalClocks = Iterable<int>.generate(32).map((i) => CompositionalClock(radius: size / 2, clockNumber: i, model: CompositionalClockModel(angles))).toList();
  }

  @override
  void didUpdateWidget(NumericGroupClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  void _updateModel() {
    setState(() {
      angles = numericHandAngles[widget.model.number];
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
            Container(width: size, height: size, child: compositionalClocks[index * 4 + 0]),
            SizedBox(width: 4),
            Container(width: size, height: size, child: compositionalClocks[index * 4 + 1]),
            SizedBox(width: 4),
            Container(width: size, height: size, child: compositionalClocks[index * 4 + 2]),
            SizedBox(width: 4),
            Container(width: size, height: size, child: compositionalClocks[index * 4 + 3]),
            SizedBox(width: 4),
          ],
        ),
        SizedBox(height: 4),
      ]);
    }));
  }
}
