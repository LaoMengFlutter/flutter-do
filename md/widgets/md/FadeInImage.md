---
title: 'FadeInImage'
description: '加载目标[image]时显示[占位符]图像的图像，载后淡入新图像'
type: widgets

---

# FadeInImage

在加载网络图片时通常需要一张展位图，当网络图片没有加载时先显示占位图，FadeInImage可以很好的实现这个功能。

基本用法：

```dart
FadeInImage(
  placeholder: AssetImage('...'),
  image: NetworkImage('...'),
)
```

开始的时候先显示placeholder图片，等网络图片加载完成显示image，动画的效果是渐隐渐显，还可以设置其动画的时长和动画曲线，包括进场和出场：

```dart
FadeInImage(
  fadeOutDuration: Duration(milliseconds: 200),
  fadeInCurve: Curves.easeIn,
```

其他属性参考Image。

