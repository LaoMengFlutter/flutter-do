---
title: 'FloatingActionButton'
description: '控件介绍'
type: widgets

---

# FloatingActionButton

FloatingActionButton通常和Scaffold一起使用，在底部导航栏嵌入按钮。

基本用法如下：

```dart
Scaffold(
  floatingActionButton: FloatingActionButton(),
)
```

没有底部导航栏的位置如下：

![](../img/FloatingActionButton/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70-20201008213435436.png)

加入底部导航栏：

```dart
Scaffold(
  floatingActionButton: FloatingActionButton(),
  bottomNavigationBar: BottomNavigationBar(
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.person),title: Text('老孟')),
      BottomNavigationBarItem(icon: Icon(Icons.home),title: Text('程序员'))
    ],
  ),
)
```

效果如下：

![](../img/FloatingActionButton/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70-20201008213443519.png)

设置按钮嵌入底部导航栏：

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

![](../img/FloatingActionButton/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70-20201008213447741.png)