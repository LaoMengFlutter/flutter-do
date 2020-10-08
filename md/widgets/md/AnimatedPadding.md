---
title: 'AnimatedPadding'
description: '控件介绍'
type: widgets

---

# AnimatedPadding

AnimatedPadding是一个隐式的动画组件，提供动态改变内边距的动画组件，用法如下：

```dart
var _padding = 0.0;
AnimatedPadding(
      padding: EdgeInsets.symmetric(horizontal: _padding),
      duration: Duration(seconds: 2),
      child: Container(color: Colors.red),
    )
```

`duration`参数是动画执行的时间。如果仅仅是构建这样一个组件是不会有动画效果，需要让`padding`参数发生变化，点击按钮设置新的`_padding`值：

```dart
RaisedButton(
          onPressed: () {
            setState(() {
              _padding = 50;
            });
          },
        )
```

效果如下：

![](../img/AnimatedPadding/20200306102128558.gif)

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

