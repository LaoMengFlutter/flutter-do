---
title: 'DefaultTextStyleTransition'
description: '控件介绍'
type: widgets

---



## DefaultTextStyleTransition

TextStyle属性动画，用法如下：

```dart
class AnimationDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimationDemo();
}

class _AnimationDemo extends State<AnimationDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    _animation = TextStyleTween(
            begin: TextStyle(color: Colors.blue, fontSize: 14),
            end: TextStyle(color: Colors.red, fontSize: 24))
        .animate(_animationController);

    //开始动画
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyleTransition(
      style: _animation,
      child: Text('老孟'),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
```

效果如下：

<img src="../img/DefaultTextStyleTransition/DefaultTextStyleTransition-20201008212738081.gif" style="zoom:50%;" />

