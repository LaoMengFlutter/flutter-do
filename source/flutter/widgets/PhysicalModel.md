---
title: 'PhysicalModel'
description: '将其子控件裁剪为一个形状'
type: widgets
---



# PhysicalModel

代表物理层的控件，将其子控件裁剪为一个形状，可以设置阴影值及颜色，用法如下：

```dart
PhysicalModel(
  borderRadius: BorderRadius.circular(20),
  color: Colors.blue,
  elevation: 8,
  child: Container(
    height: 100,
    width: 100,
  ),
)
```

效果如下：

![](http://img.laomengit.com/image-20200506162651020.png)

设置阴影值及颜色：

```dart
PhysicalModel(
  borderRadius: BorderRadius.circular(20),
  color: Colors.blue,
  elevation: 18,
  shadowColor: Colors.red,
  child: Container(
    height: 100,
    width: 100,
  ),
)
```

效果如下：

![](http://img.laomengit.com/image-20200506162829654.png)

