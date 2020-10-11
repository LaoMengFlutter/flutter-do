import 'dart:math';

import 'package:flutter/material.dart';

///
/// des:
///
class CustomCircleProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 150,
          height: 150,
          child: TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(seconds: 3),
            builder: (BuildContext context, double value, Widget child) {
              return CustomPaint(
                painter: _CircleProgressPainter(value),
                child: Center(child: Text('${(value * 100).floor()}%')),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  final double progress;

  _CircleProgressPainter(this.progress);

  Paint _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    double radius = min(size.width, size.height) / 2;

    Gradient gradient = SweepGradient(
      startAngle: -pi / 2,
      endAngle: pi * 2 * progress,
      colors: [
        Color(0xFFD32D2F),
        Color(0xFFEA4886),
      ],
    );
    var rect = Rect.fromLTWH(0, 0, radius * 2, radius * 2);

    _paint.shader = gradient.createShader(rect);

    canvas.save();
    canvas.translate(0.0, size.height);
    canvas.rotate(-pi / 2);

    canvas.drawArc(rect, 0, pi * 2 * progress, false, _paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
