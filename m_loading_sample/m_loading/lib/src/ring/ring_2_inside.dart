import 'dart:math';

import 'package:flutter/material.dart';

///
/// desc:
///

class Ring2InsideLoading extends StatefulWidget {
  final Color color;
  final Color backgroundColor;
  final Duration duration;
  final Curve curve;
  final double strokeWidth;

  const Ring2InsideLoading(
      {Key key,
      this.color = Colors.white,
      this.backgroundColor,
      this.strokeWidth = 8.0,
      this.duration = const Duration(milliseconds: 1000),
      this.curve = Curves.linear})
      : super(key: key);

  @override
  _Ring2InsideLoadingState createState() => _Ring2InsideLoadingState();
}

class _Ring2InsideLoadingState extends State<Ring2InsideLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
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
            painter: _Ring2InsidePainter(
                startAngle: _animation.value * 2 * pi,
                sweepAngle: 0.3 * pi,
                strokeWidth: widget.strokeWidth,
                color: widget.color,
                backgroundColor:
                    widget.backgroundColor ?? widget.color.withOpacity(0.4)),
          );
        });
  }
}

class _Ring2InsidePainter extends CustomPainter {
  final double startAngle;

  final double sweepAngle;
  final double strokeWidth;
  final StrokeCap strokeCap;
  final Color color;
  final Color backgroundColor;

  Paint _paint;
  Paint _backgroundPaint;

  _Ring2InsidePainter({
    this.startAngle = 0.0,
    this.sweepAngle = 2 * pi,
    this.strokeWidth = 8.0,
    this.strokeCap = StrokeCap.round,
    this.color = Colors.white,
    this.backgroundColor = Colors.white54,
  }) {
    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap
      ..color = color;

    _backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap
      ..color = backgroundColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double radius = min(size.width, size.height) / 2;

    canvas.drawArc(Rect.fromLTWH(0, 0, radius * 2, radius * 2), 0, 2 * pi,
        false, _backgroundPaint);

    canvas.drawArc(Rect.fromLTWH(0, 0, radius * 2, radius * 2), startAngle,
        sweepAngle, false, _paint);
  }

  @override
  bool shouldRepaint(covariant _Ring2InsidePainter old) {
    return color != old.color ||
        startAngle != old.startAngle ||
        sweepAngle != old.sweepAngle ||
        strokeWidth != old.strokeWidth ||
        strokeCap != old.strokeCap ||
        backgroundColor != old.backgroundColor;
  }
}
