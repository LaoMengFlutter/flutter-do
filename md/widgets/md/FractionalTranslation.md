---
title: 'FractionalTranslation'
description: ''
type: widget

---

# FractionalTranslation

根据**Offset**平移控件，比如设置**Offset**的dx为0.25，那么在水平方向上平移控件1/4的宽度。

```dart
Container(
  height: 200,
  width: 200,
  color: Colors.blue,
  child: FractionalTranslation(
    translation: Offset(0.25,.2),
    child: Container(
      color: Colors.red,
    ),
  ),
)
```

![image-20200528092140573](../img/FractionalTranslation/image-20200528092140573.png)

