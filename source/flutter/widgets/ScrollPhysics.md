---
title: 'ScrollPhysics'
description: '可滚动组件的物理滚动特性'
type: widgets
---



# ScrollPhysics

ScrollPhysics并不是一个组件，它定义了可滚动组件的物理滚动特性。例如，当用户达到最大滚动范围时，是停止滚动，还是继续滚动。

滚动组件（CustomScrollView、ScrollView、GridView、ListView等）的`physics`参数表示此属性，

系统提供的ScrollPhysics有：



## AlwaysScrollableScrollPhysics

总是可以滑动，用法如下：

```dart
CustomScrollView(
  physics: AlwaysScrollableScrollPhysics()
  ...
)
```



## NeverScrollableScrollPhysics

禁止滚动，用法如下：

```dart
CustomScrollView(
  physics: NeverScrollableScrollPhysics()
  ...
)
```





## BouncingScrollPhysics

内容超过一屏 上拉有回弹效果，用法如下：

```dart
CustomScrollView(
  physics: BouncingScrollPhysics()
  ...
)
```





## ClampingScrollPhysics

包裹内容 不会有回弹，用法如下：

```dart
CustomScrollView(
  physics: ClampingScrollPhysics()
  ...
)
```



## FixedExtentScrollPhysics

滚动条直接落在某一项上，而不是任何位置，类似于老虎机，只能在确定的内容上停止，而不能停在2个内容的中间，用于可滚动组件的FixedExtentScrollController。



## PageScrollPhysics

用于PageView的滚动特性，停留在页面的边界

