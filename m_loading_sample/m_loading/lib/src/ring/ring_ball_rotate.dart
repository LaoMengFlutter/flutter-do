import 'dart:math';

import 'package:flutter/material.dart';

///
/// desc:
///

class RingBallRotateLoading extends StatefulWidget {
  final double ballRadius;
  final Color circleColor;
  final Color ballColor;
  final Duration duration;
  final Curve curve;
  final double strokeWidth;

  const RingBallRotateLoading(
      {Key key,
      this.strokeWidth = 2.0,
      this.ballRadius = 4.0,
      this.circleColor = Colors.white70,
      this.ballColor = Colors.white,
      this.duration = const Duration(milliseconds: 1000),
      this.curve = Curves.decelerate})
      : super(key: key);

  @override
  _RingBallRotateLoadingState createState() => _RingBallRotateLoadingState();
}

class _RingBallRotateLoadingState extends State<RingBallRotateLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    _animation = Tween(begin: -pi / 2, end: 3 * pi / 2)
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve));
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
            painter: _CircleBallRotatePainter(
                angle: _animation.value,
                ballColor: widget.ballColor,
                circleColor: widget.circleColor,
                strokeWidth: widget.strokeWidth,
                ballRadius: widget.ballRadius),
          );
        });
  }
}

class _CircleBallRotatePainter extends CustomPainter {
  final double angle;
  final double strokeWidth;
  final double ballRadius;
  final Color circleColor;
  final Color ballColor;

  Paint _circlePaint;
  Paint _ballPaint;

  _CircleBallRotatePainter(
      {this.angle = 0.0,
      this.strokeWidth = 2.0,
      this.ballRadius = 4.0,
      this.circleColor = Colors.white70,
      this.ballColor = Colors.white}) {
    _circlePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = circleColor;

    _ballPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = ballColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double radius = min(size.width, size.height) / 2;

    canvas.drawArc(Rect.fromLTWH(0, 0, radius * 2, radius * 2), 0, 2 * pi,
        false, _circlePaint);

    canvas.drawCircle(
        Offset(radius + radius * cos(angle), radius + radius * sin(angle)),
        ballRadius,
        _ballPaint);
  }
  @override
  bool shouldRepaint(covariant _CircleBallRotatePainter old) {
    return angle != old.angle ||
        ballRadius != old.ballRadius ||
        circleColor != old.circleColor ||
        strokeWidth != old.strokeWidth ||
        ballColor != old.ballColor;
  }
}
