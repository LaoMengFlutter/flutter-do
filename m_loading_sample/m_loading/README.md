所有 loading 动画组件效果展示：[https://github.com/781238222/flutter-do/tree/master/m_loading_sample](https://github.com/781238222/flutter-do/tree/master/m_loading_sample)



所有 loading 动画组件的用法大同小异，都有 duration（动画时长） 和 curve（动画曲线）参数，以及外观样式的设置，下面是一些 loading 动画组件的用法。



小球类的动画组件中有 **BallStyle** 类型的参数，此参数表示小球样式，用法如下：

```dart
BallCircleOpacityLoading(
  ballStyle: BallStyle(
    size: 5,
    color: Colors.red,
    ballType: BallType.solid,
  ),
)
```



![](../img/loading_1.gif)





- size：小球大小
- color：小球颜色
- ballType：小球类型，hollow：空心，solid：实心
- borderWidth：边框宽
- borderColor：边框颜色



设置空心球：

```
BallCircleOpacityLoading(
  ballStyle: BallStyle(
    size: 5,
    ballType: BallType.hollow,
    borderWidth: 1,
    borderColor: Colors.red
  ),
)
```

![](../img/loading_2.gif)

设置动画时长和动画曲线：

```
Ring2InsideLoading(
  color: Colors.blue,
  duration: Duration(milliseconds: 1200),
  curve: Curves.bounceInOut,
)
```

![](../img/loading_3.gif)

非小球类的组件使用：

```dart
PacmanLoading(
  mouthColor: Colors.blue,
  ballColor: Colors.red,
)
```

![](../img/loading_4.gif)



```dart
PouringHourGlassLoading(
  color: Colors.blue,
)
```

![](../img/loading_6.gif)



