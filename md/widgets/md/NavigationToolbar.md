---
title: 'NavigationToolbar'
description: '布局水平方向上3个子组件'
type: widgets
---



## NavigationToolbar

`NavigationToolbar`是一个布局控件，控制3个子组件，用法如下：

```dart
NavigationToolbar(
  leading: IconButton(
    icon: Icon(Icons.add),
  ),
  middle: IconButton(
    icon: Icon(Icons.clear),
  ),
  trailing: IconButton(
    icon: Icon(Icons.home),
  ),
)
```

效果如下：

![image-20200421202409777](../img/NavigationToolbar/image-20200421202409777.png)



`centerMiddle`参数表示中间控件是否居中，默认为true，设置为false，中间控件靠近第一个控件，代码如下：

```dart
NavigationToolbar(
  centerMiddle: false,
  leading: IconButton(
    icon: Icon(Icons.add),
  ),
  middle: IconButton(
    icon: Icon(Icons.clear),
  ),
  trailing: IconButton(
    icon: Icon(Icons.home),
  ),
)
```

效果如下：

![image-20200421202626620](../img/NavigationToolbar/image-20200421202626620.png)

`middleSpacing`中间控件的间距，用法如下：

```dart
NavigationToolbar(
  centerMiddle: false,
  middleSpacing: 30,
  leading: IconButton(
    icon: Icon(Icons.add),
  ),
  middle: IconButton(
    icon: Icon(Icons.clear),
  ),
  trailing: IconButton(
    icon: Icon(Icons.home),
  ),
)
```

