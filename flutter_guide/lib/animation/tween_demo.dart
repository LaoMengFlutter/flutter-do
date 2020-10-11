
import 'package:flutter/material.dart';

///
/// des:
///

class TweenDemo extends StatefulWidget {
  @override
  _TweenDemoState createState() => _TweenDemoState();
}

class _TweenDemoState extends State<TweenDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animation =
        ColorTween(begin: Colors.blue, end: Colors.red).animate(_controller);


  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: buildGestureDetector(),
    );
  }

  GestureDetector buildGestureDetector() {
    return GestureDetector(
      onTap: () {
        _controller.forward();
      },
      child: Container(
        height: 100,
        width: 100,
        color: _animation.value,
        alignment: Alignment.center,
        child: Text(
          '点我变色',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

