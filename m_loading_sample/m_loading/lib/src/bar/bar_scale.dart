import 'package:flutter/material.dart';

import 'bar.dart';

///
/// desc:
///

class BarScaleLoading extends StatefulWidget {
  final double width;
  final double height;
  final Color color;
  final BorderRadiusGeometry borderRadius;
  final Duration duration;
  final Curve curve;

  const BarScaleLoading(
      {Key key,
      this.width = 3.0,
      this.height = 25.0,
      this.color = Colors.white,
      this.borderRadius = const BorderRadius.only(
          topLeft: Radius.circular(3), topRight: Radius.circular(3)),
      this.duration = const Duration(milliseconds: 1000),
      this.curve = Curves.linear})
      : super(key: key);

  @override
  _BarScaleLoadingState createState() => _BarScaleLoadingState();
}

class _BarScaleLoadingState extends State<BarScaleLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _anim1, _anim2, _anim3, _anim4, _anim5;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    _anim1 = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.1, 0.6, curve: widget.curve)));

    _anim2 = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.2, 0.7, curve: widget.curve)));

    _anim3 = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.3, 0.8, curve: widget.curve)));

    _anim4 = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.4, 0.9, curve: widget.curve)));

    _anim5 = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.5, 1.0, curve: widget.curve)));

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _item(_anim1),
              _item(_anim2),
              _item(_anim3),
              _item(_anim4),
              _item(_anim5),
            ],
          );
        });
  }

  _item(Animation animation) {
    return Transform(
      transform: Matrix4.identity()..scale(1.0, animation.value, 1.0),
      alignment: Alignment.center,
      child: Bar(
        color: widget.color,
        width: widget.width,
        borderRadius: widget.borderRadius,
        height: widget.height,
      ),
    );
  }
}
