import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// des:
///
class SizedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        width: 300,
        child: Column(
          children: <Widget>[
            Container(height: 30,color: Colors.blue,),
            SizedBox(height: 30,),
            Container(height: 30,color: Colors.red,),
          ],
        ),
      ),
    );
  }
}



