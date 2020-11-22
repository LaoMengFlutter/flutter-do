import 'dart:math' as math;

import 'package:flutter/animation.dart';

///
/// desc:
///
class DelayTween extends Tween<double> {
  final double delay;

  DelayTween({double begin, double end, this.delay})
      :super(begin: begin, end: end);

  @override
  double lerp(double t) {
    return super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);
  }

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}