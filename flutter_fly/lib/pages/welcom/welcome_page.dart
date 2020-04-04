import 'package:flutter/material.dart';
import 'package:flutter_fly/pages/routes/Routes.dart';
import 'package:flutter_fly/pages/welcom/rose.dart';

///
/// des: 欢迎/引导页面
///
class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var _showBtn = false;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _showBtn = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Rose(),
          ),
          _showBtn
              ? Positioned(
                  left: 0,
                  right: 0,
                  bottom: 50,
                  child: _buildButton(),
                )
              : Container(),
        ],
      ),
    );
  }

  _buildButton() {
    return Center(
      child: OutlineButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        borderSide: BorderSide(color: Color(0xFFF84120)),
        textColor: Color(0xFFF84120),
        padding: EdgeInsets.symmetric(horizontal: 30),
        onPressed: () {
          Navigator.pushReplacementNamed(context, Routes.home_page);
        },
        child: Text(
          '开启Flutter之旅',
        ),
      ),
    );
  }
}
