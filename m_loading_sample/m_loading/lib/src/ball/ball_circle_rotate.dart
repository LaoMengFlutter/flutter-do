import 'dart:math';

import 'package:flutter/material.dart';

import '../common/circle_flow_delegate.dart';
import 'ball.dart';
import 'ball_style.dart';

///
/// desc:
///

class BallCircleRotateLoading extends StatefulWidget {
  final double radius;
  final int count;
  final BallStyle ballStyle;
  final Duration duration;
  final Curve curve;

  const BallCircleRotateLoading(
      {Key key,
      this.radius = 24,
      this.ballStyle,
      this.count = 11,
      this.duration = const Duration(milliseconds: 1500),
      this.curve = Curves.linear})
      : super(key: key);

  @override
  _BallCircleRotateLoadingState createState() =>
      _BallCircleRotateLoadingState();
}

class _BallCircleRotateLoadingState extends State<BallCircleRotateLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    _animation = _controller.drive(CurveTween(curve: widget.curve));

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
          return Transform.rotate(
            angle: _animation.value * 2 * pi,
            child: Flow(
              delegate: CircleFlowDelegate(widget.radius),
              children: List.generate(widget.count, (index) {
                return Center(
                  child: Opacity(
                    opacity: index * 0.1,
                    child: Ball(
                      style: kDefaultBallStyle.copyWith(
                          size: widget.ballStyle?.size,
                          color: widget.ballStyle?.color,
                          ballType: widget.ballStyle?.ballType,
                          borderWidth: widget.ballStyle?.borderWidth,
                          borderColor: widget.ballStyle?.borderColor),
                    ),
                  ),
                );
              }),
            ),
          );
        });
  }
}
