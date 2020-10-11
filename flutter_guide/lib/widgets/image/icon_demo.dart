import 'package:flutter/material.dart';

///
/// des:
///
class IconDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(
        height: 100,
        width: double.infinity,
      ),
      Icon(Icons.add),
      Icon(
        Icons.add,
        size: 40,
        color: Colors.red,
      )

    ]);
  }
}
