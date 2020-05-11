---
title: 'MaterialTapTargetSize'
description: '配置组件点击区域大小的属性'
type: widgets
---



# MaterialTapTargetSize

MaterialTapTargetSize并不是一个组件，是配置组件点击区域大小的属性，很多组件都有`materialTapTargetSize`属性，比如：

```dart
[FloatingActionButton], only the mini tap target size is increased.
* [MaterialButton]
* [OutlineButton]
* [FlatButton]
* [RaisedButton]
* [TimePicker]
* [SnackBar]
* [Chip]
* [RawChip]
* [InputChip]
* [ChoiceChip]
* [FilterChip]
* [ActionChip]
* [Radio]
* [Switch]
* [Checkbox]
```

MaterialTapTargetSize有2个值，分别为：

- padded：最小点击区域为48*48。
- shrinkWrap：子组件的实际大小。



源码如下：

```dart
BoxConstraints constraints;
switch (widget.materialTapTargetSize ?? theme.materialTapTargetSize) {
  case MaterialTapTargetSize.padded:
    constraints = const BoxConstraints(minHeight: kMinInteractiveDimension);
    break;
  case MaterialTapTargetSize.shrinkWrap:
    constraints = const BoxConstraints();
    break;
}
```

kMinInteractiveDimension值为48。