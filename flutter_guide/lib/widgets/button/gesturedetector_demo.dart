import 'package:flutter/material.dart';

///
/// des:
///
class GestureDetectorDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTapDown: (TapDownDetails tapDownDetails) {
        print('onTapDown');
      },
      onTapUp: (TapUpDetails tapUpDetails) {
        print('onTapUp');
      },
      onTap: () {
        print('onTap');
      },
      onTapCancel: () {
        print('onTapCancel');
      },
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.red,
        ),
      ),
    );
  }
}
