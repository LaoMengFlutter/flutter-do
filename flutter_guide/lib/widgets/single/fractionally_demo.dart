import 'package:flutter/material.dart';

///
/// des:
///
class FractionallyDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        color: Colors.blue,
        child: FractionallySizedBox(
          widthFactor: .8,
          heightFactor: .3,
          child: Container(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
