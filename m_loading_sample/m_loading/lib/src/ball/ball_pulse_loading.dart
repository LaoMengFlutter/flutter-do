import 'package:flutter/material.dart';
import '../common/delay_tween.dart';
import 'ball.dart';
import 'ball_style.dart';

///
/// desc:小球脉冲效果
///
class BallPulseLoading extends StatefulWidget {
  final BallStyle ballStyle;
  final Duration duration;
  final Curve curve;

  const BallPulseLoading({
    Key key,
    this.ballStyle,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.linear,
    this.padding = const EdgeInsets.symmetric(horizontal: 3),
  }) : super(key: key);

  final EdgeInsets padding;

  @override
  _BallPulseLoadingState createState() => _BallPulseLoadingState();
}

class _BallPulseLoadingState extends State<BallPulseLoading>
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
    return Row(
      children: List.generate(3, (index) {
        return Padding(
          padding: widget.padding,
          child: ScaleTransition(
            scale: DelayTween(begin: 0.0, end: 1.0, delay: index * .2)
                .animate(_animation),
            child: Ball(
              style: widget.ballStyle,
            ),
          ),
        );
      }),
    );
  }
}
