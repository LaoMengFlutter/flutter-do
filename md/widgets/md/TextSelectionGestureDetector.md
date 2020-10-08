---
title: 'TextSelectionGestureDetector'
description: ''
type: widget
---



# TextSelectionGestureDetector

TextSelectionGestureDetector 是一个文本选择的手势识别控件，和**GestureDetector**的区别是**GestureDetector**只能处理单击或者双击事件，而TextSelectionGestureDetector可以同时处理单击和双击事件。

```dart
TextSelectionGestureDetector(
  child: SelectableText('TextSelectionGestureDetector'),
  onTapDown: (TapDownDetails details) {
    print('onTapDown');
  },
)
```

`onTapDown`：单击事件

```dart
TextSelectionGestureDetector(
  child: SelectableText('TextSelectionGestureDetector'),
  onTapDown: (TapDownDetails details) {
    print('onTapDown');
  },
  onSingleTapUp: (TapUpDetails details) {
    print('onSingleTapUp');
  },
  onSingleTapCancel: () {
    print('onSingleTapCancel');
  },
  onSingleLongTapStart: (LongPressStartDetails details) {
    print('onSingleLongTapStart');
  },
  onSingleLongTapMoveUpdate: (LongPressMoveUpdateDetails details) {
    print('onSingleLongTapMoveUpdate');
  },
  onSingleLongTapEnd: (LongPressEndDetails details) {
    print('onSingleLongTapEnd');
  },
)
```

`onSingleTapUp`：单击抬起事件

`onSingleTapCancel`：单击取消事件

`onSingleLongTapStart`：长按开始事件

`onSingleLongTapMoveUpdate`：长按移动事件

`onSingleLongTapEnd`：长按结束事件

```dart
TextSelectionGestureDetector(
  child: SelectableText('TextSelectionGestureDetector'),
  onDoubleTapDown: (TapDownDetails details) {
    print('onDoubleTapDown');
  },
)
```

`onDoubleTapDown`：双击事件

