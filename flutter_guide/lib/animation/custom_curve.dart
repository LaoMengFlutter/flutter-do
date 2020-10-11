import 'dart:ui';

import 'package:flutter/material.dart';


///
/// des:
///
class CustomCurve extends StatefulWidget {
  @override
  _CustomCurveState createState() => _CustomCurveState();
}

class _CustomCurveState extends State<CustomCurve>
    with TickerProviderStateMixin {
  List<double> _points = [];

  AnimationController _controller;
  AnimationController _controller2;
  Animation _animation;
  Animation _animation1;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 4000))
          ..addListener(() {
            _points.add(_animation1.value);
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller2.forward();
            }
          });
    _animation1 = Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: _StairsCurve(5)))
        .animate(_controller);

    _controller.forward();

    _controller2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 6000))
          ..addListener(() {
            setState(() {});
          });

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller2);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 150,
        child: CustomPaint(
          painter: _CurvePainter(
              _points.sublist(0, (_points.length * _animation.value).floor()),
              _points.length),
        ),
      ),
    );
  }
}

class _CurvePainter extends CustomPainter {
  final List<double> points;
  final int totalCount;

  Paint _paint = Paint()
    ..color = Colors.blue
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke;

  _CurvePainter(this.points, this.totalCount);

  @override
  void paint(Canvas canvas, Size size) {
    List<Offset> _points = [];
    var px = (size.width / totalCount);
    for (int i = 0; i < points.length; i++) {
      var f = points[i];
      _points.add(Offset(px * i, size.height - f * size.height));
    }
    canvas.drawPoints(PointMode.polygon, _points, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _StairsCurve extends Curve {
  //阶梯的数量
  final int num;
  double _perStairY;
  double _perStairX;

  _StairsCurve(this.num) {
    _perStairY = 1.0 / (num - 1);
    _perStairX = 1.0 / num;
  }

  @override
  double transformInternal(double t) {
    return _perStairY * (t / _perStairX).floor();
  }
}
