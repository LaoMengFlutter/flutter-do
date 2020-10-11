import 'package:flutter/material.dart';

///
/// des:
///
class ButtonCase extends StatefulWidget {
  @override
  _ButtonCaseState createState() => _ButtonCaseState();
}

class _ButtonCaseState extends State<ButtonCase> {
  ButtonStatus _buttonStatus = ButtonStatus.none;

  _buildChild() {
    if (_buttonStatus == ButtonStatus.none) {
      return Text(
        '登 录',
        style: TextStyle(color: Colors.white,fontSize: 18),
      );
    } else if (_buttonStatus == ButtonStatus.loading) {
      return CircularProgressIndicator(
        backgroundColor: Colors.white,
        strokeWidth: 2,
      );
    } else if (_buttonStatus == ButtonStatus.done) {
      return Icon(
        Icons.check,
        color: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.blue,
      minWidth: 240,
      height: 48,
      onPressed: () {
        setState(() {
          _buttonStatus = ButtonStatus.loading;
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _buttonStatus = ButtonStatus.done;
            });
          });
        });
      },
      child: _buildChild(),
    );
  }
}

enum ButtonStatus { none, loading, done }
