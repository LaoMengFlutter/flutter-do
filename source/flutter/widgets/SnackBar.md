---
title: 'SnackBar'
description: '控件介绍'
type: widgets

---

# SnackBar

应用程序有时候需要弹出消息提示用户，比如‘网络连接失败’、‘下载成功’等提示，就像Android
等Toast，在Flutter中使用SnackBar组件，用法如下：

```
Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('老孟，一枚有态度的程序员'),
    ));
```
注意并不是在build方法中直接使用SnackBar组件，而是调用`Scaffold.of(context).showSnackBar`方法，消息会在底部弹出并显示一段时间，默认显示4秒，然后弹出，我们可以设置其显示的时间：
```
Scaffold.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
    ));
```
显示的时间为1秒，`content`属性不一定是文字，也可以是其他组件，比如显示一个图标和文字：
```
Scaffold.of(context).showSnackBar(SnackBar(
      content: Row(
        children: <Widget>[
          Icon(Icons.check,color: Colors.green,),
          Text('下载成功')],
      ),
      duration: Duration(seconds: 1),
    ));
```

效果如下：

![](https://img-blog.csdnimg.cn/20200301172213248.png)

通过`shape`属性设置其形状：
```
Scaffold.of(context).showSnackBar(SnackBar(
      content: Row(
        children: <Widget>[
          Icon(Icons.check,color: Colors.green,),
          Text('下载成功')],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50))
      ),
      duration: Duration(seconds: 1),
    ));
```
效果如下：

![](https://img-blog.csdnimg.cn/20200301172706989.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70)

SnackBar的有2种弹出形式，默认是`fixed`，直接在底部弹出，另一种是`floating`,悬浮在底部，用法如下：

```
Scaffold.of(context).showSnackBar(SnackBar(
      content: Row(
        children: <Widget>[
          Icon(Icons.check,color: Colors.green,),
          Text('下载成功')],
      ),
      behavior: SnackBarBehavior.floating,
    ));
```

`floating`效果：

![](https://img-blog.csdnimg.cn/2020030117321968.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70)

我们还可以对SnackBar增加行为组件，比如增加一个“知道了”按钮，点击“知道了”，消息马上隐藏，用法如下：

```
Scaffold.of(context).showSnackBar(SnackBar(
      content: Row(
        children: <Widget>[
          Icon(Icons.check,color: Colors.green,),
          Text('下载成功')],
      ),
      action: SnackBarAction(
        label: '知道了',
        onPressed: (){},
      ),
    ));
```
效果：

![](https://img-blog.csdnimg.cn/20200301173633785.png)


## 瞬间多个弹出延迟问题

当短时间内多次调用SnackBar方法时，SnackBar消息将会以队列的形式一个一个的弹出，比如下面的代码：
```
RaisedButton(
          child: Text(
            '点我，弹出SnackBar',
          ),
          onPressed: () {

            List.generate(10, (index){
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('我是消息：$index'),
              ));
            });
          },
        )
```

默认情况下每个显示4秒，如果有10个，那么40秒内会一直弹消息，体验明显不友好，我们希望的效果是如果有新的消息时，旧的都消息立刻消失，显示新的消息,只需在弹出新的SnackBar时移除现在的SnackBar，

```
Scaffold.of(context).removeCurrentSnackBar();
Scaffold.of(context).showSnackBar(...);
```










