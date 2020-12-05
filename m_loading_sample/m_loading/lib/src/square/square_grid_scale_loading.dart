import 'package:flutter/material.dart';
import 'square.dart';

///
/// desc:
///

class SquareGridScaleLoading extends StatefulWidget {
  final double size;
  final Duration duration;
  final Curve curve;
  final Color color;

  const SquareGridScaleLoading(
      {Key key,
      this.color = Colors.white,
      this.size = 48.0,
      this.duration = const Duration(milliseconds: 1500),
      this.curve = Curves.linear})
      : super(key: key);

  @override
  _SquareGridScaleLoadingState createState() => _SquareGridScaleLoadingState();
}

class _SquareGridScaleLoadingState extends State<SquareGridScaleLoading>
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
    return SizedBox.fromSize(
      size: Size.square(widget.size),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _square(_anim3, 0),
              _square(_anim4, 1),
              _square(_anim5, 2),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _square(_anim2, 3),
              _square(_anim3, 4),
              _square(_anim4, 5),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _square(_anim1, 6),
              _square(_anim2, 7),
              _square(_anim3, 8),
            ],
          ),
        ],
      ),
    );
  }

  Widget _square(Animation<double> animation, int index) {
    return ScaleTransition(
      scale: animation,
      child: SizedBox.fromSize(
          size: Size.square(widget.size / 3.0),
          child: Square(
            color: widget.color,
          )),
    );
  }
}
