import 'package:flutter/material.dart';

///
/// des:
///
class StackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildStack(),
    );
  }

  _buildStack(){
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          height: 200,
          width: 200,
          color: Colors.red,
        ),
        Positioned(
          left: 100,
          top: 100,
          height: 150,
          width: 150,
          child: Container(
            color: Colors.green,
          ),
        )
      ],
    );
  }

  _buildStack1(){
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
          height: 200,
          width: 200,
          color: Colors.red,
        ),
        Container(
          height: 170,
          width: 170,
          color: Colors.blue,
        ),
        Positioned(
          left: 30,
          right: 40,
          bottom: 50,
          top: 60,
          child: Container(
            color: Colors.yellow,
          ),
        )
      ],
    );
  }
}
