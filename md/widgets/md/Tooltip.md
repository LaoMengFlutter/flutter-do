---
title: 'Tooltip'
description: '控件介绍'
type: widgets

---

# Tooltip

Tooltip是一个消息提示组件，当用户点击或者长按时显示提示，在屏幕阅读器能够使它语音化，这有助于视力障碍人士阅读，用法如下：

```dart
Tooltip(
  message: '这是提示',
  child: Icon(Icons.storage),
)
```

效果如下：

![](../img/Tooltip/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70-20201008221434084.png)

我们还可以设置提示的宽高、内外边距、垂直偏移，用法如下：

```dart
Tooltip(
  padding: EdgeInsets.all(2.0),
  margin: EdgeInsets.all(5.0),
  verticalOffset: 2,
  message: '这是提示',
  child: Icon(Icons.storage),
)
```

设置样式及字体样式，用法如下：

```dart
Tooltip(
  textStyle: TextStyle(color: Colors.blue),
  decoration: BoxDecoration(
    color: Colors.red
  ),
  message: '这是提示',
  child: Icon(Icons.storage),
)
```

效果如下：

![](../img/Tooltip/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70-20201008221438671.png)

设置显示和等待时长，用法如下：

```dart
Tooltip(
  waitDuration: Duration(seconds: 1),
  showDuration: Duration(seconds: 2),
  message: '这是提示',
  child: Icon(Icons.storage),
)
```

