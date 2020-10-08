---
title: 'TooltipTheme TooltipThemeData'
description: ''
type: widget
---



# TooltipTheme

用于**Tooltip**样式。

```dart
TooltipTheme(
  data: TooltipTheme.of(context).copyWith(
    decoration: BoxDecoration(
      color: Colors.red
    )
  ),
  child: Tooltip(
    message: '这是提示',
    child: Icon(Icons.storage),
  ),
)
```



![image-20200528171912467](../img/TooltipTheme/image-20200528171912467.png)

## TooltipThemeData

属性说明如下：

```dart
const TooltipThemeData({
  this.height,//高度
  this.padding,//内边距
  this.margin,//外边距
  this.verticalOffset,//垂直偏移
  this.preferBelow,//是否显示在当前控件的下面
  this.excludeFromSemantics,//用于语义解析，比如对于视力障碍人士的会转变为语音
  this.decoration,//背景颜色和形状
  this.textStyle,//文本样式
  this.waitDuration,//等待时常
  this.showDuration,//显示时常
})
```

