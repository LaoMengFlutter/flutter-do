import 'package:flutter/material.dart';
import '../common/delay_tween.dart';
import 'ball.dart';
import 'ball_style.dart';

///
/// desc:
///

class BallBounceLoading extends StatefulWidget {
  final BallStyle ballStyle;
  final Duration duration;
  final Curve curve;

  const BallBounceLoading(
      {Key key,
        this.ballStyle,
        this.duration = const Duration(milliseconds: 800),
        this.curve = Curves.linear})
      : super(key: key);
  @override
  _BallBounceLoadingState createState() => _BallBounceLoadingState();
}

class _BallBounceLoadingState extends State<BallBounceLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<Animation> _animations = [];

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: widget.duration)
          ..repeat();
    List.generate(3, (index) {
      _animations.add(DelayTween(begin: 0.0, end: 1.0, delay: 0.2 * index)
          .animate(CurvedAnimation(parent: _controller, curve: widget.curve)));
    });
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
          padding: EdgeInsets.symmetric(horizontal: 3),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Align(
                alignment: Alignment(0.0, 0.4 * _animations[index].value),
                child: Ball(style: widget.ballStyle,),
              );
            },
          ),
        );
      }),
    );
  }
}
