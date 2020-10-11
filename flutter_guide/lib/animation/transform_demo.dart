import 'dart:math';

import 'package:flutter/material.dart';

///
/// des:
///


class TransformDemo extends StatefulWidget {
  @override
  _TransformDemoState createState() => _TransformDemoState();
}

class _TransformDemoState extends State<TransformDemo> {
  double _rotateX = .0;
  double _rotateY = .0;

  @override
  Widget build(BuildContext context) {
    return Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_rotateX)
          ..rotateY(_rotateY),
        alignment: Alignment.center,
        child: Scaffold(
          appBar: AppBar(
            title: Text('3D 变换Demo'),
          ),
          body: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _rotateX += details.delta.dy * .01;
                _rotateY += details.delta.dx * -.01;
              });
            },
            child: Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: Text('3D 变换Demo'),
            ),
          ),
        ));
  }
}
