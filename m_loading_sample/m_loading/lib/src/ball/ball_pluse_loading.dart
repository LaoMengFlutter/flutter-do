import 'package:flutter/material.dart';
import '../common/delay_tween.dart';
import 'ball.dart';

///
/// desc:小球脉冲效果
///

class BallPulseLoading extends StatefulWidget {
  final double minRadius;
  final double maxRadius;
  final int count;
  final Duration duration;

  const BallPulseLoading(
      {Key key,
      this.minRadius = 0.0,
      this.maxRadius = 50.0,
      this.count = 3,
      this.duration = const Duration(milliseconds: 800)})
      : super(key: key);

  @override
  _BallPulseLoadingState createState() => _BallPulseLoadingState();
}

class _BallPulseLoadingState extends State<BallPulseLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
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
      children: List.generate(widget.count, (index) {
        return ScaleTransition(
          scale: DelayTween(begin: 0.0, end: 1.0, delay: index * .2)
              .animate(_controller),
          child: Ball(),
        );
      }),
    );
  }
}
