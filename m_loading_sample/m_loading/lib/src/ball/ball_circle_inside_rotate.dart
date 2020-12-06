import 'dart:math';

import 'package:flutter/material.dart';

import 'ball.dart';
import 'ball_painter.dart';
import 'ball_style.dart';

///
/// desc:
///

class BallCircleInsideRotateLoading extends StatefulWidget {
  final BallStyle ballStyle;
  final Duration duration;
  final Curve curve;

  const BallCircleInsideRotateLoading(
      {Key key,
      this.ballStyle,
      this.duration = const Duration(milliseconds: 6000),
      this.curve = Curves.linear})
      : super(key: key);

  @override
  _BallCircleInsideRotateLoadingState createState() =>
      _BallCircleInsideRotateLoadingState();
}

class _BallCircleInsideRotateLoadingState
    extends State<BallCircleInsideRotateLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation, _animation1;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    _animation = Tween(begin: 0.0, end: 2 * pi)
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    _animation1 = Tween(begin: 0.0, end: 4 * pi)
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

    BallStyle _ballStyle = kDefaultBallStyle.copyWith(
        size: widget.ballStyle?.size??5.0,
        color: widget.ballStyle?.color,
        ballType: widget.ballStyle?.ballType,
        borderWidth: widget.ballStyle?.borderWidth,
        borderColor: widget.ballStyle?.borderColor);

    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: Transform.rotate(
                  angle: _animation.value,
                  child: CustomPaint(
                    painter: BallPainter(ballStyles: [_ballStyle], count: 8),
                  ),
                ),
              ),
              Positioned.fill(
                child: Transform.rotate(
                  angle: _animation1.value * -1,
                  child: FractionallySizedBox(
                    widthFactor: 0.4,
                    heightFactor: 0.4,
                    child: CustomPaint(
                      painter:
                      BallPainter(ballStyles: [_ballStyle],  count: 4),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}
