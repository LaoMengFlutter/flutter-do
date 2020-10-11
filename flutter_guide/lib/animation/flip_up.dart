import 'dart:math';

import 'package:flutter/material.dart';

///
/// des:
///
class FlipUpDemo extends StatefulWidget {
  @override
  _FlipUpDemoState createState() => _FlipUpDemoState(
      Container(
        width: 300,
        height: 400,
        child: Image.asset(
          'assets/images/b.jpg',
          fit: BoxFit.cover,
        ),
      ),
      Container(
        width: 300,
        height: 400,
        child: Image.asset(
          'assets/images/c.jpeg',
          fit: BoxFit.cover,
        ),
      ));
}

class _FlipUpDemoState extends State<FlipUpDemo>
    with SingleTickerProviderStateMixin {
  final Widget child1, child2;
  AnimationController _controller;
  Animation _animation, _animation1;

  _FlipUpDemoState(this.child1, this.child2);

  @override
  void initState() {
    init();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..addListener(() {
            setState(() {});
          });
    _animation = Tween(begin: .0, end: pi / 2)
        .animate(CurvedAnimation(parent: _controller, curve: Interval(.0, .5)));
    _animation1 = Tween(begin: -pi / 2, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: Interval(.5, 1.0)));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _child1;
  Widget _child2;
  Widget _child3;
  Widget _child4;

  init() {
    _child1 = ClipRect(
      child: Align(
        alignment: Alignment.centerLeft,
        widthFactor: 0.5,
        child: child1,
      ),
    );
    _child2 = ClipRect(
      child: Align(
        alignment: Alignment.centerRight,
        widthFactor: 0.5,
        child: child1,
      ),
    );

    _child3 = ClipRect(
      child: Align(
        alignment: Alignment.centerLeft,
        widthFactor: 0.5,
        child: child2,
      ),
    );

    _child4 = ClipRect(
      child: Align(
        alignment: Alignment.centerRight,
        widthFactor: 0.5,
        child: child2,
      ),
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: [
              _child1,
              Transform(
                alignment: Alignment.centerRight,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(_animation1.value),
                child: _child3,
              ),
            ],
          ),
          Container(
            width: 3,
            color: Colors.white,
          ),
          Stack(
            children: [
              _child4,
              Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(_animation.value),
                child: _child2,
              )
            ],
          )
        ],
      ),
    );
  }
}
