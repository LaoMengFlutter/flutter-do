---
title: 'SliverOpacity'
description: ''
type: widgets

---



# SliverOpacity

SliverOpacity是sliver系列组件，子控件为sliver组件，可设置子组件透明度，

```dart
SliverOpacity(
  opacity: 0.5,
  sliver: SliverList(
    delegate: SliverChildBuilderDelegate((content, index) {
      return Container(
        height: 65,
        color: Colors.primaries[index % Colors.primaries.length],
      );
    }, childCount: 50),
  ),
),
```

![image-20200520135033469](../img/SliverOpacity/image-20200520135033469.png)