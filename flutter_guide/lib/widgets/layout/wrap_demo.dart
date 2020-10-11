import 'package:flutter/material.dart';

///
/// des:
///
class WrapDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildWrap(),
    );
  }

  _buildWrap() {
    return Wrap(
      spacing: 5,
      runSpacing: 3,
      crossAxisAlignment: WrapCrossAlignment.center,
      verticalDirection: VerticalDirection.up,
      children: List.generate(10, (i) {
        double w = 50.0 + 10 * i;
        double h = 50.0 + 5 * i;
        return Container(
          color: Colors.primaries[i],
          height: h,
          alignment: Alignment.center,
          width: w,
          child: Text('$i'),
        );
      }),
    );
  }

  _buildWrap1() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: List.generate(10, (i) {
        double w = 50.0 + 10 * i;
        return Container(
          color: Colors.primaries[i],
          height: 50,
          width: w,
          child: Text('$i'),
        );
      }),
    );
  }
}
