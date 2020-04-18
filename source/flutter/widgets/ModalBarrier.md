---
title: 'ModalBarrier'
description: '控件介绍'
type: widgets

---



## ModalBarrier

ModalBarrier是一个静态蒙层控件，ModalRoute控件就是间接使用的此控件，此控件有点击属性，点击会调用

```dart
if (dismissible)
  Navigator.maybePop(context);
```

和Dialog相似，用法如下：

```dart
Center(
  child: Container(
    height: 100,
    width: 100,
    child: ModalBarrier(
      color: Colors.black.withOpacity(.4),
    ),
  ),
)
```

效果如下：

![](http://img.laomengit.com/ModalBarrier_1.png)

`dismissible`表示是否可点击。