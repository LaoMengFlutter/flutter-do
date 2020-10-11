import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

///
/// desc:
///

class CupertinoDatePickerDemo extends StatefulWidget {
  @override
  _CupertinoDatePickerDemoState createState() =>
      _CupertinoDatePickerDemoState();
}

class _CupertinoDatePickerDemoState extends State<CupertinoDatePickerDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          height: 200,
          color: Colors.grey.withOpacity(.5),
          child: _CupertinoTimePicker(),
        ),
      ),
    );
  }

  Widget _CupertinoDatePicker() {
    return Localizations(
      locale: Locale('en'),
      delegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      child: CupertinoDatePicker(
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (date) {
          print('$date');
        },
      ),
    );
  }

  Widget _CupertinoTimePicker() {
    return Localizations(
      locale: Locale('zh'),
      delegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      child: CupertinoTimerPicker(onTimerDurationChanged: (time) {
        print('$time');
      }),
    );
  }
}
