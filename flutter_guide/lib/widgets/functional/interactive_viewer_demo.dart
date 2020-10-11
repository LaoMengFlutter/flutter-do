import 'dart:math';

import 'package:flutter/material.dart';

///
/// desc:
///

class InteractiveViewerDemo extends StatefulWidget {
  @override
  _InteractiveViewerDemoState createState() => _InteractiveViewerDemoState();
}

class _InteractiveViewerDemoState extends State<InteractiveViewerDemo> {
  final TransformationController _transformationController =
      TransformationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Center(
              child: InteractiveViewer(
                child: Image.asset('assets/images/go_board_09x09.png'),
                transformationController: _transformationController,
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Row(
            children: [
              RaisedButton(
                child: Text('重置'),
                onPressed: () {
                  _transformationController.value = Matrix4.identity();
                },
              ),
              RaisedButton(
                child: Text('左移'),
                onPressed: () {
                  var matrix = _transformationController.value.clone();
                  matrix.translate(-5.0);
                  _transformationController.value = matrix;
                },
              ),
              RaisedButton(
                child: Text('放大'),
                onPressed: () {
                  var matrix = _transformationController.value.clone();
                  matrix.scale(1.5, 1.0, 1.0);
                  _transformationController.value = matrix;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
