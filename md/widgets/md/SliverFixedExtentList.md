---
title: 'SliverFixedExtentList'
description: ''
type: widget
---



# SliverFixedExtentList



SliverFixedExtentList是sliver系列组件之一，和**SliverList**用法一样，唯一的区别就是SliverFixedExtentList是固定子控件的高度的，SliverFixedExtentList比SliverList更加高效，因为SliverFixedExtentList无需计算子控件的布局。

```dart
CustomScrollView(
  slivers: <Widget>[
    SliverFixedExtentList(
      itemExtent: 100,
      delegate: SliverChildBuilderDelegate((content, index) {
        return Container(
          color: Colors.primaries[index % Colors.primaries.length],
        );
      }, childCount: 50),
    ),
  ],
)
```

![image-20200527180149909](../img/SliverFixedExtentList/image-20200527180149909.png)

