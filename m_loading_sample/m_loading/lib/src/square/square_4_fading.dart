import 'package:flutter/material.dart';
import 'package:m_loading/src/common/delay_tween.dart';

import 'square.dart';

///
/// desc:
///

class SquareFadingLoading extends StatefulWidget {
  final Color color;
  final Duration duration;
  final Curve curve;

  const SquareFadingLoading(
      {Key key,
      this.color = Colors.white,
      this.duration = const Duration(milliseconds: 1200),
      this.curve = Curves.linear})
      : super(key: key);

  @override
  _SquareFadingLoadingState createState() => _SquareFadingLoadingState();
}

class _SquareFadingLoadingState extends State<SquareFadingLoading>
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
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(child: _item(0)),
              Expanded(child: _item(1)),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(child: _item(3)),
              Expanded(child: _item(2)),
            ],
          ),
        ),
      ],
    );
  }

  _item(int index) {
    return FadeTransition(
      opacity: DelayTween(begin: 0.0, end: 1.0, delay: 0.3 * index)
          .animate(CurvedAnimation(parent: _controller, curve: widget.curve)),
      child: Square(
        color: widget.color,
      ),
    );
  }
}
