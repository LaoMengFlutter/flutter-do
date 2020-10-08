---
title: 'ListBody'
description: ''
type: widget
---

# ListBody

ListBody是一个沿着给定轴顺序排列子组件的组件，此控件不是很常用，通常使用[ListView](http://laomengit.com/flutter/widgets/ListView.html)和[Column和Row](http://laomengit.com/flutter/widgets/Column.html)。

基本用法如下：

```dart
SingleChildScrollView(
      child: ListBody(
        mainAxis: Axis.vertical,
        reverse: false,
        children: <Widget>[
          Container(
            height: 45,
            color: Colors.primaries[0],
          ),
          Container(
            height: 45,
            color: Colors.primaries[1],
          ),
          Container(
            height: 45,
            color: Colors.primaries[2],
          ),
        ],
      ),
    )
```

![image-20200526115412973](../img/ListBody/image-20200526115412973.png)

`mainAxis`：表示主轴方向，可以设置水平和垂直。

`reverse`：表示是否反转布局方向，比如当前主轴方向是垂直方向，`reverse`设置为true，布局方向为从下倒上，设置为false，布局方向为从上倒下。

