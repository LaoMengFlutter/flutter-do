import 'package:flutter/material.dart';

///
/// des:
///
class RowColumnDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: _buildRow1(),
      ),
    );
  }

  _buildRow() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Row(
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Container(
            height: 50,
            width: 100,
            color: Colors.red,
          ),
          Container(
            height: 50,
            width: 100,
            color: Colors.green,
          ),
          Container(
            height: 50,
            width: 100,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  _buildRow1() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalDirection: VerticalDirection.up,
        children: <Widget>[
          Container(
            height: 50,
            width: 100,
            color: Colors.red,
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.green,
          ),
          Container(
            height: 150,
            width: 100,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  _buildColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 50,
          width: 100,
          color: Colors.red,
        ),
        Container(
          height: 50,
          width: 100,
          color: Colors.green,
        ),
        Container(
          height: 50,
          width: 100,
          color: Colors.blue,
        ),
      ],
    );
  }
}
