---
title: 'IconTheme'
description: 'icon 样式'
type: widgets
---

## IconTheme

用于应用栏图标的颜色，不透明度和大小。

```dart
IconTheme({
    Key key,
    @required this.data,
    @required Widget child,
})
```



案例

```dart
IconTheme(
      data:  IconThemeData(color: Colors.blue, opacity: 3.0,size: 36),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Icon(Icons.equalizer),
      ),
    )
```

![](../img/IconTheme/image-20200512061123076.png)



本文由[**Rock**]()提供。







