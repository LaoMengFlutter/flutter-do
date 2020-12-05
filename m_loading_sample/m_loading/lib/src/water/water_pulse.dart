import 'dart:math';

import 'package:flutter/material.dart';

import 'circle_painter.dart';

///
/// desc:
///

class WaterPulseLoading extends StatefulWidget {
  final Color color;
  final Duration duration;
  final Curve curve;

  const WaterPulseLoading(
      {Key key,
      this.color = Colors.white,
      this.duration = const Duration(milliseconds: 2000),
      this.curve = Curves.linear})
      : super(key: key);

  @override
  _WaterPulseLoadingState createState() => _WaterPulseLoadingState();
}

class _WaterPulseLoadingState extends State<WaterPulseLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation, _animation1, _animation2, _animation3, _animation4;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    _animation = CurveTween(curve: Interval(0.0, 0.4, curve: widget.curve))
        .animate(_controller);
    _animation1 = CurveTween(curve: Interval(0.15, 0.55, curve: widget.curve))
        .animate(_controller);
    _animation2 = CurveTween(curve: Interval(0.3, 0.7, curve: widget.curve))
        .animate(_controller);
    _animation3 = CurveTween(curve: Interval(0.45, 0.85, curve: widget.curve))
        .animate(_controller);
    _animation4 = CurveTween(curve: Interval(0.6, 1.0, curve: widget.curve))
        .animate(_controller);

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
              _item(_animation),
              _item(_animation1),
              _item(_animation2),
              _item(_animation3),
              _item(_animation4),
            ],
          );
        });
  }

  _item(Animation animation) {
    var opacity = max(0.0, 1 - animation.value);
    return Positioned.fill(
        child: Center(
      child: FractionallySizedBox(
        widthFactor: animation.value,
        heightFactor: animation.value,
        child: CustomPaint(
          painter: _CirclePainter(
              progress: _controller.value,
              color: widget.color.withOpacity(opacity)),
        ),
      ),
    ));
  }
}

class _CirclePainter extends CustomPainter {
  final double progress;

  final Color color;

  Paint _paint = Paint();

  _CirclePainter(
      {this.progress = 0.0, this.color = Colors.red});

  @override
  void paint(Canvas canvas, Size size) {
    _paint
      ..style = PaintingStyle.fill
      ..color = color;

    double radius = min(size.width, size.height) / 2;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), radius * progress, _paint);
  }

  @override
  bool shouldRepaint(covariant _CirclePainter old) {
    return progress != old.progress ||
        color != old.color;
  }
}
