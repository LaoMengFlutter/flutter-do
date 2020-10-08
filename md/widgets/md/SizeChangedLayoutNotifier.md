---
title: 'SizeChangedLayoutNotifier SizeChangedLayoutNotification'
description: ''
type: widget
---



# SizeChangedLayoutNotifier

当子组件尺寸发生变化时，此组件发出通知（Notification），通知类型为SizeChangedLayoutNotification。

```dart
NotificationListener(
  onNotification: (notification) {
    print('child:$notification');
    return false;
  },
  child: SizeChangedLayoutNotifier(
    child: Container(width: size, height: size, color: Colors.red),
  ),
),
```

当改变`size`大小时，`onNotification`接收到通知，打印如下：

```dart
flutter: child:SizeChangedLayoutNotification()
```

[NotificationListener](http://laomengit.com/flutter/widgets/NotificationListener.html) 是接收通知到组件。

## SizeChangedLayoutNotification



 SizeChangedLayoutNotification继承自LayoutChangedNotification，其本质就是一个**Notification**

