---
title: 'AbsorbPointer | IgnorePointer'
description: '在命中测试期间(不)吸收指针的控件'
type: widgets


---



## AbsorbPointer

AbsorbPointer是一种禁止用户输入的控件，比如按钮的点击、输入框的输入、ListView的滚动等，你可能说将按钮的`onPressed`设置为null，一样也可以实现，是的，但AbsorbPointer可以提供多组件的统一控制，而不需要你单独为每一个组件设置。

用法如下：

```dart
AbsorbPointer(
  child: Row(
    children: <Widget>[
      RaisedButton(onPressed: (){},),
      RaisedButton(onPressed: (){},),
      RaisedButton(onPressed: (){},),
      RaisedButton(onPressed: (){},),

    ],
  ),
)
```

默认情况下，这些按钮是否响应点击事件的，如果想要响应点击事件只需设置`absorbing`为false即可：

```dart
AbsorbPointer(
  absorbing: false,
  ...
)
```



## IgnorePointer

IgnorePointer的用法和AbsorbPointer一样，而且达到的效果一样，用法如下：

```dart
IgnorePointer(
  child: Row(
    children: <Widget>[
      RaisedButton(onPressed: (){},),
      RaisedButton(onPressed: (){},),
      RaisedButton(onPressed: (){},),
      RaisedButton(onPressed: (){},),
    ],
  ),
)
```



## 区别

`AbsorbPointer`本身可以接收点击事件，消耗掉事件，而`IgnorePointer`无法接收点击事件，其下的控件可以接收到点击事件（不是子控件）。

如果有2个盒子，一个200x200的红色盒子，一个100x100的蓝色盒子，蓝色盒子位于红色盒子之上居中显示，给2个盒子添加点击事件，如下：

```dart
return Container(
      height: 200,
      width: 200,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Listener(
            onPointerDown: (v) {
              print('click red');
            },
            child: Container(
              color: Colors.red,
            ),
          ),
          Listener(
            onPointerDown: (v) {
              print('click red');
            },
            child: Container(
              color: Colors.blue,
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
```

点击蓝色盒子时，打印结果：

```dart
flutter: click blue
```

点击蓝色盒子区域以外的红色盒子，打印结果：

```
flutter: click red
```

此时用`AbsorbPointer`包裹蓝色盒子：

```dart
return Container(
  height: 200,
  width: 200,
  child: Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Listener(
        onPointerDown: (v) {
          print('click red');
        },
        child: Container(
          color: Colors.red,
        ),
      ),
      Listener(
        onPointerDown: (v) {
          print('click blue self');
        },
        child: AbsorbPointer(
          child: Listener(
            onPointerDown: (v) {
              print('click blue child');
            },
            child: Container(
              color: Colors.blue,
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    ],
  ),
);
```

点击蓝色盒子，打印如下：

```
flutter: click blue self
```

说明`AbsorbPointer`本身接收到了点击事件，将`AbsorbPointer`改为`IgnorePointer`,打印如下：

```dart
flutter: click red
```

点击事件穿透蓝色盒子到红色盒子，红色盒子接收到了点击事件。

## 使用场景

1、根据业务需求禁用/启用多个组件。

2、根据业务需求禁用/启用整个App。















