import 'dart:math';

import 'package:flutter/material.dart';

import 'ball.dart';
import 'ball_style.dart';

///
/// desc:
///

class Ball3TrianglePathLoading extends StatefulWidget {
  final BallStyle ballStyle;
  final Duration rotateDuration;
  final Duration translateDuration;
  final Curve rotateCurve;
  final Curve translateCurve;
  final double minRadius;
  final double maxRadius;

  const Ball3TrianglePathLoading({
    Key key,
    this.ballStyle,
    this.rotateDuration = const Duration(milliseconds: 800),
    this.translateDuration = const Duration(milliseconds: 1600),
    this.rotateCurve = Curves.linear,
    this.translateCurve = Curves.linear,
    this.minRadius = 8.0,
    this.maxRadius = 20.0,
  }) : super(key: key);

  @override
  _Ball3TrianglePathLoadingState createState() =>
      _Ball3TrianglePathLoadingState();
}

class _Ball3TrianglePathLoadingState extends State<Ball3TrianglePathLoading>
    with TickerProviderStateMixin {
  AnimationController _controller, _controller1;
  Animation _animation, _animation1;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: widget.rotateDuration)
          ..repeat(reverse: true);
    _animation = _controller.drive(CurveTween(curve: widget.rotateCurve));

    _controller1 =
        AnimationController(vsync: this, duration: widget.translateDuration)
          ..repeat();
    _animation1 = _controller1.drive(CurveTween(curve: widget.translateCurve));
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
            angle: _animation1.value * 2 * pi,
            child: Flow(
              delegate: _TriangleFlow(widget.minRadius +
                  _animation.value * (widget.maxRadius - widget.minRadius)),
              children: [
                UnconstrainedBox(
                  child: Ball(
                    style: widget.ballStyle,
                  ),
                ),
                UnconstrainedBox(
                  child: Ball(
                    style: widget.ballStyle,
                  ),
                ),
                UnconstrainedBox(
                  child: Ball(
                    style: widget.ballStyle,
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class _TriangleFlow extends FlowDelegate {
  final double radius;

  _TriangleFlow(this.radius);

  @override
  void paintChildren(FlowPaintingContext context) {
    double x = 0; //开始(0,0)在父组件的中心
    double y = 0;
    for (int i = 0; i < context.childCount; i++) {
      x = radius * cos(i * 2 * pi / (context.childCount)); //根据数学得出坐标
      y = radius * sin(i * 2 * pi / (context.childCount)); //根据数学得出坐标
      context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) => true;
}
