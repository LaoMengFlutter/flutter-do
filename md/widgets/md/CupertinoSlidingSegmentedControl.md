---
title: 'CupertinoSlidingSegmentedControl'
description: ''
type: widget
---



# CupertinoSlidingSegmentedControl

iOS 13 样式分段控件。

```dart
String _value = '语文';

@override
Widget build(BuildContext context) {
  return Center(
    child: CupertinoSlidingSegmentedControl(
      children: {
        '语文':Container(child: Text('语文'), padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),),
        '数学':Container(child: Text('数学'), padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),),
        '体育':Container(child: Text('体育'), padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),)
      },
      groupValue: _value,
      onValueChanged: (value){
        setState(() {
          _value = value;
        });
      },
    ),
  );
}
```

![CupertinoSlidingSegmentedControl](../img/CupertinoSlidingSegmentedControl/CupertinoSlidingSegmentedControl.gif)

