---
title: 'ExpansionTile'
description: '控件介绍'
type: widgets

---

# ExpansionTile

 ExpansionTile 组件是分组组件，点击尾部的按钮打开/关闭子控件。

基本用法如下：

```dart
ExpansionTile(
  title: Text('学科'),
  children: <Widget>[
    Text('英语'),
    Text('数学'),
    Text('语文')
  ],
)
```

效果如下：

![](../img/ExpansionTile/20200324162517192.gif)

设置头部图标、子标题、背景颜色：

```dart
ExpansionTile(
  leading: Icon(Icons.home),
  subtitle: Text('各种学科'),
  backgroundColor: Colors.greenAccent,
  title: Text('学科'),
  children: <Widget>[
    Text('英语'),
    Text('数学'),
    Text('语文')
  ],
)
```

效果如下：

![](../img/ExpansionTile/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70-20201008213105665.png)

`initiallyExpanded`表示是否打开，用法如下：

```dart
ExpansionTile(
  initiallyExpanded: true,
  ...
)
```

`onExpansionChanged`打开/关闭回调：

```dart
ExpansionTile(
  onExpansionChanged: (bool value) {},
  ...
)
```





