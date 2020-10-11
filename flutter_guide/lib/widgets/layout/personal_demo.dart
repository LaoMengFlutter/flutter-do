import 'package:flutter/material.dart';

///
/// des:
///
class PersonalDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(.5),
      alignment: Alignment.center,
      child: Container(
        height: 100,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 15,
            ),
            _buildCircleImg(),
            SizedBox(
              width: 25,
            ),
            Expanded(
              child: _buildCenter(),
            ),
            Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 14,),
            SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }

  _buildCircleImg() {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: AssetImage('assets/images/logo.png'))),
    );
  }

  _buildCenter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('老孟Flutter', style: TextStyle(fontSize: 20),),
        Text('Flutter、Android', style: TextStyle(color: Colors.grey),)
      ],
    );
  }
}
