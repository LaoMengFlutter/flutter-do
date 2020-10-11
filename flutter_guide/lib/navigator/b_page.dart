import 'package:flutter/material.dart';

import 'a_page.dart';

///
/// des:
///
class BPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: RaisedButton(
          child: Text('${ModalRoute.of(context).settings.arguments}'),
          onPressed: () {
            Navigator.of(context).pop('从B返回');
          },
        ),
      ),
    );
  }
}
