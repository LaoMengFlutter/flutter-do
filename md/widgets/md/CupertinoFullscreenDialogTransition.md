---
title: 'CupertinoFullscreenDialogTransition'
description: '平移动画组件'
type: widgets

---



## CupertinoFullscreenDialogTransition

不要被这个组件的名字迷惑了，它本质上是一个`SlideTransition`组件，从（0，1）移动到（0，0）。用法如下：

```dart
AnimationController _animationController;

@override
void initState() {
  _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 500),
  );
  super.initState();
}

@override
Widget build(BuildContext context) {
  return Column(
    children: <Widget>[
      Expanded(
        child: Container(),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton(
            onPressed: () => _animationController.forward(),
            child: Text('Forward'),
          ),
          RaisedButton(
            onPressed: () => _animationController.reverse(),
            child: Text('Reverse'),
          ),
        ],
      ),
      CupertinoFullscreenDialogTransition(
        animation: _animationController,
        child: Container(
          color: Colors.blueGrey,
          height: 300,
        ),
      ),

    ],
  );
}
```

效果如下：

<img src="http://img.laomengit.com/12.gif" alt="12" style="zoom:50%;" />

