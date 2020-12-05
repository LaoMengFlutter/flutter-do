import 'dart:math';

import 'package:flutter/material.dart';

///
/// desc:圆环
///
class RingPainter extends CustomPainter {
  final double startAngle;

  final double sweepAngle;
  final double strokeWidth;
  final StrokeCap strokeCap;
  final Color color;

  Paint _paint;

  RingPainter(
      {this.startAngle = 0.0,
      this.sweepAngle = 2 * pi,
      this.strokeWidth = 8.0,
      this.strokeCap = StrokeCap.round,
      this.color = Colors.white}) {
    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double radius = min(size.width, size.height) / 2;
    canvas.drawArc(Rect.fromLTWH(0, 0, radius * 2, radius * 2), startAngle,
        sweepAngle, false, _paint);
  }

  @override
  bool shouldRepaint(covariant RingPainter old) {
    return startAngle != old.startAngle ||
        sweepAngle != old.sweepAngle ||
        strokeWidth != old.strokeWidth ||
        strokeCap != old.strokeCap ||
        color != old.color;
  }
}
