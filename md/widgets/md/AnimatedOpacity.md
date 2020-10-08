---
title: 'AnimatedOpacity'
description: '控件介绍'
type: widgets

---

# AnimatedOpacity

AnimatedOpacity是一个隐式的动画组件，它可以使子组件变的透明，用法如下：

```dart
var _opacity = 1.0;
AnimatedOpacity(
  opacity: _opacity,
  duration: Duration(seconds: 2),
  child: Container(
    height: 60,
    width: 150,
    color: Colors.blue,
  ),
)
```

`duration`参数是动画执行的时间，`opacity`参数是透明值，值的范围是0.0-1.0。如果仅仅是构建这样一个组件是不会有动画效果，需要让`opacity`参数发生变化，点击按钮设置新的`opacity`值：

```dart
RaisedButton(
  onPressed: (){
    setState(() {
      _opacity = 0;
    });
  },
)
```

效果如下：

![](../img/AnimatedOpacity/20200305102046711.gif)

通过`curve`参数设置动画执行的曲线，默认直线执行，系统提供了很多中动画执行曲线，比如加速、减速、弹簧等，用法如下：

```dart
AnimatedOpacity(
  curve: Curves.easeIn,
  ...
)
```

如果想要在动画执行结束时处理一些事情，可以在`onEnd`回调中处理，用法如下：

```dart
AnimatedOpacity(
  onEnd: (){
    //动画执行结束回调
  },
  ...
)
```

