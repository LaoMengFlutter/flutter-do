---
title: 'DatePicker'
description: '控件介绍'
type: widgets

---



## DatePicker

Flutter并没有DatePicker这个控件，而是需要使用`showDatePicker`方法弹出日期选择控件，基本用法如下：

```dart
RaisedButton(
  onPressed: () async {
    var result = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2021));
    print('$result');
  },
)
```

`initialDate`初始化时间，通常情况下设置为当前时间。

`firstDate`表示开始时间，不能选择此时间前面的时间。

`lastDate`表示结束时间，不能选择此时间之后的时间。

`showDatePicker`方法是Future方法，点击日期选择控件的确定按钮后，返回选择的日期。

效果如下：

<img src="https://img-blog.csdnimg.cn/20200324161424204.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70" style="zoom:33%;" />

`selectableDayPredicate`参数控制可选日期，返回true表示日期可选，用法如下：

```dart
showDatePicker(
  selectableDayPredicate: (DateTime day) {
    return day.difference(DateTime.now()).inDays < 2;
  },
  ...
)
```

表示后天之前的时间可选，效果如下：

<img src="https://img-blog.csdnimg.cn/20200324161500579.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70" style="zoom:33%;" />

19日及以后的日期变为灰色，不可选状态。



`builder`参数用于设置控件的主题，设置深色主题用法如下：

```dart
showDatePicker(
  builder: (context, child) {
    return Theme(
      data: ThemeData.dark(),
      child: child,
    );
  },
	...
)
```

效果如下：

<img src="https://img-blog.csdnimg.cn/2020032416153162.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70" style="zoom:33%;" />



### 中文支持

增加国际化处理，在pubspec.yaml添加支持：

```
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter    
```

在顶级控件MaterialApp添加支持：

```dart
MaterialApp(
  localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  supportedLocales: [
    const Locale('zh', 'CH'),
    const Locale('en', 'US'),
  ],
  locale: Locale('zh'),
  ...
)
```

设置`showDatePicker`的local参数如下：

```dart
showDatePicker(
  locale: Locale('zh'),
  ...
)
```

效果如下：

<img src="https://img-blog.csdnimg.cn/20200324161556894.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70" style="zoom:33%;" />



## TimePicker

TimePicker和DatePicker一样，需要使用`showTimePicker`方法，用法如下：

```dart
RaisedButton(
  onPressed: () async {
    showTimePicker(
        context: context, initialTime: TimeOfDay.now());
  },
)
```

效果如下：

<img src="https://img-blog.csdnimg.cn/2020032416162367.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70" style="zoom:33%;" />

​	`builder`参数用于控制子控件，可以向DatePicker一样设置深色主题，还可以设置其显示24小时，用法如下：

```dart
showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(alwaysUse24HourFormat: true),
        child: child,
      );
    });
```

效果如下：

<img src="https://img-blog.csdnimg.cn/20200324161652934.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70" style="zoom:33%;" />



## 中文支持

添加国际化支持，步骤DatePicker中文支持，但`showTimePicker`并没有local参数，使用`builder`参数设置，如下：

```dart
showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return Localizations(
          locale: const Locale('zh'),
          child: child,
          delegates: <LocalizationsDelegate>[
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ]
      );
    });
```

效果如下：

<img src="https://img-blog.csdnimg.cn/20200324161724121.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70" style="zoom:33%;" />



## CupertinoDatePicker

ios风格的日期选择器，用法如下：

```dart
 var _dateTime = DateTime.now();
CupertinoDatePicker(
  initialDateTime: _dateTime,
  onDateTimeChanged: (date) {
    setState(() {
      _dateTime = date;
    });
  },
)
```

效果如下：

![](https://img-blog.csdnimg.cn/20200324161745157.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70)

`mode`参数设置日期的格式：

-  time：只显示时间，效果：`4 | 14 | PM `
-  date：只显示日期，效果：`July | 13 | 2012`
-  dateAndTime：时间和日期都显示，效果： `Fri Jul 13 | 4 | 14 | PM `



设置最大日期和最小日期：

```dart
CupertinoDatePicker(
  minimumDate: DateTime.now().add(Duration(days: -1)),
  maximumDate: DateTime.now().add(Duration(days: 1)),
  ...
)
```

效果如下：

![](https://img-blog.csdnimg.cn/20200324161805697.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70)



使用24小时制：

```dart
CupertinoDatePicker(
  use24hFormat: true,
	...
)
```



## CupertinoTimerPicker

CupertinoTimerPicker 是ios风格的时间选择器，基本用法如下：

```dart
CupertinoTimerPicker(
  onTimerDurationChanged: (Duration duration){
  },
)
```

效果如下：

![](https://img-blog.csdnimg.cn/20200324161828405.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70)

设置只显示小时和分钟：

```dart
CupertinoTimerPicker(
  mode: CupertinoTimerPickerMode.hm,
  ...
)
```

默认情况下，CupertinoTimerPicker显示0:0:0，设置显示当前时间：

```dart
var now = DateTime.now();
return Container(
  height: 200,
  child: CupertinoTimerPicker(
    initialTimerDuration: Duration(hours: now.hour,minutes: now.minute,seconds: now.second),
    onTimerDurationChanged: (Duration duration) {},
  ),
);
```







