import 'dart:math';

import 'package:flutter/material.dart';

///
/// des:
///
class ShaderMaskDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: double.infinity, child: _buildWidget4());
  }

  _buildWidget1() {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: <Color>[Colors.blue, Colors.red],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
      child: Center(
        child: Text(
          '老孟，一枚有态度的程序员',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  _buildWidget2() {
    Color color = Colors.orange;
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              color,
              color,
              Colors.transparent,
              Colors.transparent,
              color,
              color
            ],
            stops: [
              0,
              .4,
              .41,
              .6,
              .61,
              1
            ]).createShader(bounds);
      },
      blendMode: BlendMode.color,
      child: Image.asset(
        'assets/images/b.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  _buildWidget3() {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return RadialGradient(
          radius: .5,
          focalRadius: .4,
          colors: <Color>[
            Colors.red,
            Colors.blue
          ],
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
      child: Image.asset(
        'assets/images/b.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  _buildWidget4() {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return SweepGradient(
          startAngle: 0,
          endAngle: pi,
          colors: <Color>[
            Colors.blue,
            Colors.green
          ],
        ).createShader(bounds);
      },
      child: Image.asset(
        'assets/images/b.jpg',
        fit: BoxFit.cover,
      ),
    );
  }


}
