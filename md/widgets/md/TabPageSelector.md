---
title: 'TabPageSelector'
description: '小圆圈指示器'
type: widgets
---



# TabPageSelector

TabPageSelector是小圆圈指示器，个数取决于TabController，通常和TabBarView配合使用，用法如下：

```dart
Column(
  children: <Widget>[
    Container(
      height: 50,
      width: double.infinity,
      color: Colors.blue,
      alignment: Alignment.center,
      child: TabPageSelector(
        controller: _tabController,
        color: Colors.white,
        selectedColor: Colors.red,
      ),
    ),
    Expanded(
      child: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.yellow,
          ),
        ],
      ),
    ),
  ],
)
```

效果如下：

![](../img/TabPageSelector/TabPageSelector_1.gif)



TabPageSelector和TabBarView使用同一个`controller`。

