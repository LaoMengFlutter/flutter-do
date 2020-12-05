import 'dart:math';

import 'package:flutter/material.dart';

import 'circle.dart';

///
/// desc:
///

class CircleRotateLoading extends StatefulWidget {
  final Color color;
  final Duration duration;
  final Curve curve;

  const CircleRotateLoading(
      {Key key,
        this.color = Colors.white,
        this.duration = const Duration(milliseconds: 1500),
        this.curve = Curves.linear})
      : super(key: key);

  @override
  _CircleRotateLoadingState createState() => _CircleRotateLoadingState();
}

class _CircleRotateLoadingState extends State<CircleRotateLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _horizontalAnimation, _verticalAnimation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1500))
          ..repeat();

    _verticalAnimation = Tween(begin: 0.0, end: pi).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.4,curve: widget.curve)));

    _horizontalAnimation = Tween(begin: 0.0, end: pi).animate(
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
          return Transform(
              transform: Matrix4.rotationX(_verticalAnimation.value),
              alignment: Alignment.center,
              child: Transform(
                transform: Matrix4.rotationY(_horizontalAnimation.value),
                alignment: Alignment.center,
                child: Circle(
                  color: widget.color,
                ),
              ));
        });
  }
}
