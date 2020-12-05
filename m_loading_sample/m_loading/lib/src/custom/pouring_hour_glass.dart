import 'dart:math';

import 'package:flutter/material.dart';

///
/// desc: 倒酒杯
///

class PouringHourGlassLoading extends StatefulWidget {
  final Color color;
  final Duration duration;
  final Curve curve;

  const PouringHourGlassLoading(
      {Key key,
        this.color = Colors.white,
        this.duration = const Duration(milliseconds: 2500),
        this.curve = Curves.linear})
      : super(key: key);

  @override
  _PouringHourGlassLoadingState createState() =>
      _PouringHourGlassLoadingState();
}

class _PouringHourGlassLoadingState extends State<PouringHourGlassLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation, _rotateAnimation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: widget.duration)
          ..repeat();

    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.6,curve: widget.curve)));
    _rotateAnimation = Tween(begin: 0.0, end: pi).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.6, 1.0,curve: widget.curve)));

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
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotateAnimation.value,
            child: CustomPaint(
              painter: _PouringHourGlassPainter(_animation.value, widget.color),
            ),
          );
        });
  }
}

class _PouringHourGlassPainter extends CustomPainter {
  final double progress;
  final Color color;

  Paint _paint;

  double _middleWidth = 2;

  _PouringHourGlassPainter(this.progress, this.color) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //酒瓶
    var _path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2 + _middleWidth, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 2 - _middleWidth, size.height / 2)
      ..close();
    canvas.drawPath(_path, _paint);

    //上部三角形
    _paint.style = PaintingStyle.fill;

    double _offsetX = progress * (size.width / 2 - _middleWidth);
    var _topTrianglePath = Path()
      ..moveTo(_offsetX, progress * size.height / 2)
      ..lineTo(size.width - _offsetX, progress * size.height / 2)
      ..lineTo(size.width / 2 + _middleWidth, size.height / 2)
      ..lineTo(size.width / 2 - _middleWidth, size.height / 2)
      ..close();
    canvas.drawPath(_topTrianglePath, _paint);

    //底部三角形
    var _bottomTrianglePath = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width - _offsetX, size.height - progress * size.height / 2)
      ..lineTo(_offsetX, size.height - progress * size.height / 2)
      ..close();
    canvas.drawPath(_bottomTrianglePath, _paint);

    //垂直线条
    _paint.style = PaintingStyle.stroke;
    var _linePath = Path()
      ..moveTo(size.width / 2, size.height / 2)
      ..lineTo(size.width / 2, size.height - progress * size.height / 2)
      ..close();
    canvas.drawPath(_linePath, _paint);
  }

  @override
  bool shouldRepaint(covariant _PouringHourGlassPainter old) {
    return color != old.color || progress != old.progress;
  }
}
