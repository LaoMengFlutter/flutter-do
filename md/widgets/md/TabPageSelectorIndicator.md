---
title: 'TabPageSelectorIndicator'
description: '一个指定背景颜色、边框颜色和大小的圆形指示器'
type: widgets

---



# TabPageSelectorIndicator

TabPageSelectorIndicator是一个指定背景颜色、边框颜色和大小的圆形指示器，用法如下：

```dart
TabPageSelectorIndicator(
  backgroundColor: Colors.blue,
  borderColor: Colors.red,
  size: 100,
)
```

效果如下：

![](../img/TabPageSelectorIndicator/image-20200506152445432.png)

TabPageSelectorIndicator是一个相对简单的控件，其实质就是一个Container，源代码如下：

```dart
@override
Widget build(BuildContext context) {
  return Container(
    width: size,
    height: size,
    margin: const EdgeInsets.all(4.0),
    decoration: BoxDecoration(
      color: backgroundColor,
      border: Border.all(color: borderColor),
      shape: BoxShape.circle,
    ),
  );
}
```

