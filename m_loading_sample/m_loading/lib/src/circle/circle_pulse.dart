import 'package:flutter/material.dart';
import 'package:m_loading/src/circle/circle.dart';

///
/// desc:
///

class CirclePulseLoading extends StatefulWidget {
  final Color color;
  final Duration duration;
  final Curve curve;

  const CirclePulseLoading(
      {Key key,
      this.color = Colors.white,
      this.duration = const Duration(milliseconds: 1000),
      this.curve = Curves.easeIn})
      : super(key: key);

  @override
  _CirclePulseLoadingState createState() => _CirclePulseLoadingState();
}

class _CirclePulseLoadingState extends State<CirclePulseLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

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
          return Center(
            child: SizedBox.fromSize(
              child: Circle(
                color: widget.color.withOpacity(1 - _animation.value),
              ),
              size: Size.square(50.0 * _animation.value),
            ),
          );
        });
  }
}
