import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ClockHandAnglesData.dart';
import 'compositional_clock.dart';

class ColonGroupClock extends StatefulWidget {
  final double singleSize;

  const ColonGroupClock({Key key, this.singleSize}) : super(key: key);

  _ColonGroupClock createState() => _ColonGroupClock(singleSize);
}

class _ColonGroupClock extends State<ColonGroupClock> {
  final double size;

  _ColonGroupClock(this.size);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(8, (index) {
      return Column(children: <Widget>[
        Row(
          children: <Widget>[
            Container(width: size, height: size, child: CompositionalClock(radius: size / 2, clockNumber: index * 2 + 0, model: CompositionalClockModel(colonHandAngle))),
            SizedBox(width: 4),
            Container(width: size, height: size, child: CompositionalClock(radius: size / 2, clockNumber: index * 2 + 1, model: CompositionalClockModel(colonHandAngle))),
            SizedBox(width: 4),
          ],
        ),
        SizedBox(height: 4),
      ]);
    }));
  }
}
