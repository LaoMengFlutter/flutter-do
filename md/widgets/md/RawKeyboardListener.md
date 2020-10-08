---
title: 'RawKeyboardListener'
description: ''
type: widget
---



# RawKeyboardListener



此控件用于键盘的事件，包括物理按键，通常用于游戏类应用。

**此控件目前在部分手机上无法监听到，无法确定是国内手机厂商修改所致，还是flutter系统的bug。也可以关注 [github issue](https://github.com/flutter/flutter/issues?q=is%3Aissue+is%3Aopen+RawKeyboardListener)，实时了解其进展**

用法：

```dart
TextEditingController _controller = new TextEditingController();
FocusNode _textNode = new FocusNode();

handleKey(RawKeyEvent key) {
  print("Event runtimeType is ${key.runtimeType}");
  if(key.runtimeType.toString() == 'RawKeyDownEvent'){
    RawKeyEventDataAndroid data = key.data as RawKeyEventDataAndroid;
    String _keyCode;
    _keyCode = data.keyCode.toString(); //keycode of key event (66 is return)

    print("why does this run twice $_keyCode");
  }
}

@override
Widget build(BuildContext context) {
  TextField _textField = new TextField(
    controller: _controller,
  );
  FocusScope.of(context).requestFocus(_textNode);
  return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _key.currentState.removeItem(4);
            },
          )
        ],
      ),
      body: Scaffold(
        body: RawKeyboardListener(
            focusNode: _textNode,
            onKey: handleKey,
            child: _textField
        ),
      ));
}
```

