---
title: 'Switch'
description: '控件介绍'
type: widgets

---



## Switch

Switch为material风格的开关组件，基本用法如下：

```dart
var _switchValue = false;
_buildSwitch(){
  return Switch(
    value: _switchValue,
    onChanged: (value){
      setState(() {
        _switchValue = value;
      });
    },
  );
}
```

效果如下：

![](../img/Switch/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70-20201008221042104.png)

设置激活状态下thumb及track颜色，用法如下：

```dart
Switch(
      activeColor: Colors.red,
      activeTrackColor: Colors.blue,
      ...
    ）
```

效果如下：

![](../img/Switch/20200324154506972.png)

注意红色区域为thumb，蓝色区域为track。

thumb区域也可以设置图片，用法如下：

```dart
Switch(
  activeThumbImage: AssetImage('images/bird.png',),
  ...
)
```

效果如下：

![](../img/Switch/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70-20201008221048847.png)



有激活状态样式的设置，也有未激活样式的设置，用法如下：

```dart
Switch(
  inactiveThumbColor: Colors.black54,
  inactiveThumbImage: AssetImage('images/bird.png',),
  inactiveTrackColor: Colors.blue,
  ...
)
```



## SwitchListTile

SwitchListTile是Switch和ListTile组合控件，基本用法如下：

```dart
var _switchValue = false;
_buildSwitch(){
  return SwitchListTile(
    title:Text('是否允许4G下载'),
    value: _switchValue,
    onChanged: (value){
      setState(() {
        _switchValue = value;
      });
    },
  );
}
```

效果如下：

![](../img/Switch/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70-20201008221052854.png)

所有的属性都是Switch和ListTile属性的组合，可到具体控件查看其属性。



## CupertinoSwitch

CupertinoSwitch是ios风格控件，用法和Switch一样，用法如下：

```dart
var _switchValue = false;
_buildSwitch(){
  return CupertinoSwitch(
    value: _switchValue,
    onChanged: (value){
      setState(() {
        _switchValue = value;
      });
    },
  );
}
```

效果如下：

![](../img/Switch/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70-20201008221056586.png)

