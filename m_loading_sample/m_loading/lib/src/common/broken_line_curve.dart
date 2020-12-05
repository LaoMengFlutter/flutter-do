import 'package:flutter/material.dart';

///
/// desc:
///
class BrokenLineCurve extends Curve {

  const BrokenLineCurve();

  @override
  double transformInternal(double t) {
    if (t < 0.5) {
      return t * 2;
    } else if (t >= 0.5) {
      return (1 - t) * 2;
    }
  }
}
