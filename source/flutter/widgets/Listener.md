---
title: 'Listener'
description: '监听指针事件的小部件'
type: widgets
---



## Listener

`Listener`是一个监听指针事件的控件，比如按下、移动、释放、取消等指针事件，但`Listener`无法监听鼠标特有的事件，比如：移入、悬停、移出事件。鼠标事件使用`MouseRegion`监听。



通常情况下，监听手势事件使用`GestureDetector`，`GestureDetector`是更高级的手势事件。



`Listener`的事件介绍如下：

-  onPointerDown：按下时回调
-  onPointerMove：移动时回调
-  onPointerUp：抬起时回调



用法如下：

```dart
Listener(
  onPointerDown: (PointerDownEvent pointerDownEvent) {
    print('$pointerDownEvent');
  },
  onPointerMove: (PointerMoveEvent pointerMoveEvent) {
    print('$pointerMoveEvent');
  },
  onPointerUp: (PointerUpEvent upEvent) {
    print('$upEvent');
  },
  child: Container(
    height: 200,
    width: 200,
    color: Colors.blue,
    alignment: Alignment.center,
  ),
)
```

打印结果如下：

```dart
flutter: PointerDownEvent#68250(position: Offset(170.3, 417.7), localPosition: Offset(63.3, 69.7), timeStamp: 2:34:54.781426, pointer: 15, kind: touch, device: 140265326177760, buttons: 1, down: true, pressure: 0.0, pressureMin: 0.0, pressureMax: 6.7, radiusMajor: 6.7, radiusMin: 5.0, radiusMax: 8.3, orientation: -1.6)

flutter: PointerMoveEvent#5c647(position: Offset(170.3, 418.0), localPosition: Offset(63.3, 70.0), delta: Offset(0.0, 0.3), timeStamp: 2:34:55.140060, pointer: 15, kind: touch, device: 140265326177760, buttons: 1, down: true, pressure: 0.9, pressureMin: 0.0, pressureMax: 6.7, radiusMajor: 6.7, radiusMin: 5.0, radiusMax: 8.3, orientation: -1.6)
..move...

flutter: PointerUpEvent#15231(position: Offset(198.3, 483.0), localPosition: Offset(91.3, 135.0), timeStamp: 2:34:56.992398, pointer: 15, kind: touch, device: 140265326177760, down: false, pressure: 0.0, pressureMin: 0.0, pressureMax: 6.7, orientation: -1.6)


```

常用属性说明如下：

- `position`：相对屏幕的坐标的偏移。

- `localPosition`：相对当前控件的偏移。
- `pressure`：按压力度。
- `delta`：2次指针移动事件的偏移。
- `orientation`：指针移动方向



其实我这里想写的非常多，Flutter的事件传递机制是一大重点和难点，考虑很久还是没有写，主要是怕对初学者不友好，后面会在进阶的文章里面好好说说事件传递机制。