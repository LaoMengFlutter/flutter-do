---
title: 'Scaffold'
description: '控件介绍'
type: widgets

---



## Scaffold

Scaffold实现了Material风格的基本布局结构，它提供了展示`drawers`、`snack bars`和`bottom sheets`的功能。

基本用法如下：

```dart
Scaffold(
  appBar: AppBar(
    title: Text('老孟'),
  ),
  body: Center(
    child: Text('一枚有态度的程序员'),
  ),
)
```

更多属性请查看AppBar控件详细说明，效果如下：

![](https://img-blog.csdnimg.cn/20200324154020189.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70)

顶部蓝色区域就是`appBar`，通常设置AppBar。

`drawer`和`endDrawer`分别表示从左边和右边出现的抽屉式控件，用法如下：

```dart
Scaffold(
  drawer: Drawer(),
  endDrawer: Drawer(),
  ...
)
```

更多属性请查看Drawer控件详细说明。

效果如下：

![](https://img-blog.csdnimg.cn/20200324154053466.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70)

`bottomNavigationBar`表示底部导航，用法如下：

```dart
Scaffold(
  bottomNavigationBar: BottomNavigationBar(
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(title: Text('首页'),icon: Icon(Icons.home)),
      BottomNavigationBarItem(title: Text('书籍'),icon: Icon(Icons.book)),
      BottomNavigationBarItem(title: Text('我的'),icon: Icon(Icons.perm_identity)),
    ],
  ),
  ...
)
```

更多属性请查看BottomNavigationBar控件详细说明。

效果如下：

![](https://img-blog.csdnimg.cn/2020032415411751.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70)

`floatingActionButton`默认位于右下角，

```dart
Scaffold(
  floatingActionButton: FloatingActionButton(),
)
```

效果如下：

![](https://img-blog.csdnimg.cn/20200324154134925.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70)

改变其位置，设置按钮嵌入底部导航栏：

```dart
Scaffold(
  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  floatingActionButton: FloatingActionButton(),
  bottomNavigationBar: BottomNavigationBar(
    backgroundColor: Colors.yellow,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.person),title: Text('老孟')),
      BottomNavigationBarItem(icon: Icon(Icons.home),title: Text('程序员'))
    ],
  )
)
```

用法如下：

![](https://img-blog.csdnimg.cn/20200324154151315.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70)



`persistentFooterButtons`位于`body`之下，`bottomNavigationBar`之上，不会随着`body`滚动而滚动，用法如下：

```dart
Scaffold(
  persistentFooterButtons: <Widget>[
    FlatButton(onPressed: (){},child: Text('FlatButton'),),
    FlatButton(onPressed: (){},child: Text('FlatButton'),),
    FlatButton(onPressed: (){},child: Text('FlatButton'),),
  ],
```

效果如下：

![](https://img-blog.csdnimg.cn/20200324154214463.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70)

`bottomSheet`位于`persistentFooterButtons`之上，用法如下：

```dart
Scaffold(
  bottomSheet: BottomSheet(
      onClosing: () {},
      backgroundColor: Colors.lightBlue,
      builder: (context) {
        return Container(
          height: 150,
          alignment: Alignment.center,
          child: Text('BottomSheet'),
        );
      }),
      ...
 )
```

效果如下：

![](https://img-blog.csdnimg.cn/20200324154240130.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70)

除了可以设置固定的`bottomSheet`外，还可以通过`showBottomSheet`方法弹出此控件，具体查看`showBottomSheet`的说明。

