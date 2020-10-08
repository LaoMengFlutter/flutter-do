---
title: 'ExpandIcon'
description: '旋转展开/折叠按钮'  
type: widget
---

# ExpandIcon

ExpandIcon是一个旋转展开/折叠按钮的组件。

基本用法如下：

```dart
bool _expanded = false;
return ExpandIcon(
  onPressed: (value) {
    setState(() {
      _expanded = !_expanded;
    });
  },
  isExpanded: _expanded,
);
```

效果如下：

![](../img/ExpandIcon/image-20200428173826602.png)

点击时，向下的箭头旋转180度。

设置大小和颜色：

```dart
ExpandIcon(
  size: 48,
  color: Colors.blue,
  ...
)
```

效果如下：

![](../img/ExpandIcon/image-20200428174011237.png)

设置禁用颜色和打开颜色：

```dart
ExpandIcon(
  disabledColor: Colors.green,
  expandedColor: Colors.blue,
  color: Colors.red,
  onPressed: (value) {
    setState(() {
      _expanded = !_expanded;
    });
  },
  isExpanded: _expanded,
)
```

效果如下：

![](../img/ExpandIcon/image-20200428191552739.png)

`color`：正常未打开状态箭头的颜色。

`disabledColor`：禁用状态（onPressed = null）箭头的颜色。

`expandedColor`：打开状态箭头的颜色。

