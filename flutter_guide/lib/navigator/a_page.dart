import 'package:flutter/material.dart';

import 'b_page.dart';

///
/// des:
///
class APage extends StatefulWidget {
  @override
  _APageState createState() => _APageState();
}

class _APageState extends State<APage> {
  String _string = 'A 页面';

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: RaisedButton(
          child: Text(_string),
          onPressed: () async {
            var result =
                await Navigator.of(context).pushNamed('/B', arguments: '来自A');
            setState(() {
              _string = result;
            });
          },
        ),
      ),
    );
  }
}
