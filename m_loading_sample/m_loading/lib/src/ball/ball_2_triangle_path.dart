import 'package:flutter/material.dart';
import 'package:m_loading/src/ball/ball.dart';

import 'ball_style.dart';

///
/// desc:
///
class Ball2TrianglePathLoading extends StatefulWidget {
  final BallStyle ballStyle;
  final Duration duration;
  final Curve curve;

  const Ball2TrianglePathLoading(
      {Key key,
      this.ballStyle,
      this.duration = const Duration(milliseconds: 1200),
      this.curve = Curves.easeIn})
      : super(key: key);

  @override
  _Ball2TrianglePathLoadingState createState() =>
      _Ball2TrianglePathLoadingState();
}

class _Ball2TrianglePathLoadingState extends State<Ball2TrianglePathLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  Animation _animation1;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);

    _animation = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: Alignment(0.0, 1.0), end: Alignment(-1.0, -1.0))
              .chain(CurveTween(curve: widget.curve)),
          weight: 30),
      TweenSequenceItem(
          tween: Tween(begin: Alignment(-1.0, -1.0), end: Alignment(1.0, -1.0))
              .chain(CurveTween(curve: widget.curve)),
          weight: 40),
      TweenSequenceItem(
          tween: Tween(begin: Alignment(1.0, -1.0), end: Alignment(0.0, 1.0))
              .chain(CurveTween(curve: widget.curve)),
          weight: 30),
    ]).animate(_controller);

    _animation1 = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: Alignment(0.0, -1.0), end: Alignment(1.0, 1.0))
              .chain(CurveTween(curve: widget.curve)),
          weight: 30),
      TweenSequenceItem(
          tween: Tween(begin: Alignment(1.0, 1.0), end: Alignment(-1.0, 1.0))
              .chain(CurveTween(curve: widget.curve)),
          weight: 40),
      TweenSequenceItem(
          tween: Tween(begin: Alignment(-1.0, 1.0), end: Alignment(0.0, -1.0))
              .chain(CurveTween(curve: widget.curve)),
          weight: 30),
    ]).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AlignTransition(
            alignment: _animation,
            child: Ball(style: widget.ballStyle),
          ),
        ),
        Expanded(
            child: AlignTransition(
          alignment: _animation1,
          child: Ball(style: widget.ballStyle),
        )),
      ],
    );
  }
}
