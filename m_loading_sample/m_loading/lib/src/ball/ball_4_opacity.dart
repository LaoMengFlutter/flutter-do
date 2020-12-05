import 'package:flutter/material.dart';
import '../common/delay_tween.dart';
import 'ball.dart';
import 'ball_style.dart';

///
/// desc:
///

class Ball4OpacityLoading extends StatefulWidget {
  final BallStyle ballStyle;
  final Duration duration;
  final Curve curve;

  const Ball4OpacityLoading(
      {Key key,
        this.ballStyle,
        this.duration = const Duration(milliseconds: 1200),
        this.curve = Curves.linear})
      : super(key: key);
  @override
  _Ball4OpacityLoadingState createState() => _Ball4OpacityLoadingState();
}

class _Ball4OpacityLoadingState extends State<Ball4OpacityLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<Animation> _animations = [];

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: widget.duration)
          ..repeat();
    List.generate(4, (index) {
      _animations.add(DelayTween(begin: 0.0, end: 1.0, delay: 0.3 * index)
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
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _animations[index].value,
                child: Ball(style: widget.ballStyle,),
              );
            },
          ),
        );
      },
      itemCount: 4,
    );
  }
}
