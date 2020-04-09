## 引入
```
dependencies:
  flutter_verification_box: ^1.0.3
```
导入包：
```
import 'package:flutter_verification_box/verification_box.dart';
```

## 使用


```dart
Container(
  height: 45,
  child: VerificationBox(),
)
```

效果如下：

<img src="https://github.com/781238222/imgs/raw/master/verification_box/verification_box_1.png" style="zoom:33%;" />

设置验证码的数量，比如设置4个：

```dart
VerificationBox(
  count: 4,
)
```

效果如下：

![](https://github.com/781238222/imgs/raw/master/verification_box/verification_box_2.png)

设置样式，包括边框的颜色、宽度、圆角：

```dart
VerificationBox(
  borderColor: Colors.lightBlue,
  borderWidth: 3,
  borderRadius: 50,
)
```

效果如下：

![](https://github.com/781238222/imgs/raw/master/verification_box/verification_box_3.png)

除了“盒子”样式，还支持下划线样式：

```dart
VerificationBox(
  type: VerificationBoxItemType.underline,
)
```

效果如下：

![](https://github.com/781238222/imgs/raw/master/verification_box/verification_box_4.png)

设置数字的样式：

```dart
VerificationBox(
  textStyle: TextStyle(color: Colors.lightBlue),
)
```

效果如下：

![](https://github.com/781238222/imgs/raw/master/verification_box/verification_box_5.png)

显示光标，设置光标样式：

```dart
VerificationBox(
  showCursor: true,
  cursorWidth: 2,
  cursorColor: Colors.red,
  cursorIndent: 10,
  cursorEndIndent: 10,
)
```

效果如下：

<img src="https://github.com/781238222/imgs/raw/master/verification_box/verification_box_6.gif" style="zoom:33%;" />

还可以设置光标为整个边框，如下：

```dart
VerificationBox(
  focusBorderColor: Colors.lightBlue,
)
```

效果如下：

<img src="https://github.com/781238222/imgs/raw/master/verification_box/verification_box_7.gif" style="zoom:33%;" />

终极大招，如果你觉得这个效果不好，你可以自定义`decoration`：

```dart
VerificationBox(
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage('images/box.png')),
    ),
    textStyle: TextStyle(color: Colors.lightBlue),
  ),
)
```

效果如下：

<img src="https://github.com/781238222/imgs/raw/master/verification_box/verification_box_8.gif" style="zoom:33%;" />



验证码输入完成后回调`onSubmitted`，用法如下：

```dart
VerificationBox(
  onSubmitted: (value){
    print('$value');
  },
)
```

输入完成后，默认键盘消失，设置为不消失，代码如下：

```dart
VerificationBox(
  unfocus: false,
)
```

