---
title: 'ShaderMask'
description: '控件介绍'
type: widgets

---



ShaderMask可以让我们将Shader用于任何一个控件上，比如在Text上使用渐变就可以使用ShaderMask来实现：

```
ShaderMask(
      shaderCallback: (Rect bounds) {
        return RadialGradient(
          center: Alignment.topLeft,
          radius: 1.0,
          colors: <Color>[Colors.yellow, Colors.deepOrange],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
      child: Text('老孟，一枚有态度的程序员',style: TextStyle(fontSize: 30),),
    )
```

效果：

![](https://img-blog.csdnimg.cn/20200228173958191.png)

`shaderCallback` 需要返回一个Shader对象，可以通过渐变相关类直接生成Shader：
```
RadialGradient(...).createShader(rect)
```
`blendMode`属性是融合方式，child是目标图像(dst),Shader是源图像(src)，融合方式介绍：
- [英文官方介绍]( https://docs.flutter.io/flutter/dart-ui/BlendMode-class.html)
- [中文 不错的翻译](https://blog.csdn.net/chenlove1/article/details/84574237)












