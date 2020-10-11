import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
/// des:
///
class LoginDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginDemo> {
//账号
  String _accountValue = "";
  TextEditingController _accountController;

  //密码
  String _pwdValue = "";
  TextEditingController _pwdController;

  //是否明文展示密码
  bool _obscurePwd = true;

  //提交按钮是否可用
  bool submitEnable = false;

  //是否正在登录
  bool _isLogin = false;

  ///
  /// 检查提交按钮是否可以提交，账号和密码不为空可用
  ///
  void checkSubmitEnable() {
    setState(() {
      submitEnable = _accountValue.isNotEmpty && _pwdValue.isNotEmpty;
    });
  }

  ///
  /// 提交
  ///
  void submit(BuildContext context) async {
    showLoading(context);
//    await login(_accountValue, _pwdValue).then((value) {
//      if (value) {
//        Scaffold.of(context).showSnackBar(SnackBar(
//          content: Text('登录成功'),
//        ));
//      } else {
//        Scaffold.of(context).showSnackBar(SnackBar(
//          content: Text('账号密码错误'),
//        ));
//      }
//      hideLoading();
//    });
  }

  ///
  /// 取消loading
  ///
  void hideLoading() {
    Navigator.of(context).pop();
  }

  ///
  /// 展示loading
  ///
  void showLoading(BuildContext context) {
    showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return _createLoading();
        });
  }

  ///
  /// 模拟登录，这里应该是访问后台接口
  ///
  Future<bool> login(String account, String pwd) async {
    return Future.delayed(Duration(seconds: 2), () {
      return account == '123456' && pwd == '123456';
    });
  }

  @override
  Widget build(BuildContext context) {
    _accountController = TextEditingController.fromValue(TextEditingValue(
        text: _accountValue,
        selection: TextSelection.fromPosition(
            TextPosition(offset: _accountValue.length))));

    _pwdController = TextEditingController.fromValue(TextEditingValue(
        text: _pwdValue,
        selection: TextSelection.fromPosition(
            TextPosition(offset: _pwdValue.length))));
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue),
              ),
              padding: EdgeInsets.all(10),
              child: FlutterLogo(
                size: 70,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50, top: 40),
            child: _createAccountTextField(),
          ),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50, top: 20),
            child: _createPwdTextField(),
          ),
          SizedBox(
            height: 50,
          ),
          _createSubmitBtn(),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 5),
            child: _createPwdAndRegister(),
          ),
        ],
      ),
    );
  }

  ///
  /// 创建账号输入框
  ///
  Widget _createAccountTextField() {
    return TextField(
      controller: _accountController,
      keyboardType: TextInputType.number,
      inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]'))],
      decoration: InputDecoration(
        fillColor: Color(0x30cccccc),
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x00FF0000)),
            borderRadius: BorderRadius.all(Radius.circular(100))),
        hintText: '手机号/邮箱',
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x00000000)),
            borderRadius: BorderRadius.all(Radius.circular(100))),
        suffixIcon: _accountValue.isEmpty
            ? null
            : IconButton(
                icon: Icon(Icons.clear),
                color: Color(0xFFcccccc),
                iconSize: 16,
                onPressed: () {
                  setState(() {
                    _accountValue = '';
                    checkSubmitEnable();
                  });
                },
              ),
      ),
      textAlign: TextAlign.center,
      onChanged: (value) {
        setState(() {
          _accountValue = value;
          checkSubmitEnable();
        });
      },
    );
  }

  ///
  /// 创建密码输入框
  ///
  Widget _createPwdTextField() {
    return TextField(
      controller: _pwdController,
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
        suffixIcon: _pwdValue.isEmpty
            ? null
            : IconButton(
                icon: Icon(Icons.clear),
                color: Color(0xFFcccccc),
                iconSize: 16,
                onPressed: () {
                  setState(() {
                    _pwdValue = '';
                    checkSubmitEnable();
                  });
                },
              ),
        prefixIcon: _pwdValue.isEmpty
            ? null
            : IconButton(
                icon: _obscurePwd
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
                color: Color(0xFFcccccc),
                iconSize: 16,
                onPressed: () {
                  setState(() {
                    _obscurePwd = !_obscurePwd;
                  });
                },
              ),
      ),
      textAlign: TextAlign.center,
      obscureText: _obscurePwd,
      onChanged: (value) {
        setState(() {
          _pwdValue = value;
          checkSubmitEnable();
        });
      },
    );
  }

  ///
  /// 创建提交按钮
  ///
  Widget _createSubmitBtn() {
    return Center(
      child: RaisedButton(
        shape: CircleBorder(side: BorderSide(color: Color(0x00ffffff))),
        color: Colors.blue,
        disabledColor: Color(0x30cccccc),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 30,
          ),
        ),
        onPressed: submitEnable
            ? () {
                submit(context);
              }
            : null,
      ),
    );
  }

  ///
  /// 创建忘记密码和用户注册
  ///
  Widget _createPwdAndRegister() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      '忘记密码',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 10,
                      width: 65,
                      child: VerticalDivider(
                        color: Colors.black45,
                      ),
                    ),
                    Text(
                      '用户注册',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                child: _createUserAgreement(),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
      ],
    );
  }

  ///
  /// 创建用户协议
  Widget _createUserAgreement() {
    return Text.rich(
      TextSpan(
          text: '登录即代表同意并阅读',
          style: TextStyle(fontSize: 11, color: Color(0xFF999999)),
          children: [
            TextSpan(
                text: '服务协议',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ]),
    );
  }

  ///
  /// 创建loading
  ///
  Widget _createLoading() {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: Color(0xFFEBEBF5),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            )),
        child: CupertinoActivityIndicator(
          radius: 20,
        ),
      ),
    );
  }
}
