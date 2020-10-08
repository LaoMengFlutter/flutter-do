---
title: 'LicensePage'
description: '显示应用程序使用的软件的许可证的页面'
type: widgets

---

# LicensePage

此控件基本不会用到，浏览一下即可。

LicensePage用于描述当前App许可信息，LicensePage需要和showLicensePage配合使用，用法如下：

```dart
showLicensePage(
  context: context,
  applicationIcon: Image.asset(
    'images/bird.png',
    height: 100,
    width: 100,
  ),
  applicationName: '应用程序',
  applicationVersion: '1.0.0',
  applicationLegalese: 'copyright 老孟，一枚有态度的程序员',
);
```

效果如下：

<img src="../img/LicensePage/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70-20201008214436848.png" style="zoom:33%;" />

下面的英文我们是无法更改的。