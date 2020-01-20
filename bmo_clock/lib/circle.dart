import 'dart:ui';
import 'package:flutter/material.dart';

class DrawnCircle extends StatelessWidget {
  final double radius;
  final Color color;

  const DrawnCircle({
    @required this.radius,
    @required this.color,
  }) : assert(color != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _DrawnCircle(radius: radius, color: color),
        ),
      ),
    );
  }
}

class _DrawnCircle extends CustomPainter {
  final double radius;
  final Color color;

  _DrawnCircle({
    @required this.radius,
    @required this.color,
  }) : assert(color != null);

  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    final oval = Path()..addOval(Rect.fromCircle(center: center.translate(-1, -1), radius: radius - 1));
    final shadowPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawPath(oval, shadowPaint);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(_DrawnCircle oldDelegate) {
    return false;
  }
}
