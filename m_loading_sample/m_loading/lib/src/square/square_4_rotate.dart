import 'dart:math';

import 'package:flutter/material.dart';

import 'square.dart';

///
/// desc: TODO
///

class Square4RotateLoading extends StatefulWidget {
  final Color color;
  final Duration duration;
  final Curve curve;

  const Square4RotateLoading(
      {Key key,
      this.color = Colors.white,
      this.duration = const Duration(milliseconds: 3000),
      this.curve = Curves.linear})
      : super(key: key);

  @override
  _Square4RotateLoadingState createState() => _Square4RotateLoadingState();
}

class _Square4RotateLoadingState extends State<Square4RotateLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation, _animation1, _animation2, _animation3;

  double _size = 50;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.0, 0.25, curve: widget.curve)));

    _animation1 = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.25, 0.50, curve: widget.curve)));

    _animation2 = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.50, 0.75, curve: widget.curve)));

    _animation3 = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.75, 1.0, curve: widget.curve)));
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
        return Stack(
          children: [
            Positioned.fill(
                top: 0.0,
                left: 0.0,
                right: _size * 0.5,
                bottom: _size * 0.5,
                child: Transform(
                  transform: Matrix4.rotationY(_animation.value * pi),
                  alignment: Alignment.centerRight,
                  child: Square(
                    color: widget.color.withOpacity(1 - _animation.value),
                  ),
                )),
            Positioned.fill(
                top: 0.0,
                left: _size * 0.5,
                right: 0.0,
                bottom: _size * 0.5,
                child: Transform(
                  transform: Matrix4.rotationX(_animation1.value * pi),
                  alignment: Alignment.bottomCenter,
                  child: Square(
                    color: widget.color.withOpacity(1 - _animation1.value),
                  ),
                )),
            Positioned.fill(
                top: _size * 0.5,
                left: _size * 0.5,
                right: 0.0,
                bottom: 0.0,
                child: Transform(
                  transform: Matrix4.rotationY(_animation2.value * pi),
                  alignment: Alignment.centerLeft,
                  child: Square(
                    color: widget.color.withOpacity(1 - _animation2.value),
                  ),
                )),
            Positioned.fill(
                top: _size * 0.5,
                left: 0,
                bottom: 0,
                right: _size * 0.5,
                child: Transform(
                  transform: Matrix4.rotationX(_animation3.value * pi),
                  alignment: Alignment.topCenter,
                  child: Square(
                    color: widget.color,
                  ),
                )),
          ],
        );
      },
    );
  }
}
