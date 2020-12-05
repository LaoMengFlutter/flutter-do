import 'dart:math';

import 'package:flutter/material.dart';

import 'circle_painter.dart';

///
/// desc:
///

class WaterMultipleCircleLoading extends StatefulWidget {
  final Color color;
  final Duration duration;
  final Curve curve;

  const WaterMultipleCircleLoading(
      {Key key,
      this.color = Colors.white,
      this.duration = const Duration(milliseconds: 1500),
      this.curve = Curves.linear})
      : super(key: key);

  @override
  _WaterMultipleCircleLoadingState createState() =>
      _WaterMultipleCircleLoadingState();
}

class _WaterMultipleCircleLoadingState extends State<WaterMultipleCircleLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation, _animation1, _animation2, _animation3;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    _animation = CurveTween(curve: Interval(0.0, 0.7, curve: widget.curve))
        .animate(_controller);
    _animation1 = CurveTween(curve: Interval(0.15, 0.8, curve: widget.curve))
        .animate(_controller);
    _animation2 = CurveTween(curve: Interval(0.3, 0.9, curve: widget.curve))
        .animate(_controller);
    _animation3 = CurveTween(curve: Interval(0.45, 1.0, curve: widget.curve))
        .animate(_controller);

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
              _item(_animation),
              _item(_animation1),
              _item(_animation2),
              _item(_animation3),
            ],
          );
        });
  }

  _item(Animation animation) {
    return Positioned.fill(
        child: Center(
      child: FractionallySizedBox(
        widthFactor: animation.value,
        heightFactor: animation.value,
        child: CustomPaint(
          painter: CirclePainter(
              progress: _controller.value,
              color: widget.color.withOpacity(animation.value)),
        ),
      ),
    ));
  }
}
