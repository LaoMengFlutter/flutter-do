import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

///
/// desc:
///

class TimePickerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: _showTimePick(context),
      ),
    );
  }

  Widget _showTimePick(BuildContext context) {

    return RaisedButton(
      child: Text('弹出时间选择器'),
      onPressed: () async {
        var result = showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (BuildContext context, Widget child) {
            return Localizations(
              locale: Locale('en'),
              delegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              child: child,
            );
          },
        );
      },
    );
  }
}
