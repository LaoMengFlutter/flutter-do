import 'package:flutter/material.dart';
import '../common/broken_line_curve.dart';
///
/// desc:
///
class AnimatedDelayBuilder extends StatefulWidget {
  final Duration duration;
  final int animationCount;
  final double begin;
  final double end;
  final Curve curve;
  final double delay;
  final AnimatedDelayItemBuilder itemBuilder;

  const AnimatedDelayBuilder({
    Key key,
    this.duration = const Duration(milliseconds: 800),
    this.animationCount = 3,
    this.begin = 1.0,
    this.end = 0.0,
    this.curve = Curves.linear,
    this.delay = 0.2,
    @required this.itemBuilder,
  }) : super(key: key);

  @override
  _AnimatedDelayBuilderState createState() => _AnimatedDelayBuilderState();
}

class _AnimatedDelayBuilderState extends State<AnimatedDelayBuilder>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<Animation> _animations = [];

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    List.generate(widget.animationCount, (index) {
      _animations.add(
          Tween(begin: widget.begin, end: widget.end).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(
            0.0 + index * widget.delay,
            1 -
                (widget.animationCount - 1) * widget.delay +
                index * widget.delay,
            curve: BrokenLineCurve()),
      )));
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
    return widget.itemBuilder(context, _animations);
  }
}

typedef AnimatedDelayItemBuilder = Function(
    BuildContext context, List<Animation> animations);
