---
title: 'ListView'
description: '控件介绍'
type: widgets

---

# ListView

ListView是我们最常用的组件之一，用于展示大量数据的列表。

## 构建方式

数据较少时，可以直接使用如下方式：

```dart
ListView(
  children: <Widget>[
    item,item1,item2,
  ],
)
```

这种方式一次加载所有的组件，没有“懒加载”，因此当有大量数据时，使用动态创建列表的方式：

```dart
ListView.builder(
  itemBuilder: (BuildContext context, int index) {
    return Text('Item$index');
  },
  itemExtent: 50,
)
```

如果想在每一项中间增加分割线可以使用如下方式：

```dart
ListView.separated(
  itemBuilder: (BuildContext context, int index) {
    return Text('Item$index');
  },
  separatorBuilder: (BuildContext context, int index){
    return Divider();
  },
  itemCount: 50,
)
```

一般上面的方式就够用了，如果以上都不能满足你的要求，还可以使用`ListView.custom`，自定义SliverChildDelegate构建自己的ListView。



## 基础属性

通过`scrollDirection`参数控制滚动方向，默认是垂直方向，向上滚动，设置为水平方向：

```
ListView.builder(
    scrollDirection: Axis.horizontal,
    ...
)
```

滚动方向如果是垂直方向，默认是向上滚动，通过`reverse`参数设置其向下滚动，代码如下：

```
ListView.builder(
    reverse: true,
    ...
)
```

`controller`可以控制ListView的滚动，比如获取当前滚动的位置，或者代码直接滚动到指定位置，用法如下：

```dart
ScrollController controller;
  @override
  void initState() {
    super.initState();
    controller = ScrollController()
    ..addListener((){
      print('${controller.position}');
    });
    
  }
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller:controller,
        itemBuilder: (context, index) {
          return Text('Item $index');
        });
  }
```

`physics`参数控制滚动到物理特性，比如设置为不可滚动：

```dart
ListView.builder(
    physics: NeverScrollableScrollPhysics(),
  ···
)
```

系统提供的ScrollPhysics有：

- AlwaysScrollableScrollPhysics：总是可以滑动
- NeverScrollableScrollPhysics：禁止滚动
- BouncingScrollPhysics ：内容超过一屏 上拉有回弹效果
- ClampingScrollPhysics ：包裹内容 不会有回弹

`addAutomaticKeepAlives`参数表示当关闭屏幕时Item是否进行垃圾回收，默认为true。

