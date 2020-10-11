import 'package:flutter/material.dart';

///
/// des:
///
class AnimatedBuilderDemo extends StatefulWidget {
  @override
  _AnimatedBuilderDemoState createState() => _AnimatedBuilderDemoState();
}

class _AnimatedBuilderDemoState extends State<AnimatedBuilderDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _colorAnimation;
  Animation<Size> _sizeAnimation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _colorAnimation =
        ColorTween(begin: Colors.blue, end: Colors.red).animate(_controller);
    _sizeAnimation =
        SizeTween(begin: Size(100.0, 50.0), end: Size(200.0, 100.0))
            .animate(_controller);

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, widget) {
          return Container(
            width: _sizeAnimation.value.width,
            height: _sizeAnimation.value.height,
            color: _colorAnimation.value,
          );
        },
      ),
    );
  }
}
