import 'package:flutter/material.dart';
import '../common/delay_tween.dart';
import 'ball.dart';
import 'ball_style.dart';

///
/// desc:
///

class BallGridOpacityLoading extends StatefulWidget {
  final BallStyle ballStyle;
  final Duration duration;
  final Curve curve;

  const BallGridOpacityLoading(
      {Key key,
        this.ballStyle,
        this.duration = const Duration(milliseconds: 2000),
        this.curve = Curves.linear})
      : super(key: key);
  @override
  _BallGridOpacityLoadingState createState() => _BallGridOpacityLoadingState();
}

class _BallGridOpacityLoadingState extends State<BallGridOpacityLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<Animation> _animations = [];

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: widget.duration)
          ..repeat();
    List.generate(9, (index) {
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
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
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
      itemCount: 9,
    );
  }
}
