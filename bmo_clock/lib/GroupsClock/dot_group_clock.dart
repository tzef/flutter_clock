import 'package:vector_math/vector_math_64.dart' show radians;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../HandsAngelData/clockHandAnglesModel.dart';
import '../compositional_clock.dart';

class DotGroupClock extends StatefulWidget {
  final double singleSize;

  const DotGroupClock({Key key, this.singleSize}) : super(key: key);

  _DotGroupClock createState() => _DotGroupClock(singleSize);
}

class _DotGroupClock extends State<DotGroupClock> {
  final double size;
  _DotGroupClock(this.size);
  List<CompositionalClock> compositionalClocks;

  @override
  void initState() {
    super.initState();
    compositionalClocks = Iterable<int>.generate(3).map((i) => CompositionalClock(radius: size / 2, clockNumber: i, model: CompositionalClockModel(dotSymbolHandAngle))).toList();
    compositionalClocks.forEach((clock) {
      clock.model.angles = dotSymbolHandAngle;
      clock.model.notifyListeners();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(3, (index) {
          return Column(children: <Widget>[
            Row(
              children: <Widget>[
                Container(width: size, height: size, child: compositionalClocks[index]),
                SizedBox(width: 4),
              ],
            ),
            SizedBox(height: 4),
          ]);
        }));
  }
}

final List<ClockHandAngle> dotSymbolHandAngle = [
  ClockHandAngle(radians(225), radians(225)),
  ClockHandAngle(radians(225), radians(225)),
  ClockHandAngle(radians(0), radians(0)),
];

