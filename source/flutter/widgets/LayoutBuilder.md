---
title: 'LayoutBuilder'
description: '控件介绍'
type: widgets

---

# LayoutBuilder

有时我们希望根据组件的大小确认组件的外观，比如竖屏的时候上下展示，横屏的时候左右展示，通过LayoutBuilder组件可以获取父组件的约束尺寸。

用法如下：

```dart
LayoutBuilder(
  builder: (BuildContext context, BoxConstraints constraints) {
    var color = Colors.red;
    if (constraints.maxHeight > 100) {
      color = Colors.blue;
    }
    return Container(
      height: 50,
      width: 50,
      color: color,
    );
  },
)
```

当设置父组件的宽高大于100时显示蓝色，小于100时显示红色。