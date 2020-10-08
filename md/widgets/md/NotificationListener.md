---
title: 'NotificationListener'
description: '以冒泡的方式监听[Notification]'
type: widgets

---



## NotificationListener

`NotificationListener`是以冒泡的方式监听`Notification`的组件，冒泡方式就是向上传递，从子组件向父组件传递。

系统定义了很多`Notification`，比如`SizeChangedLayoutNotification`、`ScrollNotification`、`KeepAliveNotification`、`OverscrollIndicatorNotification`、`DraggableScrollableNotification`等。



## 监听ListView的滚动事件

下面监听最常见的ListView：

```dart
NotificationListener<ScrollNotification>(
  onNotification: (ScrollNotification notification) {
    print('$notification');
    return true;
  },
  child: ListView.builder(
    itemBuilder: (context, index) {
      return ListTile(
        title: Text('index:$index'),
      );
    },
    itemCount: 100,
  ),
)
```

打印日志：

```
ScrollStartNotification(depth: 0 (local), FixedScrollMetrics(0.0..[896.0]..4782.0), DragStartDetails(Offset(153.3, 520.3)))

UserScrollNotification(depth: 0 (local), FixedScrollMetrics(0.0..[896.0]..4782.0), direction: ScrollDirection.reverse)

ScrollUpdateNotification(depth: 0 (local), FixedScrollMetrics(1.2..[896.0]..4780.8), scrollDelta: 1.1666666666666667, DragUpdateDetails(Offset(0.0, -1.7)))
...ScrollUpdateNotification...

flutter: ScrollEndNotification(depth: 0 (local), FixedScrollMetrics(296.5..[896.0]..4485.5), DragEndDetails(Velocity(0.0, 0.0)))

flutter: UserScrollNotification(depth: 0 (local), FixedScrollMetrics(296.5..[896.0]..4485.5), direction: ScrollDirection.idle)

```

ScrollNotification中`metrics` 类型是ScrollMetrics，ScrollMetrics属性说明如下：

-  pixels：当前的位置
-  minScrollExtent：最小滚动距离
-  maxScrollExtent：最大滚动距离
-  viewportDimension：滚动控件的长度
-  axisDirection：滚动的方向，向上、下、左、右
-  axis：滚动控件的轴向，垂直或者水平
-  outOfRange：是否超出滚动范围
-  atEdge：是否在边缘（开始或者结束的位置），
-  extentBefore：距离开始的距离，==0，表示在开始处。
-  extentAfter：距离结尾的距离，==0，表示在末尾处。
-  extentInside：控件范围内的列表长度



## 自定义监听事件

自定义事件：

```dart
class CustomNotification extends Notification {
  CustomNotification(this.value);

  final String value;
}
```

发送和接收事件：

```dart
NotificationListener<CustomNotification>(
  onNotification: (CustomNotification notification) {
    print('介绍事件——2：${notification.value}');
    return true;
  },
  child: Center(
    child: Builder(
      builder: (context) {
        return RaisedButton(
          child: Text('发送'),
          onPressed: () {
            CustomNotification('自定义事件').dispatch(context);
          },
        );
      },
    ),
  ),
)
```

运行打印 ：

```dart
flutter: 介绍事件——2：自定义事件
```

`onNotification`的方法需要返回bool值，返回true，表示当前事件不在向上传递，false表示继续向上传递，

代码修改如下：

```dart
NotificationListener<CustomNotification>(
    onNotification: (CustomNotification notification) {
      print('介绍事件——1：${notification.value}');
      return true;
    },
    child: NotificationListener<CustomNotification>(
      onNotification: (CustomNotification notification) {
        print('介绍事件——2：${notification.value}');
        return false;
      },
      child: Center(
        child: Builder(
          builder: (context) {
            return RaisedButton(
              child: Text('发送'),
              onPressed: () {
                CustomNotification('自定义事件').dispatch(context);
              },
            );
          },
        ),
      ),
    ))
```

在事件-2中返回false，打印日志：

```dart
flutter: 介绍事件——2：自定义事件
flutter: 介绍事件——1：自定义事件
```

返回true，打印日志：

```
flutter: 介绍事件——2：自定义事件
```

说明，返回true，当前事件不在向上传递。