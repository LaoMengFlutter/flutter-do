---
title: 'ValueListenableBuilder | ValueNotifier'
description: '控件介绍'
type: widgets

---

# ValueListenableBuilder ValueNotifier

在开发应用程序的时候有些数据是全局的，贯穿整个应用程序，比如用户信息，我们希望当这些数据发生变化时，应用程序任何页面的数据都更新，ValueListenableBuilder组件就是解决此问题的。



基本用法如下：

```dart
ValueNotifier<String> _name = ValueNotifier<String>('');

ValueListenableBuilder(
    builder: (context, value, child) {
      return Text(value);
    },
    valueListenable: _name,
    child: Text('未登录'),
  );

```

说明如下：

- `builder`：在数据发生变化时调用，共有3个参数，分别表示context、数据新的值、子控件。

- `valueListenable`：监听到数据，数据类型为ValueNotifier。
- `child`：此参数将会回传给`builder`，可以为null。

更新数据用法如下：

```dart
_name = ValueNotifier<String>('老孟'); //错误用法
_name.value = '老孟';
```

注意这2种写法，第一种是错误的。