---
title: 'Radio'
description: 'material风格单选按钮'
type: widgets

---

# Radio

Radio为单选控件，基本用法如下：

```dart
var _radioValue = '1';
var _radioGroupValue = '';
_buildEditable() {
  return Radio(
    value: _radioValue,
    groupValue: _radioGroupValue,
    onChanged: (value){
      print('$value');
      setState(() {
        _radioGroupValue = value;
      });
    },
  );
}
```

Radio控件本身没有State状态，当`value`的值和`groupValue`值相等时，Radio显示选中状态，效果如下：

![](../img/Radio/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70-20201008215710194.png)

通常情况下，有多个单选按钮，当选中一个时，其他自动变为未选中状态，用法如下：

```dart
var _radioGroupValue = '语文';
_buildEditable() {
  return Row(
    children: <Widget>[
      Radio(
        value: '语文',
        groupValue: _radioGroupValue,
        onChanged: (value){
          setState(() {
            _radioGroupValue = value;
          });
        },
      ),
      Radio(
        value: '数学',
        groupValue: _radioGroupValue,
        onChanged: (value){
          setState(() {
            _radioGroupValue = value;
          });
        },
      ),
      Radio(
        value: '英语',
        groupValue: _radioGroupValue,
        onChanged: (value){
          setState(() {
            _radioGroupValue = value;
          });
        },
      ),
    ],
  );
}
```

效果如下：

![](../img/Radio/20200324153839471.gif)

`activeColor`是选中状态下颜色，用法如下：

```dart
Radio(
  activeColor: Colors.red,
  ...
)
```

效果如下：

![](../img/Radio/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70-20201008215717817.png)



## RadioListTile

通常情况下，需要在Radio控件的后面添加说明，用户需要知道自己选择的是什么，当然我们可以直接在Radio后面添加Text控件，不过，Flutter已经为我们提供了相应的控件，就是RadioListTile，通过名字我们就知道这是一个Radio和ListTile 组合的控件，关于ListTile的用法可以查看`ListTile`，用法如下：

```dart
Row(
  children: <Widget>[
    Flexible(
      child: RadioListTile(
        title: Text('语文'),
        value: '语文',
        groupValue: _radioGroupValue,
        onChanged: (value) {
          setState(() {
            _radioGroupValue = value;
          });
        },
      ),
    ),
    Flexible(
        child: RadioListTile(
      title: Text('数学'),
      value: '数学',
      groupValue: _radioGroupValue,
      onChanged: (value) {
        setState(() {
          _radioGroupValue = value;
        });
      },
    )),
    Flexible(
        child: RadioListTile(
      title: Text('英语'),
      value: '英语',
      groupValue: _radioGroupValue,
      onChanged: (value) {
        setState(() {
          _radioGroupValue = value;
        });
      },
    )),
  ],
)
```

效果如下：

![](../img/Radio/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70-20201008215722454.png)







