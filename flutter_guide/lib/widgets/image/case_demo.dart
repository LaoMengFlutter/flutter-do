import 'package:flutter/material.dart';

///
/// des:
///
class ImageCaseDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildTest(),
    );
  }

  _buildHeader() {
    return Container(
      width: 100,
      height: 100,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage('assets/images/aa.jpg'), fit: BoxFit.cover)),
      ),
    );
  }

  _buildChat() {
    return Container(
      width: 200,
      padding: EdgeInsets.only(left: 8, top: 8, right: 20, bottom: 8),
      decoration: BoxDecoration(
          image: DecorationImage(
              centerSlice: Rect.fromLTWH(20, 10, 1, 60),
              image: AssetImage(
                'assets/images/chat.png',
              ),
              fit: BoxFit.fill)),
      child: Text(
        '老孟，专注分享Flutter技术和应用实战。'
        '老孟，专注分享Flutter技术和应用实战。'
        '老孟，专注分享Flutter技术和应用实战。',
      ),
    );
  }

  _buildTest() {
    return Container(
        width: 300,
        height: 195,
        decoration: BoxDecoration(
            image: DecorationImage(
                centerSlice: Rect.fromLTRB(60, 60, 71, 71),
                image: AssetImage("assets/images/beijing.png"),
                fit: BoxFit.fill),
            color: Colors.red),
        child: Text("哈哈"));
  }
}
