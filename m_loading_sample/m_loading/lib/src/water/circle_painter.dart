import 'dart:math';

import 'package:flutter/material.dart';

///
/// desc:
///
class CirclePainter extends CustomPainter {
  final double progress;

  final double strokeWidth;
  final Color color;

  Paint _paint = Paint();

  CirclePainter(
      {this.progress = 0.0, this.strokeWidth = 1.0, this.color = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    _paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;

    double radius = min(size.width, size.height) / 2;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), radius * progress, _paint);
  }

  @override
  bool shouldRepaint(covariant CirclePainter old) {
    return progress != old.progress ||
        strokeWidth != old.strokeWidth ||
        color != old.color;
  }
}
