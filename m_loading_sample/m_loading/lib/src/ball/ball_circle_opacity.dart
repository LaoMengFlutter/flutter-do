import 'dart:math';

import 'package:flutter/material.dart';
import 'package:m_loading/src/ball/ball_painter.dart';

import 'ball.dart';
import 'ball_style.dart';

///
/// desc:
///

class BallCircleOpacityLoading extends StatefulWidget {
  final BallStyle ballStyle;
  final Duration duration;
  final Curve curve;
  final int count;

  const BallCircleOpacityLoading(
      {Key key,
      this.ballStyle,
      this.count = 8,
      this.duration = const Duration(milliseconds: 1200),
      this.curve = Curves.linear})
      : super(key: key);

  @override
  _BallCircleOpacityLoadingState createState() =>
      _BallCircleOpacityLoadingState();
}

class _BallCircleOpacityLoadingState extends State<BallCircleOpacityLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  List<double> opacity = [0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.9, 1.0];
  List<List<BallStyle>> _styles = [];

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    _animation = _controller.drive(CurveTween(curve: widget.curve));

    List.generate(opacity.length, (index) {
      List<double> _opacityIndexList = [];
      _opacityIndexList
          .addAll(opacity.sublist(opacity.length - index, opacity.length));
      _opacityIndexList.addAll(opacity.sublist(0, opacity.length - index));

      List<BallStyle> _styleList = [];
      for (int i = 0; i < opacity.length; i++) {
        _styleList.add(
          kDefaultBallStyle.copyWith(
              size: widget.ballStyle?.size ?? 5.0,
              color: widget.ballStyle?.color?.withOpacity(_opacityIndexList[i]),
              ballType: widget.ballStyle?.ballType,
              borderWidth: widget.ballStyle?.borderWidth,
              borderColor: widget.ballStyle?.borderColor
                  ?.withOpacity(_opacityIndexList[i])),
        );
      }
      _styles.add(_styleList);
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
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          var index = (_animation.value * opacity.length).floor();
          return CustomPaint(
            painter:
                BallPainter(ballStyles: _styles[index], count: widget.count),
          );
        });
  }
}
