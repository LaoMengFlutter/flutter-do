import 'dart:math';

import 'package:flutter/material.dart';

///
/// desc:
///

class Circle2InsideScaleLoading extends StatefulWidget {
  final Color smallCircleColor;
  final Color bigCircleColor;
  final Duration duration;
  final Curve curve;

  const Circle2InsideScaleLoading({
    Key key,
    this.smallCircleColor = Colors.white,
    this.bigCircleColor,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeInOut,
  }) : super(key: key);

  @override
  _Circle2InsideScaleLoadingState createState() =>
      _Circle2InsideScaleLoadingState();
}

class _Circle2InsideScaleLoadingState extends State<Circle2InsideScaleLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    _animation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.5), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 0.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

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
            painter: _Circle2InsideScalePainter(
                _animation.value,
                widget.smallCircleColor,
                widget.bigCircleColor ??
                    widget.smallCircleColor.withOpacity(0.3)),
          );
        });
  }
}

class _Circle2InsideScalePainter extends CustomPainter {
  final double progress;
  final Color smallCircleColor;
  final Color bigCircleColor;

  Paint _smallPaint;
  Paint _bigPaint;

  _Circle2InsideScalePainter(
      this.progress, this.smallCircleColor, this.bigCircleColor) {
    _smallPaint = Paint()..color = smallCircleColor;
    _bigPaint = Paint()..color = bigCircleColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double radius = min(size.height, size.width) / 2;

    canvas.drawCircle(Offset(size.height / 2, size.width / 2),
        (1 - progress) * radius, _bigPaint);
    canvas.drawCircle(Offset(size.height / 2, size.width / 2),
        progress * radius, _smallPaint);
  }

  @override
  bool shouldRepaint(covariant _Circle2InsideScalePainter old) {
    return progress != old.progress ||
        smallCircleColor != old.smallCircleColor ||
        bigCircleColor != old.bigCircleColor;
  }
}
