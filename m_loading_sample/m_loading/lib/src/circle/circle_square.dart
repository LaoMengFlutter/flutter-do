import 'dart:math';

import 'package:flutter/material.dart';
import 'package:m_loading/src/common/delay_tween.dart';

///
/// desc:
///

class CircleSquareLoading extends StatefulWidget {
  final double size;
  final Color color;
  final Duration duration;
  final Curve curve;

  const CircleSquareLoading(
      {Key key,
      this.color = Colors.white,
      this.size = 30,
      this.duration = const Duration(milliseconds: 800),
      this.curve = Curves.linear})
      : super(key: key);

  @override
  _CircleSquareLoadingState createState() => _CircleSquareLoadingState();
}

class _CircleSquareLoadingState extends State<CircleSquareLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);

    _animation = CurveTween(curve: widget.curve).animate(_controller);
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
          var size = widget.size - (_animation.value * widget.size / 2);
          return Center(
            child: Transform(
              transform: Matrix4.rotationZ(_animation.value * pi * 1.5),
              alignment: Alignment.center,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(
                        _animation.value * widget.size / 2)),
              ),
            ),
          );
        });
  }
}
