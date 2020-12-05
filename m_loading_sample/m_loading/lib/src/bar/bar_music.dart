import 'package:flutter/material.dart';

import 'bar.dart';

///
/// desc:
///
class BarMusicLoading extends StatefulWidget {
  final double width;
  final double height;
  final Color color;
  final BorderRadiusGeometry borderRadius;
  final Duration duration;
  final Curve curve;

  const BarMusicLoading(
      {Key key,
      this.width = 3.0,
      this.height = 40.0,
      this.color = Colors.white,
      this.borderRadius = const BorderRadius.only(
          topLeft: Radius.circular(3), topRight: Radius.circular(3)),
      this.duration = const Duration(milliseconds: 3000),
      this.curve = Curves.easeInOut})
      : super(key: key);

  @override
  _BarMusicLoadingState createState() => _BarMusicLoadingState();
}

class _BarMusicLoadingState extends State<BarMusicLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation _animation, _animation1, _animation2, _animation3;
  List values = [
    [0.0, 0.7, 0.4, 0.05, 0.95, 0.3, 0.9, 0.4, 0.15, 0.18, 0.75, 0.01],
    [0.05, 0.95, 0.3, 0.9, 0.4, 0.15, 0.18, 0.75, 0.01, 0.0, 0.7, 0.4],
    [0.9, 0.4, 0.15, 0.18, 0.75, 0.01, 0.0, 0.7, 0.4, 0.05, 0.95, 0.3],
    [0.18, 0.75, 0.01, 0.0, 0.7, 0.4, 0.05, 0.95, 0.3, 0.9, 0.4, 0.15],
  ];

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    _animation = TweenSequence([
      ...List.generate(11, (index) {
        return TweenSequenceItem(
            tween: Tween(begin: values[0][index], end: values[0][index + 1]),
            weight: 100.0 / values.length);
      }).toList()
    ]).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _animation1 = TweenSequence([
      ...List.generate(11, (index) {
        return TweenSequenceItem(
            tween: Tween(begin: values[1][index], end: values[1][index + 1]),
            weight: 100.0 / values.length);
      }).toList()
    ]).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _animation2 = TweenSequence([
      ...List.generate(11, (index) {
        return TweenSequenceItem(
            tween: Tween(begin: values[2][index], end: values[2][index + 1]),
            weight: 100.0 / values.length);
      }).toList()
    ]).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _animation3 = TweenSequence([
      ...List.generate(11, (index) {
        return TweenSequenceItem(
            tween: Tween(begin: values[3][index], end: values[3][index + 1]),
            weight: 100.0 / values.length);
      }).toList()
    ]).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

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
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Bar(
                color: widget.color,
                width: widget.width,
                borderRadius: widget.borderRadius,
                height: _animation.value * widget.height,
              ),
              Bar(
                color: widget.color,
                width: widget.width,
                borderRadius: widget.borderRadius,
                height: _animation1.value * widget.height,
              ),
              Bar(
                color: widget.color,
                width: widget.width,
                borderRadius: widget.borderRadius,
                height: _animation2.value * widget.height,
              ),
              Bar(
                color: widget.color,
                width: widget.width,
                borderRadius: widget.borderRadius,
                height: _animation3.value * widget.height,
              ),
            ],
          );
        });
  }
}
