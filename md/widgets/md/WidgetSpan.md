---
title: 'WidgetSpan |文本中嵌入组件'
description: 'span'
type: widgets

---



## WidgetSpan

WidgetSpan在文本中内嵌固定大小Widget。

```
WidgetSpan({
    @required this.child,
    ui.PlaceholderAlignment alignment = ui.PlaceholderAlignment.bottom,//对齐方式 
    TextBaseline baseline,//基准线对齐
    TextStyle style,//文本样式
})
```

案例：

```dart
Text.rich(TextSpan(
      children: <InlineSpan>[
        TextSpan(text: 'Flutter is'),
        WidgetSpan(
            child: SizedBox(
          width: 120,
          height: 50,
          child: Card(child: Center(child: Text('Hello World!'))),
        )),
        TextSpan(text: 'the best!'),
      ],
    ))
```

![image-20200513181409657](../img/WidgetSpan/image-20200513181409657.png)



本文由[**Rock**]()提供。