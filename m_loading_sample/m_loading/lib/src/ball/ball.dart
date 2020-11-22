import 'package:flutter/material.dart';

///
/// desc:球
///

class Ball extends StatelessWidget {
  ///
  /// 半径
  ///
  final double radius;

  ///
  /// 实心球颜色
  ///
  final Color color;

  ///
  /// 球的类型 [ BallType ]
  ///
  final BallType ballType;

  ///
  /// 边框宽
  ///
  final double borderWidth;

  ///
  /// 边框颜色
  ///
  final Color borderColor;

  const Ball({
    Key key,
    this.radius = 16,
    this.color = Colors.white,
    this.ballType = BallType.solid,
    this.borderWidth = 0.0,
    this.borderColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius,
      height: radius,
      child: DecoratedBox(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ballType == BallType.solid ? color : Colors.transparent,
            border: Border.all(color: borderColor, width: borderWidth)),
      ),
    );
  }
}

enum BallType {
  ///
  /// 空心
  ///
  hollow,

  ///
  /// 实心
  ///
  solid
}
