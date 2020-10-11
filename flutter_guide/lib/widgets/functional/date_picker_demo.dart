import 'package:flutter/material.dart';

///
/// desc:
///

class DatePickerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:
//          CalendarDatePicker(
//        initialDate: DateTime.now(),
//        firstDate: DateTime(2010),
//        lastDate: DateTime(2025),
//        onDateChanged: (d) {
//          print('$d');
//        },
//      )
            RaisedButton(
          child: Text('弹出日期组件'),
          onPressed: () async {
            var result = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2010),
              lastDate: DateTime(2025),
              locale: Locale('zh')
            );
            print('$result');
          },
        ),
//        RaisedButton(
//          child: Text('范围日期'),
//          onPressed: () async {
//            var date = showDateRangePicker(context: context, firstDate: DateTime(2010), lastDate: DateTime(2025));
//          },
//        ),
      ),
    );
  }
}
