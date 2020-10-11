import 'package:flutter/material.dart';

///
/// des:
///
class AnimatedWidgetDemo extends StatefulWidget {
  @override
  _AnimatedWidgetDemoState createState() => _AnimatedWidgetDemoState();
}

class _AnimatedWidgetDemoState extends State<AnimatedWidgetDemo> {
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(seconds: 2),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _opacity = 0;
            });
          },
          child: Container(
            height: 60,
            width: 150,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
