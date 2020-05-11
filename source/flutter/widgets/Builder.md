---
title: 'Builder'
description: '调用闭包以获取其子控件的控件'
type: widgets
---



## Builder

官方介绍`A platonic widget that calls a closure to obtain its child widget`，直接翻译是：

> 调用闭包以获取其子小部件的小部件

嗯...，反正只看介绍和翻译看不懂，下面来说下Builder能干什么吧。

基础用法：

```dart
Builder(
  builder: (BuildContext context){
    return Container();
  },
)
```

Builder中有一个`builder`，返回一个Widget即可，那和直接使用Container有什么区别吗？

答案肯定是有的，用处主要体现在`context`上。

## 使用场景一

看下这个异常信息：`Scaffold.of() called with a context that does not contain a Scaffold`，这个异常学习Flutter的过程中会经常遇到，原因就是当前的context没有包含在Scaffold控件中，比如下面的写法就会出现此异常：

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('老孟'),
      ),
      body: Center(
        child: RaisedButton(
          color: Colors.pink,
          textColor: Colors.white,
          onPressed: _displaySnackBar(context),
          child: Text('show SnackBar'),
        ),
      ),
    );
  }
}

_displaySnackBar(BuildContext context) {
  final snackBar = SnackBar(content: Text('老孟'));
  Scaffold.of(context).showSnackBar(snackBar);
}
```

使用Build解决此问题：

```dart
Scaffold(
    appBar: AppBar(
        title: Text('老孟'),
    ),
    body: Builder(
        builder: (context) => 
            Center(
            child: RaisedButton(
            color: Colors.pink,
            textColor: Colors.white,
            onPressed: () => _displaySnackBar(context),
            child: Text('老孟'),
            ),
        ),
    ),
);
```



## 使用场景二

自定义事件分发，代码如下：

```dart
NotificationListener<CustomNotification>(
  onNotification: (CustomNotification notification) {
    print('介绍事件——2：${notification.value}');
    return false;
  },
  child: Center(
    child: RaisedButton(
      child: Text('发送'),
      onPressed: () {
        CustomNotification('自定义事件').dispatch(context);
      },
    ),
  ),
)
```

此时点击按钮并不会分发事件，修改如下：

```dart
NotificationListener<CustomNotification>(
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
)
```

只需在RaisedButton外面包裹Builder即可，为什么会出现此问题？

因为没有Builder的`context`表示当前整个控件的`context`，其上并没有NotificationListener监听，而加上Builder后，`context`表示Builder控件，其上有NotificationListener监听