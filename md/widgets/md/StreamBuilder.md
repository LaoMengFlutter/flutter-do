---
title: 'StreamBuilder'
description: '控件介绍'
type: widgets

---

# StreamBuilder

 StreamBuilder组件用于异步接收数据更新组件，与FutureBuilder不同的地方在于StreamBuilder可以接收多个异步操作。

使用StreamBuilder首先需要构建一个Stream，我们可以使用StreamController，用法如下：

```dart
StreamController<String> _streamController;

@override
  void initState() {
    _streamController = StreamController<String>();
    ...
  }

```

StreamBuilder的用法如下：

```dart
StreamBuilder(
  stream: _streamController.stream,
  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
    if (snapshot.hasData) {
      return Text(snapshot.data);
    }
    return Text('未收到数据');
  },
)
```

注意最后关闭：

```
@override
dispose() {
  super.dispose();
  _streamController.close();
}
```

通过点击按钮发送数据：

```dart
RaisedButton(
  child: Text('发送数据'),
  onPressed: () {
    _streamController.add('老孟，一枚有态度的程序员');
  },
)
```

此时就会构建新的文本。