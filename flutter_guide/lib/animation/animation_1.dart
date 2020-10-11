import 'package:flutter/material.dart';

///
/// des:
///

class AnimationBaseDemo extends StatefulWidget {
  @override
  _AnimationBaseDemoState createState() => _AnimationBaseDemoState();
}

class _AnimationBaseDemoState extends State<AnimationBaseDemo>
    with SingleTickerProviderStateMixin {
  double _size = 100;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
        lowerBound: 100,
        upperBound: 200)
      ..addStatusListener((AnimationStatus status) {
//        if(status == AnimationStatus.completed){
//          _controller.repeat();
//        }else if(status == AnimationStatus.dismissed){
//          _controller.forward();
//        }
      })
      ..addListener(() {
        setState(() {
          _size = _controller.value;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          _controller.repeat(reverse: false);
        },
        child: Container(
          height: _size,
          width: _size,
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
