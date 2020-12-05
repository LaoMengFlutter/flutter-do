import 'package:flutter/material.dart';

import 'ball_style.dart';

///
/// 默认球的样式
///
const kDefaultBallStyle = BallStyle(
  radius: 10.0,
  color: Colors.white,
  ballType: BallType.solid,
  borderWidth: 0.0,
  borderColor: Colors.white,
);

///
/// desc:球
///
class Ball extends StatelessWidget {
  ///
  /// 球样式
  ///
  final BallStyle style;

  const Ball({
    Key key,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BallStyle _ballStyle = kDefaultBallStyle.copyWith(
        radius: style?.radius,
        color: style?.color,
        ballType: style?.ballType,
        borderWidth: style?.borderWidth,
        borderColor: style?.borderColor);

    return SizedBox(
      width: _ballStyle.radius,
      height: _ballStyle.radius,
      child: DecoratedBox(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _ballStyle.ballType == BallType.solid ? _ballStyle.color : null,
            border: Border.all(
                color: _ballStyle.borderColor, width: _ballStyle.borderWidth)),
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
