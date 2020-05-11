---
title: 'Overlay'
description: '蒙层控件，可以在当前App显示一个浮层'
type: widgets


---



## Overlay

Overlay是蒙层控件，可以在当前App显示一个浮层，用法如下：

```dart
RaisedButton(
  onPressed: () {
    var overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = new OverlayEntry(
        builder: (context) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(height: 200, width: 200, color: Colors.blue.withOpacity(0.4)),
          );
        });
    overlayState.insert(overlayEntry);
  },
)
```

Overlay通常的用法是，点击一个按钮，弹出一个浮层。

Overlay后一个典型的应用场景就是toast

