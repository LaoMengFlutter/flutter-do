import 'dart:math';

import 'package:flutter/material.dart';

import 'circle_painter.dart';

///
/// desc:
///

class WaterCircleLoading extends StatefulWidget {
  final Color color;
  final Duration duration;
  final Curve curve;

  const WaterCircleLoading(
      {Key key,
      this.color = Colors.white,
      this.duration = const Duration(milliseconds: 2000),
      this.curve = Curves.linear})
      : super(key: key);

  @override
  _WaterCircleLoadingState createState() => _WaterCircleLoadingState();
}

class _WaterCircleLoadingState extends State<WaterCircleLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation _widthAnimation, _opacityAnimation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    _widthAnimation = Tween(begin: 1.0, end: 3.0)
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _opacityAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 50),
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
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: CirclePainter(
                progress: _controller.value,
                strokeWidth: _widthAnimation.value,
                color: widget.color.withOpacity(_opacityAnimation.value)),
          );
        });
  }
}
