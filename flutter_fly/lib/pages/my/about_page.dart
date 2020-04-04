import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

///
/// des:
///
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 48,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: BackButton(),
            ),
            SizedBox(
              height: 48,
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/header.png',
                  height: 80,
                  width: 80,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Center(
              child: Text(
                'Flutter Fly',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Center(
              child: Text.rich(
                TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: '《软件许可及服务协议》',
                      recognizer: TapGestureRecognizer()..onTap = () {
                      },
                      style: TextStyle(color: Color(0xFF5E6386))),
                  TextSpan(text: '和'),
                  TextSpan(
                      text: '《隐私保护指引》',
                      recognizer: TapGestureRecognizer()..onTap = () {
                      },
                      style: TextStyle(color: Color(0xFF5E6386))),
                ]),
              ),
            ),
            SizedBox(
              height: 45,
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// 跳转到详情
  ///
  _toDetail(BuildContext context,String url, {title = ''}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return WebView(
        initialUrl: url,
      );
    }));
  }
}
