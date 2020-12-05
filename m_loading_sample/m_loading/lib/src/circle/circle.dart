import 'package:flutter/material.dart';

///
/// desc:
///

class Circle extends StatelessWidget {
  final Color color;

  const Circle({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
