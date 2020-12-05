import 'dart:math';

import 'package:flutter/material.dart';

import 'ring_painter.dart';

///
/// desc:
///

class RingRotate extends StatefulWidget {
  final Color color;
  final Duration duration;
  final Curve curve;
  final double strokeWidth;

  const RingRotate(
      {Key key,
      this.color = Colors.white,
      this.strokeWidth = 8.0,
      this.duration = const Duration(milliseconds: 1000),
      this.curve = Curves.linear})
      : super(key: key);

  @override
  _RingRotateState createState() => _RingRotateState();
}

class _RingRotateState extends State<RingRotate>
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
            painter: RingPainter(
                startAngle: _animation.value * 2 * pi,
                sweepAngle: 1.5 * pi,
                strokeWidth: widget.strokeWidth,
                color: widget.color),
          );
        });
  }
}
