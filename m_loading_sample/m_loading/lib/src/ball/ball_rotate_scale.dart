import 'dart:math';

import 'package:flutter/material.dart';

import 'ball.dart';
import 'ball_style.dart';

///
/// desc:
///

class BallRotateScaleLoading extends StatefulWidget {
  final BallStyle ballStyle;
  final Duration duration;
  final Curve curve;

  const BallRotateScaleLoading({
    Key key,
    this.ballStyle,
    this.duration = const Duration(milliseconds: 1200),
    this.curve = Curves.decelerate,
  }) : super(key: key);

  @override
  _BallRotateScaleLoadingState createState() => _BallRotateScaleLoadingState();
}

class _BallRotateScaleLoadingState extends State<BallRotateScaleLoading>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _controller1;
  Animation _rotateAnimation;
  Animation _scaleAnimation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
    _controller1 = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
    _scaleAnimation = Tween(begin: 1.0, end: 1.3)
        .animate(CurvedAnimation(parent: _controller1, curve: widget.curve));
    _rotateAnimation = Tween(begin: 0.0, end: 1.0)
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
    return RotationTransition(
      turns: _rotateAnimation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Ball(style: widget.ballStyle),
          ScaleTransition(
              scale: _scaleAnimation, child: Ball(style: widget.ballStyle)),
          Ball(style: widget.ballStyle),
        ],
      ),
    );
  }
}
