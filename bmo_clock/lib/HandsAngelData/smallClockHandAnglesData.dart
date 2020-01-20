import 'package:vector_math/vector_math_64.dart' show radians;
import 'package:analog_clock/HandsAngelData/clockHandAnglesModel.dart';

final List<ClockHandAngle> degreeSymbolHandAngle = [
  ClockHandAngle(radians(180), radians(90)),
  ClockHandAngle(radians(270), radians(180)),

  ClockHandAngle(radians(0), radians(90)),
  ClockHandAngle(radians(270), radians(0)),

  ClockHandAngle(radians(225), radians(225)),
  ClockHandAngle(radians(225), radians(225)),
];

final List<ClockHandAngle> cSymbolHandAngle = [
  ClockHandAngle(radians(180), radians(90)),
  ClockHandAngle(radians(270), radians(180)),

  ClockHandAngle(radians(0), radians(180)),
  ClockHandAngle(radians(225), radians(225)),

  ClockHandAngle(radians(0), radians(90)),
  ClockHandAngle(radians(270), radians(0)),
];

final List<ClockHandAngle> smallNumericZeroHandAngle = [
  ClockHandAngle(radians(180), radians(90)),
  ClockHandAngle(radians(270), radians(180)),

  ClockHandAngle(radians(0), radians(180)),
  ClockHandAngle(radians(0), radians(180)),

  ClockHandAngle(radians(0), radians(90)),
  ClockHandAngle(radians(270), radians(0)),
];

final List<ClockHandAngle> smallNumericOneHandAngle = [
  ClockHandAngle(radians(225), radians(225)),
  ClockHandAngle(radians(180), radians(180)),

  ClockHandAngle(radians(225), radians(225)),
  ClockHandAngle(radians(0), radians(180)),

  ClockHandAngle(radians(225), radians(225)),
  ClockHandAngle(radians(0), radians(0)),
];

final List<ClockHandAngle> smallNumericTwoHandAngle = [
  ClockHandAngle(radians(90), radians(90)),
  ClockHandAngle(radians(270), radians(180)),

  ClockHandAngle(radians(180), radians(90)),
  ClockHandAngle(radians(270), radians(0)),

  ClockHandAngle(radians(0), radians(90)),
  ClockHandAngle(radians(270), radians(270)),
];

final List<ClockHandAngle> smallNumericThreeHandAngle = [
  ClockHandAngle(radians(90), radians(90)),
  ClockHandAngle(radians(270), radians(180)),

  ClockHandAngle(radians(90), radians(90)),
  ClockHandAngle(radians(0), radians(270)),

  ClockHandAngle(radians(90), radians(90)),
  ClockHandAngle(radians(270), radians(00)),
];

final List<ClockHandAngle> smallNumericFourHandAngle = [
  ClockHandAngle(radians(180), radians(180)),
  ClockHandAngle(radians(180), radians(180)),

  ClockHandAngle(radians(0), radians(90)),
  ClockHandAngle(radians(0), radians(180)),

  ClockHandAngle(radians(225), radians(225)),
  ClockHandAngle(radians(0), radians(180)),
];

final List<ClockHandAngle> smallNumericFiveHandAngle = [
  ClockHandAngle(radians(180), radians(90)),
  ClockHandAngle(radians(270), radians(270)),

  ClockHandAngle(radians(0), radians(90)),
  ClockHandAngle(radians(270), radians(180)),

  ClockHandAngle(radians(90), radians(90)),
  ClockHandAngle(radians(270), radians(0)),
];

final List<ClockHandAngle> smallNumericSixHandAngle = [
  ClockHandAngle(radians(180), radians(90)),
  ClockHandAngle(radians(270), radians(270)),

  ClockHandAngle(radians(180), radians(90)),
  ClockHandAngle(radians(270), radians(180)),

  ClockHandAngle(radians(0), radians(90)),
  ClockHandAngle(radians(270), radians(0)),
];

final List<ClockHandAngle> smallNumericSevenHandAngle = [
  ClockHandAngle(radians(180), radians(90)),
  ClockHandAngle(radians(270), radians(180)),

  ClockHandAngle(radians(0), radians(0)),
  ClockHandAngle(radians(0), radians(180)),

  ClockHandAngle(radians(225), radians(225)),
  ClockHandAngle(radians(0), radians(0)),
];

final List<ClockHandAngle> smallNumericEightHandAngle = [
  ClockHandAngle(radians(180), radians(90)),
  ClockHandAngle(radians(270), radians(180)),

  ClockHandAngle(radians(180), radians(90)),
  ClockHandAngle(radians(270), radians(180)),

  ClockHandAngle(radians(0), radians(90)),
  ClockHandAngle(radians(270), radians(0)),
];

final List<ClockHandAngle> smallNumericNineHandAngle = [
  ClockHandAngle(radians(180), radians(90)),
  ClockHandAngle(radians(270), radians(180)),

  ClockHandAngle(radians(0), radians(90)),
  ClockHandAngle(radians(0), radians(180)),

  ClockHandAngle(radians(90), radians(90)),
  ClockHandAngle(radians(270), radians(0)),
];

final Map<String, List<ClockHandAngle>> smallNumericHandAngles = {
  "o": degreeSymbolHandAngle,
  "C": cSymbolHandAngle,
  "0": smallNumericZeroHandAngle,
  "1": smallNumericOneHandAngle,
  "2": smallNumericTwoHandAngle,
  "3": smallNumericThreeHandAngle,
  "4": smallNumericFourHandAngle,
  "5": smallNumericFiveHandAngle,
  "6": smallNumericSixHandAngle,
  "7": smallNumericSevenHandAngle,
  "8": smallNumericEightHandAngle,
  "9": smallNumericNineHandAngle,
};