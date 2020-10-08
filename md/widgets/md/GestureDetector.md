---
title: 'GestureDetector'
description: '监听手势的组件'
type: widgets
---



## GestureDetector

GestureDetector是手势识别的组件，可以识别点击、双击、长按事件、拖动、缩放等手势。



### 点击事件

点击相关事件包括：

- onTapDown：按下时回调。

- onTapUp：抬起时回调。

- onTap：点击事件回调。

- onTapCancel：点击取消事件回调。

用法如下：

```dart
GestureDetector(
      onTapDown: (TapDownDetails tapDownDetails) {
        print('onTapDown');
      },
      onTapUp: (TapUpDetails tapUpDetails) {
        print('onTapUp');
      },
      onTap: () {
        print('onTap');
      },
      onTapCancel: () {
        print('onTapCancel');
      },
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.red,
        ),
      ),
    )
```

按下然后抬起调用顺序：

```
onTapDown-> onTapUp-> onTap
```

按下后移动的调用顺序：

```
onTapDown-> onTapCancel
```

这种情况下不在调用onTapUp和onTap。



### 双击事件

双击是快速且连续2次在同一个位置点击，双击监听使用onDoubleTap方法，用法如下：

```dart
GestureDetector(
  onDoubleTap: ()=>print('onDoubleTap'),
  child: Center(
    child: Container(
      width: 200,
      height: 200,
      color: Colors.red,
    ),
  ),
)
```

当同时监听onTap和onDoubleTap事件时，只会触发一个事件，如果触发onTap事件，onTap将会延迟触发（延迟时间为系统判断是onDoubleTap事件的间隔），因为系统将会等待一段时间来判断是否为onDoubleTap事件，如果用户只监听了onTap事件则没有延迟。

### 长按事件

长按事件（LongPress）包含长按开始、移动、抬起、结束事件，说明如下：

- onLongPressStart：长按开始事件回调。

- onLongPressMoveUpdate：长按移动事件回调。

- onLongPressUp：长按抬起事件回调。

- onLongPressEnd：长按结束事件回调。

- onLongPress：长按事件回调。

```dart
GestureDetector(
  onLongPressStart: (v) => print('onLongPressStart'),
  onLongPressMoveUpdate: (v) => print('onLongPressMoveUpdate'),
  onLongPressUp: () => print('onLongPressUp'),
  onLongPressEnd: (v) => print('onLongPressEnd'),
  onLongPress: () => print('onLongPress'),
  child: Center(
    child: Container(
      width: 200,
      height: 200,
      color: Colors.red,
    ),
  ),
)
```

用户按下->移动->抬起的过程调用如下：

```
onLongPressStart->onLongPress->onLongPressMoveUpdate->... ->onLongPressMoveUpdate-> onLongPressEnd-> onLongPressUp
```



### 水平/垂直拖动事件

垂直/水平拖动事件包括按下、开始、移动更新、结束、取消事件，以垂直为例说明如下：

- onVerticalDragDown：垂直拖动按下事件回调

- onVerticalDragStart：垂直拖动开始事件回调

- onVerticalDragUpdate：指针移动更新事件回调

- onVerticalDragEnd：垂直拖动结束事件回调

- onVerticalDragCancel：垂直拖动取消事件回调

```dart
GestureDetector(
  onVerticalDragStart: (v) => print('onVerticalDragStart'),
  onVerticalDragDown: (v) => print('onVerticalDragDown'),
  onVerticalDragUpdate: (v) => print('onVerticalDragUpdate'),
  onVerticalDragCancel: () => print('onVerticalDragCancel'),
  onVerticalDragEnd: (v) => print('onVerticalDragEnd'),
  child: Center(
    child: Container(
      width: 200,
      height: 200,
      color: Colors.red,
    ),
  ),
)
```

用户垂直方向拖动调用顺序如下：

```
onVerticalDragDown->onVerticalDragStart->onVerticalDragUpdate-> … -> onVerticalDragUpdate-> onVerticalDragEnd。
```



### 缩放事件

缩放（Scale）包含缩放开始、更新、结束。说明如下：

- onScaleStart：缩放开始事件回调。

- onScaleUpdate：缩放更新事件回调。

- onScaleEnd：缩放结束事件回调。

```dart
GestureDetector(
  onScaleStart: (v) => print('onScaleStart'),
  onScaleUpdate: (ScaleUpdateDetails v) => print('onScaleUpdate'),
  onScaleEnd: (v) => print('onScaleEnd'),
  child: Center(
    child: Container(
      width: 200,
      height: 200,
      color: Colors.red,
    ),
  ),
)
```

缩放需要2个指针，对于手机就是2个手指进行缩放操作，调用顺序如下：

```dart
onScaleStart->onScaleUpdate->…->onScaleUpdate->onScaleEnd
```



