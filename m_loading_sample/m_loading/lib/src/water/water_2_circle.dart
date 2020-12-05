import 'dart:math';

import 'package:flutter/material.dart';

///
/// desc:
///

class Water2CircleLoading extends StatefulWidget {
  final Color color;
  final Duration duration;
  final Curve curve;

  const Water2CircleLoading(
      {Key key,
        this.color = Colors.white,
        this.duration = const Duration(milliseconds: 2000),
        this.curve = Curves.linear})
      : super(key: key);

  @override
  _Water2CircleLoadingState createState() => _Water2CircleLoadingState();
}

class _Water2CircleLoadingState extends State<Water2CircleLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _progressAnimation1,
      _progressAnimation2,
      _widthAnimation1,
      _widthAnimation2,
      _opacityAnimation1,
      _opacityAnimation2;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: widget.duration)
          ..repeat();

    _progressAnimation1 = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.1, 0.7,curve: widget.curve)));
    _progressAnimation2 = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve:  Interval(0.3, 1.0,curve: widget.curve)));

    _widthAnimation1 = Tween(begin: 1.0, end: 3.0).animate(
        CurvedAnimation(parent: _controller, curve:  Interval(0.1, 0.7,curve: widget.curve)));
    _widthAnimation2 = Tween(begin: 1.0, end: 3.0).animate(
        CurvedAnimation(parent: _controller, curve:  Interval(0.3, 1.0,curve: widget.curve)));

    _opacityAnimation1 = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 50),
    ]).animate(
        CurvedAnimation(parent: _controller, curve:  Interval(0.1, 0.7,curve: widget.curve)));

    _opacityAnimation2 = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 50),
    ]).animate(
        CurvedAnimation(parent: _controller, curve:  Interval(0.3, 1.0,curve: widget.curve)));

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
          return CustomPaint(
            painter: _CirclePainter(
                progress1: _progressAnimation1.value,
                progress2: _progressAnimation2.value,
                strokeWidth1: _widthAnimation1.value,
                strokeWidth2: _widthAnimation2.value,
                color1: widget.color.withOpacity(_opacityAnimation1.value),
                color2: widget.color.withOpacity(_opacityAnimation2.value)),
          );
        });
  }
}

class _CirclePainter extends CustomPainter {
  final double progress1;
  final double strokeWidth1;
  final Color color1;

  final double progress2;
  final double strokeWidth2;
  final Color color2;

  Paint _paint1 = Paint()..style = PaintingStyle.stroke;
  Paint _paint2 = Paint()..style = PaintingStyle.stroke;

  _CirclePainter(
      {this.progress1 = 0.0,
      this.strokeWidth1 = 1.0,
      this.color1 = Colors.white,
      this.progress2 = 0.0,
      this.strokeWidth2 = 1.0,
      this.color2 = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    _paint1
      ..strokeWidth = strokeWidth1
      ..color = color1;

    _paint2
      ..strokeWidth = strokeWidth2
      ..color = color2;

    double radius = min(size.width, size.height) / 2;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), radius * progress1, _paint1);
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), radius * progress2, _paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
