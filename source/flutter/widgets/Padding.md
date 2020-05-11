---
title: 'Padding'
description: '控件介绍'
type: widgets

---

# Padding

Padding提供设置内边距的组件，用法非常简单：

```dart
Padding(
  padding: EdgeInsets.all(20),
  child: Text('老孟，一枚有态度的程序员'),
)
```

主要看下设置padding值的方式，单独设置每一个边：

```dart
Padding(
  padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
  child: Text('老孟，一枚有态度的程序员'),
)
```

设置垂直和水平方向：

```dart
EdgeInsets.symmetric(vertical: 5,horizontal: 5)
```

