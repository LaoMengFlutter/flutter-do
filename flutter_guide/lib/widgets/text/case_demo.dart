import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///
/// des:
///
class CaseDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 150,
        child: _buildBack(),
      ),
    );
  }

  _buildGradientText() {
    return Builder(
      builder: (BuildContext context) {
        RenderBox box = context.findRenderObject();
        final Shader linearGradient = LinearGradient(
          colors: <Color>[Colors.purple, Colors.blue],
        ).createShader(
            Rect.fromLTWH(0.0, 0.0, box?.size?.width, box?.size?.height));

        return Text(
          '老孟，专注分享Flutter技术和应用实战',
          style: new TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = linearGradient),
        );
      },
    );
  }

  _buildChipText(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <InlineSpan>[
            WidgetSpan(
                child: Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.blue),
              child: Text(
                '判断题',
                style: TextStyle(color: Colors.white),
              ),
            )),
            TextSpan(text: '泡沫灭火器可用于带电灭火'),
          ]),
    );
  }

  _buildUserAgreement() {
    return Text.rich(
      TextSpan(
          text: '登录即代表同意并阅读',
          style: TextStyle(fontSize: 11, color: Color(0xFF999999)),
          children: [
            TextSpan(
              text: '《服务协议》',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('onTap');
                },
            ),
          ]),
    );
  }

  ///
  /// 创建密码输入框
  ///
  Widget _buildPwdTextField() {
    return TextField(
      decoration: InputDecoration(
        fillColor: Color(0x30cccccc),
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x00FF0000)),
            borderRadius: BorderRadius.all(Radius.circular(100))),
        hintText: '输入密码',
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x00000000)),
            borderRadius: BorderRadius.all(Radius.circular(100))),
      ),
      textAlign: TextAlign.center,
      obscureText: true,
      onChanged: (value) {},
    );
  }

  _buildBack() {
    return Text.rich(
      TextSpan(
          text: '回复',
          style: TextStyle(fontSize: 11, color: Color(0xFF999999)),
          children: [
            TextSpan(
              text: '@老孟：',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('onTap');
                },
            ),
            TextSpan(
              text: '你好，想知道Flutter发展前景如何？',
            ),
          ]),
    );
  }
}
