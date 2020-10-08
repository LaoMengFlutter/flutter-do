---
title: 'ImageIcon'
description: '来自[ImageProvider]的图标，例如 一个[AssetImage]'
type: widgets
---



## ImageIcon

ImageIcon是一个使用[ImageProvider]来绘制的图标控件，根据图片绘制图标，就是图片上的透明通道不绘制，而不透明的地方使用设置的颜色绘制，

比如下面这张原图

![](../img/ImageIcon/20200324152754782-20201008214103678.png)

除了字体外，其他地方是透明的，将字体显示为蓝色：

```dart
ImageIcon(
  AssetImage('images/name1.png'),
  size: 100,
  color: Colors.blue,
)
```

效果如下：

![](../img/ImageIcon/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70-20201008214107729.png)

这里说下`image`参数，它接收的类型是`ImageProvider`，平时使用的`Image.asset`、`Image.memory`等不是此类型，需要使用AssetImage、MemoryImage等。

