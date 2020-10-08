---
title: 'CupertinoPicker'
description: '控件介绍'
type: widgets

---

# CupertinoPicker

ios风格的选择器，和ListWheelScrollView类似。

基本用法如下：

```dart
CupertinoPicker(
  itemExtent: 45,
  onSelectedItemChanged: (index){
	},
  children: <Widget>[
    Container(color: Colors.primaries[1],),
    Container(color: Colors.primaries[2],),
    Container(color: Colors.primaries[3],),
    Container(color: Colors.primaries[4],),
    Container(color: Colors.primaries[5],),
    Container(color: Colors.primaries[6],),
  ],
)
```

效果如下：

![](../img/CupertinoPicker/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70-20201008212139596.png)

`itemExtent`每个子控件的高度。

`onSelectedItemChanged`：选择的选项发生变化回调。

