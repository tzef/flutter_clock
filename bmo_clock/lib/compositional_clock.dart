import 'package:vector_math/vector_math_64.dart' show radians;
import 'package:flutter/material.dart';
import 'container_hand.dart';
import 'drawn_hand.dart';
import 'circle.dart';

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

class CompositionalClock extends StatefulWidget {
  final double radius;

  const CompositionalClock({Key key, this.radius}) : super(key: key);

  _CompositionalClockState createState() => _CompositionalClockState(radius);
}

class _CompositionalClockState extends State<CompositionalClock> with SingleTickerProviderStateMixin {
  final double radius;
  var _now = DateTime.now();
  Animation<double> animation;
  AnimationController controller;

  _CompositionalClockState(this.radius);

  void initState() {
    super.initState();

    _now = DateTime.now();
    controller = new AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    animation = new Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.forward(from: 0.0);
          _now = DateTime.now();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).copyWith(
            // Hour hand.
            primaryColor: Color(0xFF4285F4),
            // Minute hand.
            highlightColor: Color(0xFF8AB4F8),
            // Second hand.
            accentColor: Color(0xFF669DF6),
            backgroundColor: Color(0xFFD2E3FC),
          )
        : Theme.of(context).copyWith(
            primaryColor: Color(0xFFD2E3FC),
            highlightColor: Color(0xFF4285F4),
            accentColor: Color(0xFF8AB4F8),
            backgroundColor: Color(0xFF3C4043),
          );

    return Container(
      color: customTheme.backgroundColor,
      child: Stack(
        children: [
          DrawnCircle(
            radius: radius,
            color: customTheme.accentColor,
          ),
          DrawnHand(
            color: customTheme.accentColor,
            thickness: 4,
            size: 1,
            angleRadians: (_now.second + animation.value) * radiansPerTick,
            radius: radius,
          ),
          DrawnHand(
            color: customTheme.highlightColor,
            thickness: 16,
            size: 0.9,
            angleRadians: (_now.minute + _now.second / 60) * radiansPerTick,
            radius: radius,
          ),
          ContainerHand(
            color: Colors.transparent,
            size: 0.5,
            angleRadians: _now.hour * radiansPerHour + (_now.minute / 60) * radiansPerHour,
            child: Transform.translate(
              offset: Offset(0.0, -radius / 2),
              child: Container(
                width: 32,
                height: radius,
                decoration: BoxDecoration(
                  color: customTheme.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
