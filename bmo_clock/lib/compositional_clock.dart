import 'package:vector_math/vector_math_64.dart' show radians;
import 'HandsAngelData/clockHandAnglesModel.dart';
import 'package:flutter/material.dart';
import 'drawn_hand.dart';
import 'circle.dart';

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

class CompositionalClockModel extends ChangeNotifier {
  List<ClockHandAngle> angles;
  VoidCallback oneMinutesCompletion;

  CompositionalClockModel(this.angles);
}

class CompositionalClock extends StatefulWidget {
  final double radius;
  final int clockNumber;
  final CompositionalClockModel model;

  const CompositionalClock({Key key, this.radius, this.clockNumber, this.model}) : super(key: key);

  _CompositionalClockState createState() => _CompositionalClockState(clockNumber, radius);
}

class _CompositionalClockState extends State<CompositionalClock> with SingleTickerProviderStateMixin {
  final int clockNumber;
  final double radius;
  double minuteAngle;
  double hourAngle;
  double _seconds;
  Animation<double> animation;
  AnimationController controller;

  _CompositionalClockState(this.clockNumber, this.radius);

  void initState() {
    super.initState();

    _updateModel();
    widget.model.addListener(_updateModel);
    controller = new AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    if (clockNumber == null) {
      _seconds = DateTime.now().second.toDouble();
      animation = new Tween(begin: 0.0, end: 1.0).animate(controller)
        ..addListener(() {
          setState(() {});
        })
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            controller.forward(from: 0.0);
            _seconds += 1;
            if (_seconds == 60) {
              widget.model.oneMinutesCompletion();
              _seconds = 0;
            }
          }
        });
      controller.forward();
    } else {
      animation = new Tween(begin: 0.0, end: 1.0).animate(controller)
        ..addListener(() {
          setState(() {});
        })
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            hourAngle = widget.model.angles[clockNumber].hourHand;
            minuteAngle = widget.model.angles[clockNumber].minuteHand;
          }
        });
    }
  }

  @override
  void didUpdateWidget(CompositionalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  void _updateModel() {
    if (clockNumber != null) {
      if (hourAngle != null && minuteAngle != null) {
        if (hourAngle != widget.model.angles[clockNumber].hourHand || minuteAngle != widget.model.angles[clockNumber].minuteHand) {
          controller.forward(from: 0);
        }
      } else {
        hourAngle = widget.model.angles[clockNumber].hourHand;
        minuteAngle = widget.model.angles[clockNumber].minuteHand;
      }
    }
  }

  @override
  void dispose() {
    widget.model.removeListener(_updateModel);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).copyWith(
            primaryColor: Color(0xFF4285F4),
            highlightColor: Color(0xFF8AB4F8),
            accentColor: Color(0xFF669DF6),
            backgroundColor: Color(0xFFD2E3FC),
          )
        : Theme.of(context).copyWith(
            primaryColor: Color(0xFFD2E3FC),
            highlightColor: Color(0xFF4285F4),
            accentColor: Color(0xFF8AB4F8),
            backgroundColor: Color(0xFF3C4043),
          );

    if (clockNumber != null) {
      return Container(
        color: customTheme.backgroundColor,
        child: Stack(
          children: [
            DrawnCircle(
              radius: radius,
              color: customTheme.accentColor,
            ),
            DrawnHand(
              color: Colors.black,
              thickness: 3,
              size: 0.8,
              angleRadians: hourAngle + ((widget.model.angles[clockNumber].hourHand) - hourAngle)  * animation.value,
              radius: radius,
            ),
            DrawnHand(
              color: Colors.black,
              thickness: 3,
              size: 0.8,
              angleRadians: minuteAngle + ((widget.model.angles[clockNumber].minuteHand) - minuteAngle)  * animation.value,
              radius: radius,
            ),
          ],
        ),
      );
    } else {
      return Container(
        color: customTheme.backgroundColor,
        child: Stack(
          children: [
            DrawnCircle(
              radius: radius,
              color: customTheme.accentColor,
            ),
            DrawnHand(
              color: Colors.black,
              thickness: 3,
              size: 0.8,
              angleRadians: (_seconds + animation.value) * radiansPerTick,
              radius: radius,
            ),
          ],
        ),
      );
    }
  }
}
