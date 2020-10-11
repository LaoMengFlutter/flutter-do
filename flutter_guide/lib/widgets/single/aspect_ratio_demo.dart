import 'package:flutter/material.dart';

///
/// des:
///
class AspectRatioDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        width: 300,
        color: Colors.blue,
        alignment: Alignment.center,
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Container(color: Colors.red,),
        ),
      ),
    );
  }
}
