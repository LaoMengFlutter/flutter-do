import 'package:flutter/material.dart';

import 'a_page.dart';

///
/// des:
///
class DPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: RaisedButton(
          child: Text('D 页面'),
          onPressed: () {
            Navigator.of(context).popUntil(ModalRoute.withName('/A'));
          },
        ),
      ),
    );
  }
}

