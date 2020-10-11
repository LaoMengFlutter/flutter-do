import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

///
/// desc:
///

class RadarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF0F1532),
        body: Stack(
          children: [
            Positioned.fill(
              left: 10,
              right: 10,
              child: Center(
                child: Stack(children: [
                  Positioned.fill(
                    child: RadarView(),
                  ),
                  Positioned(
                    child: Center(
                      child: Container(
                        height: 70.0,
                        width: 70.0,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            image: DecorationImage(
                                image: AssetImage('assets/images/logo.png')),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(.5),
                                blurRadius: 5.0,
                                spreadRadius: 3.0,
                              ),
                            ]),
                      ),
                    ),
                  ),
                ]),
              ),
            )
          ],
        ));
  }
}

class RadarView extends StatefulWidget {
  @override
  _RadarViewState createState() => _RadarViewState();
}

class _RadarViewState extends State<RadarView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animation = Tween(begin: .0, end: pi * 2).animate(_controller);
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: RadarPainter(_animation.value),
        );
      },
    );
  }
}

class RadarPainter extends CustomPainter {
  final double angle;

  Paint _bgPaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

  Paint _paint = Paint()..style = PaintingStyle.fill;

  int circleCount = 3;

  RadarPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = min(size.width / 2, size.height / 2);

    canvas.drawLine(Offset(size.width / 2, size.height / 2 - radius),
        Offset(size.width / 2, size.height / 2 + radius), _bgPaint);
    canvas.drawLine(Offset(size.width / 2 - radius, size.height / 2),
        Offset(size.width / 2 + radius, size.height / 2), _bgPaint);

    for (var i = 1; i <= circleCount; ++i) {
      canvas.drawCircle(Offset(size.width / 2, size.height / 2),
          radius * i / circleCount, _bgPaint);
    }

    _paint.shader = ui.Gradient.sweep(
        Offset(size.width / 2, size.height / 2),
        [Colors.white.withOpacity(.01), Colors.white.withOpacity(.5)],
        [.0, 1.0],
        TileMode.clamp,
        .0,
        pi / 12);

    canvas.save();
    double r = sqrt(pow(size.width, 2) + pow(size.height, 2));
    double startAngle = atan(size.height / size.width);
    Point p0 = Point(r * cos(startAngle), r * sin(startAngle));
    Point px = Point(r * cos(angle + startAngle), r * sin(angle + startAngle));
    canvas.translate((p0.x - px.x) / 2, (p0.y - px.y) / 2);
    canvas.rotate(angle);

    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: radius),
        0,
        pi / 12,
        true,
        _paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
