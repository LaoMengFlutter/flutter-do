import 'package:flutter/material.dart';

import 'a_page.dart';

///
/// des:
///
class CPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: RaisedButton(
          child: Text('C 页面'),
          onPressed: () {
            Navigator.of(context).pushNamed('/D');
          },
        ),
      ),
    );
  }
}
