import 'package:flutter/material.dart';

///
/// desc:
///

class DropdownDemo extends StatefulWidget {
  @override
  _DropdownDemoState createState() => _DropdownDemoState();
}

class _DropdownDemoState extends State<DropdownDemo> {
  var _dropValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.blue,
              width: 2,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: _dropValue,
              isExpanded: true,
              hint: Center(child: Text('请选择科目')),
              items: [
                DropdownMenuItem(
                  child: Center(child: Text('语文')),
                  value: '语文',
                ),
                DropdownMenuItem(child: Center(child: Text('数学')), value: '数学'),
                DropdownMenuItem(child: Center(child: Text('英语')), value: '英语'),
              ],
              onChanged: (value) {
                setState(() {
                  _dropValue = value;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
