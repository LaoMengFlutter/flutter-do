import 'dart:math';

import 'package:flutter/material.dart';

///
/// des:
///
class FlipAnimationDemo extends StatefulWidget {
  @override
  _FlipAnimationDemoState createState() => _FlipAnimationDemoState();
}

class _FlipAnimationDemoState extends State<FlipAnimationDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation, _animation1;
  final List<String> _values = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];
  int _index = 0;

  @override
  void initState() {
    createItem();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed) {
              _index++;
              createItem();
              _controller.repeat();
            } else if (status == AnimationStatus.completed) {
              _controller.reset();
              _controller.forward();
            }
          });
    _animation = Tween(begin: .0, end: pi / 2)
        .animate(CurvedAnimation(parent: _controller, curve: Interval(.0, .5)));
    _animation1 = Tween(begin: pi / 2, end: .0).animate(
        CurvedAnimation(parent: _controller, curve: Interval(.5, 1.0)));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _upperChild1;
  Widget _upperChild2;
  Widget _lowerChild1;
  Widget _lowerChild2;

  createItem() {
    var t1 = _values[_index % _values.length];
    var t2 = _values[(_index + 1) % _values.length];

    Widget _child1 = Container(
      width: 100,
      height: 150,
      color: Colors.red,
      alignment: Alignment.center,
      child: Text(
        '${_values[_index % _values.length]}',
        style: TextStyle(
            color: Colors.white, fontSize: 60, fontWeight: FontWeight.bold),
      ),
    );

    Widget _child2 = Container(
      width: 100,
      height: 150,
      color: Colors.red,
      alignment: Alignment.center,
      child: Text(
        '${_values[(_index + 1) % _values.length]}',
        style: TextStyle(
            color: Colors.white, fontSize: 60, fontWeight: FontWeight.bold),
      ),
    );

    _upperChild1 = ClipRect(
      child: Align(
        alignment: Alignment.topCenter,
        heightFactor: 0.5,
        child: _child1,
      ),
    );

    _upperChild2 = ClipRect(
      child: Align(
        alignment: Alignment.topCenter,
        heightFactor: 0.5,
        child: _child2,
      ),
    );

    _lowerChild1 = ClipRect(
      child: Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 0.5,
        child: _child1,
      ),
    );

    _lowerChild2 = ClipRect(
      child: Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 0.5,
        child: _child2,
      ),
    );
  }

  updateItem() {
    _upperChild1 = _upperChild2;
    _lowerChild1 = _lowerChild2;

    Widget _child = Container(
      width: 100,
      height: 150,
      color: Colors.red,
      alignment: Alignment.center,
      child: Text(
        '${_values[_index % _values.length]}',
        style: TextStyle(
            color: Colors.white, fontSize: 60, fontWeight: FontWeight.bold),
      ),
    );

    _upperChild2 = ClipRect(
      child: Align(
        alignment: Alignment.topCenter,
        heightFactor: 0.5,
        child: _child,
      ),
    );

    _lowerChild2 = ClipRect(
      child: Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 0.5,
        child: _child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: [
              _upperChild1,
              Transform(
                alignment: Alignment.bottomCenter,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.003)
                  ..rotateX(_animation1.value),
                child: _upperChild2,
              ),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Stack(
            children: [
              _lowerChild2,
              Transform(
                alignment: Alignment.topCenter,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.003)
                  ..rotateX(_animation.value),
                child: _lowerChild1,
              )
            ],
          )
        ],
      ),
    );
  }
}
