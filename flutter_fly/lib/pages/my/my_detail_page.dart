import 'package:flutter/material.dart';

///
/// des:
///
class MyDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('详细信息'),
        elevation: 0,
      ),

      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context){
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          _buildItem('微信号','laomengit',(){}),
          SizedBox(
            height: 1,
          ),
          _buildItem('公众号','老孟程序员',(){}),
          SizedBox(
            height: 1,
          ),
          _buildItem('博客','http://laomengit.com',(){}),

        ],
      ),
    );
  }

  _buildItem(String title,String content,onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 65,
        color: Colors.white,
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              content,
              style: TextStyle(color: Color(0xFF727272)),
            ),
          ],
        ),
      ),
    );
  }
}
