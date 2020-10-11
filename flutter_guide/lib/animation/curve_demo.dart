import 'package:flutter/material.dart';

///
/// des:
///

class CurveDemo extends StatefulWidget {
  @override
  _CurveDemoState createState() => _CurveDemoState();
}

class _CurveDemoState extends State<CurveDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000),
        lowerBound: 200.0,
        upperBound: 300.0)
      ..addListener(() {
        print('v:${_animation.value},c:${_controller.value}');
        setState(() {});
      });

//    _animation = _controller
//        .drive(CurveTween(curve: Curves.linear))
//        .drive(Tween(begin: 100.0, end: 200.0));

    _animation = Tween(begin: 100.0, end: 200.0).animate(_controller);

//    _animation = CurveTween(curve: Curves.linear)
//        .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          _controller.forward();
        },
        child: Container(
          height: _animation.value,
          width: _animation.value,
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text(
            '点我变大',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
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

class _StairsCurve extends Curve {
  final int num;
  double _perStairY;
  double _perStairX;

  _StairsCurve(this.num) {
    _perStairY = 1.0 / (num - 1);
    _perStairX = 1.0 / num;
  }

  @override
  double transformInternal(double t) {
    return _perStairY * (t / _perStairX).floor();
  }
}
