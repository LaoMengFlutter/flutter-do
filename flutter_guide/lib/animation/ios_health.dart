import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

///
/// des:
///
class IOSHealth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          child: TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: .6),
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
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 15;

  @override
  void paint(Canvas canvas, Size size) {
    Gradient gradient = SweepGradient(
      endAngle: pi * 2 * progress,
      colors: [
        Color(0xFFD32D2F),
        Color(0xFFEA4886),
      ],
    );
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);

    _paint.shader = gradient.createShader(rect);

    canvas.save();
    canvas.translate(0.0, size.width);
    canvas.rotate(-pi / 2);

    canvas.drawArc(rect, 0, pi * 2 * progress, false, _paint);


    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
