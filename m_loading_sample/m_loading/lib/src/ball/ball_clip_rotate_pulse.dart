import 'dart:math';

import 'package:flutter/material.dart';

import 'ball.dart';
import 'ball_style.dart';

///
/// desc:
///

class BallClipRotatePulseLoading extends StatefulWidget {
  final BallStyle ballStyle;
  final Duration duration;
  final Curve curve;
  final Color ringColor;
  final double ringWidth;

  const BallClipRotatePulseLoading({
    Key key,
    this.ballStyle,
    this.duration = const Duration(milliseconds: 2000),
    this.curve = Curves.easeOutCubic,
    this.ringColor = Colors.white,
    this.ringWidth = 2.0,
  }) : super(key: key);

  @override
  _BallClipRotatePulseLoadingState createState() =>
      _BallClipRotatePulseLoadingState();
}

class _BallClipRotatePulseLoadingState extends State<BallClipRotatePulseLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation, _scaleAnim;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    _animation = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: 0.0)
              .chain(CurveTween(curve: widget.curve)),
          weight: 10),
      TweenSequenceItem(
          tween:
              Tween(begin: 0.0, end: pi).chain(CurveTween(curve: widget.curve)),
          weight: 40),
      TweenSequenceItem(
          tween:
              Tween(begin: pi, end: pi).chain(CurveTween(curve: widget.curve)),
          weight: 10),
      TweenSequenceItem(
          tween: Tween(begin: pi, end: 2.0 * pi)
              .chain(CurveTween(curve: widget.curve)),
          weight: 40),
    ]).animate(_controller);

    _scaleAnim = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 1.0)
              .chain(CurveTween(curve: widget.curve)),
          weight: 10),
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 2.0)
              .chain(CurveTween(curve: widget.curve)),
          weight: 40),
      TweenSequenceItem(
          tween: Tween(begin: 2.0, end: 2.0)
              .chain(CurveTween(curve: widget.curve)),
          weight: 10),
      TweenSequenceItem(
          tween: Tween(begin: 2.0, end: 1.0)
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
          return Transform(
            transform: Matrix4.identity()
              ..rotateZ(_animation.value)
              ..scale(1.0, 1.0),
            alignment: Alignment.center,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Center(
                    child: Transform.scale(
                      scale: _scaleAnim.value,
                      child: Ball(
                        style: widget.ballStyle,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: CustomPaint(
                    painter: _RingPainter(
                        color: widget.ringColor, strokeWidth: widget.ringWidth),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class _RingPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  Paint _paint;

  _RingPainter({this.color, this.strokeWidth}) {
    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double radius = min(size.width, size.height) / 2;

    canvas.drawArc(Rect.fromLTWH(0, 0, radius * 2, radius * 2), -pi * 5 / 6,
        pi * 2 / 3, false, _paint);

    canvas.drawArc(Rect.fromLTWH(0, 0, radius * 2, radius * 2), pi / 6,
        pi * 2 / 3, false, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
