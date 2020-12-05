import 'dart:math';

import 'package:flutter/material.dart';

import 'ball.dart';
import 'ball_style.dart';

///
/// desc:
///

class BallInsideBallLoading extends StatefulWidget {
  final BallStyle ballStyle;
  final Duration duration;
  final Curve curve;
  final Color backgroundColor;

  const BallInsideBallLoading(
      {Key key,
      this.ballStyle,
      this.backgroundColor = const Color(0x88FFFFFF),
      this.duration = const Duration(milliseconds: 2000),
      this.curve = Curves.linear})
      : super(key: key);

  @override
  _BallInsideBallLoadingState createState() => _BallInsideBallLoadingState();
}

class _BallInsideBallLoadingState extends State<BallInsideBallLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
    _animation = Tween(begin: 0.0, end: 2 * pi)
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
        return Container(
          decoration: BoxDecoration(
              color: widget.backgroundColor, shape: BoxShape.circle),
          alignment: Alignment(
              0.6 * cos(_animation.value), 0.6 * sin(_animation.value)),
          child: Ball(
            style: widget.ballStyle,
          ),
        );
      },
    );
  }
}
