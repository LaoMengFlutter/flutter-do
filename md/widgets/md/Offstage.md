---
title: 'Offstage'
description: '控件介绍'
type: widgets
---



## Offstage

控制是否显示组件：

```dart
Offstage({ 
    Key key, 
    this.offstage = true, 
    Widget child 
  })
```

当offstage为true，当前控件不会被绘制在屏幕上，不会响应点击事件，也不会占用空间，当offstage为false，当前控件则跟平常用的控件一样渲染绘制。

通过一个参数，来控制child是否显示，日常使用中也算是比较常用的控件

当offstage为true，控件隐藏； 当offstage为false，显示；

当Offstage不可见的时候，如果child有动画等，需要手动停掉，Offstage并不会停掉动画等操作。

案例

```dart
Column(
      children: <Widget>[
        Offstage(
          offstage: _isOff,
          child: Text("Offstage组件"),
        ),
        RaisedButton(
          child: Text(_isOff?'显示':'隐藏'),
          onPressed: () {
            setState(() {
              _isOff = !_isOff;
            });
          },
        )
      ],
    )
```

![](../img/Offstage/Offstage_1.gif)



本文由[**Rock**]()提供。

