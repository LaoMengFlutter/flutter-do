import 'package:flutter/material.dart';

///
/// des:
///
class ContainerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.blue,
        child: Text('老孟，专注分享Flutter技术及应用'),
        alignment: Alignment.center,
        height: 60,
        width: 250,
        transform: Matrix4.rotationZ(0.5),
      ),
    );
  }

  _buildDemo() {
    return Container(
      color: Colors.blue,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        color: Colors.red,
        child: Text('老孟'),
      ),
    );
  }

  _buildDecoration() {
    return Container(
      child: Text('老孟，专注分享Flutter技术及应用'),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),
      ),
    );
  }
}
