import 'dart:math';

import 'package:flutter/material.dart';

///
/// desc:
///

class Ring2SymmetryLoading extends StatefulWidget {

  final Color color;
  final Duration duration;
  final Curve curve;
  final double strokeWidth;

  const Ring2SymmetryLoading(
      {Key key,
        this.color = Colors.white,
        this.strokeWidth = 8.0,
        this.duration = const Duration(milliseconds: 1000),
        this.curve = Curves.linear})
      : super(key: key);

  @override
  _Ring2SymmetryLoadingState createState() => _Ring2SymmetryLoadingState();
}

class _Ring2SymmetryLoadingState extends State<Ring2SymmetryLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
Animation _animation;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: widget.duration)
          ..repeat();
    _animation = CurveTween(curve: widget.curve).animate(_controller);
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
          return CustomPaint(
            painter: _Ring2SymmetryPainter(
                startAngle: _animation.value * 2 * pi,color: widget.color,strokeWidth: widget.strokeWidth),
          );
        });
  }
}

class _Ring2SymmetryPainter extends CustomPainter {
  final double startAngle;
  final double sweepAngle;
  final double strokeWidth;
  final StrokeCap strokeCap;
  final Color color;

  Paint _paint;

  _Ring2SymmetryPainter({
    this.startAngle = 0.0,
    this.sweepAngle = 0.5 * pi,
    this.strokeWidth = 8.0,
    this.strokeCap = StrokeCap.butt,
    this.color = Colors.white,
  }) {
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

    canvas.drawArc(Rect.fromLTWH(0, 0, radius * 2, radius * 2), startAngle + pi,
        sweepAngle, false, _paint);
  }

  @override
  bool shouldRepaint(covariant _Ring2SymmetryPainter old) {
    return color != old.color ||
        startAngle != old.startAngle ||
        sweepAngle != old.sweepAngle ||
        strokeWidth != old.strokeWidth ||
        strokeCap != old.strokeCap;
  }
}
