import 'package:flutter/material.dart';

///
/// des:
///
class ButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 200,
          width: double.infinity,
        ),
        RaisedButton(
          child: Text('RaisedButton'),
          onPressed: () {},
          elevation: 10.0,
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          child: Text('RaisedButton'),
          onPressed: () {},
          shape: BeveledRectangleBorder(
              side: BorderSide(width: 1, color: Colors.red),
              borderRadius: BorderRadius.circular(10)),
          elevation: 1.0,
        ),
        SizedBox(
          height: 20,
        ),
        FlatButton(
          child: Text('FlatButton'),
          color: Colors.blue,
          onPressed: () {},
        ),
        SizedBox(
          height: 20,
        ),
        OutlineButton(
          child: Text('OutlineButton'),
          onPressed: () {},
        ),
        SizedBox(
          height: 20,
        ),
        IconButton(icon: Icon(Icons.add),)

      ],
    );
  }
}
