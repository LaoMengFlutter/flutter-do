import 'dart:math';

import 'package:flutter/material.dart';
import 'package:m_loading/m_loading.dart';

///
/// desc:
///
class BallPainter extends CustomPainter {
  ///
  /// 球样式集合,
  /// [count] 大于 [ballStyle] 的个数时，后面的球的样式使用最后一个 ballStyle
  /// [count] 小于 [ballStyle] 的个数时，后面的 ballStyle 不使用
  ///
  final List<BallStyle> ballStyles;

  ///
  /// 球的个数
  ///
  final int count;

  Paint _paint = Paint();

  BallPainter({this.ballStyles = const [kDefaultBallStyle], this.count = 2});

  @override
  void paint(Canvas canvas, Size size) {
    double _radius = min(size.width, size.height) / 2;
    double perAngle = 2 * pi / count;
    List.generate(count, (index) {
      int styleIndex = min(ballStyles.length-1, index);
      BallStyle _style = ballStyles[styleIndex];
      if (_style.ballType == BallType.solid) {
        _paint
          ..color = _style.color
          ..style = PaintingStyle.fill;
      } else {
        _paint
          ..color = _style.borderColor
          ..strokeWidth = _style.borderWidth
          ..style = PaintingStyle.stroke;
      }

      canvas.drawCircle(
          Offset(_radius + _radius * cos(perAngle * index),
              _radius + _radius * sin(perAngle * index)),
          _style.size,
          _paint);
    });
  }

  @override
  bool shouldRepaint(covariant BallPainter old) {
    return count != old.count || ballStyles != old.ballStyles;
  }
}
