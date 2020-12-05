import 'dart:math';

import 'package:flutter/material.dart';

///
/// desc:
///

class RingClipRotateMultiple extends StatefulWidget {
  final double ballRadius;
  final Color innerColor;
  final Color outerColor;
  final Duration duration;
  final Curve curve;
  final double strokeWidth;

  const RingClipRotateMultiple(
      {Key key,
        this.strokeWidth = 2.0,
        this.ballRadius = 4.0,
        this.innerColor = Colors.white70,
        this.outerColor = Colors.white,
        this.duration = const Duration(milliseconds: 1000),
        this.curve = Curves.easeOutCubic})
      : super(key: key);

  @override
  _RingClipRotateMultipleState createState() => _RingClipRotateMultipleState();
}

class _RingClipRotateMultipleState extends State<RingClipRotateMultiple>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation, _animation1;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: widget.duration)
          ..repeat();

    _animation = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: 0.0)
              .chain(CurveTween(curve: widget.curve)),
          weight: 10),
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: pi)
              .chain(CurveTween(curve: widget.curve)),
          weight: 40),
      TweenSequenceItem(
          tween: Tween(begin: pi, end: pi)
              .chain(CurveTween(curve: widget.curve)),
          weight: 10),
      TweenSequenceItem(
          tween: Tween(begin: pi, end: 2.0 * pi)
              .chain(CurveTween(curve: widget.curve)),
          weight: 40),
    ]).animate(_controller);

    _animation1 = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: 0.0)
              .chain(CurveTween(curve: widget.curve)),
          weight: 10),
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: 1.0)
              .chain(CurveTween(curve: widget.curve)),
          weight: 40),
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 1.0)
              .chain(CurveTween(curve: widget.curve)),
          weight: 10),
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 0.0)
              .chain(CurveTween(curve: widget.curve)),
          weight: 40),
    ]).animate(_controller);

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
          return Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: Transform.rotate(
                    angle: _animation.value,
                    child: FractionallySizedBox(
                      widthFactor: 0.4,
                      heightFactor: 0.4,
                      child: CustomPaint(
                        painter: _RingPainter(color: widget.innerColor),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Transform(
                    transform: Matrix4.identity()
                      ..rotateZ(_animation.value * -1),
                    alignment: Alignment.center,
                    child: FractionallySizedBox(
                      widthFactor: 0.7 + _animation1.value * 0.3,
                      heightFactor: 0.7 + _animation1.value * 0.3,
                      child: CustomPaint(
                        painter: _RingPainter(startAngle: pi / 2,color: widget.outerColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}

class _RingPainter extends CustomPainter {
  final Color color;
  final double startAngle;
  Paint _paint;

  _RingPainter({
    this.startAngle = 0.0,
    this.color = Colors.white,
  }) {
    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double radius = min(size.width, size.height) / 2;

    canvas.drawArc(Rect.fromLTWH(0, 0, radius * 2, radius * 2), startAngle,
        pi * 2 / 3, false, _paint);

    canvas.drawArc(Rect.fromLTWH(0, 0, radius * 2, radius * 2), startAngle + pi,
        pi * 2 / 3, false, _paint);
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) {
    return color != old.color ||
        startAngle != old.startAngle;
  }
}
