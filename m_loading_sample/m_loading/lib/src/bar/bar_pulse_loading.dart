import 'package:flutter/material.dart';
import 'package:m_loading/src/bar/bar.dart';

import '../common/delay_tween.dart';

///
/// desc:
///

class BarPulseLoading extends StatefulWidget {
  final double width;
  final double height;
  final Color color;
  final BorderRadiusGeometry borderRadius;
  final Duration duration;
  final Curve curve;

  const BarPulseLoading(
      {Key key,
      this.width = 2.0,
      this.height = 15.0,
      this.color = Colors.white,
      this.borderRadius = const BorderRadius.only(
          topLeft: Radius.circular(3), topRight: Radius.circular(3)),
      this.duration = const Duration(milliseconds: 800),
      this.curve = Curves.linear})
      : super(key: key);

  @override
  _BarPulseLoadingState createState() => _BarPulseLoadingState();
}

class _BarPulseLoadingState extends State<BarPulseLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (index) {
        return ScaleTransition(
          scale: DelayTween(begin: 1.0, end: 2.3, delay: index * .2).animate(
              CurvedAnimation(parent: _controller, curve: widget.curve)),
          child: Bar(
            color: widget.color,
            width: widget.width,
            borderRadius: widget.borderRadius,
            height: widget.height,
          ),
        );
      }),
    );
  }
}
