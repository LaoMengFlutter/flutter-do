---
title: 'SizeTransition'
description: '控件介绍'
type: widgets

---



## SizeTransition

尺寸控件动画，并不是控制子控件的尺寸，而是父控件，用法如下：

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

    _animation = Tween(begin: 0.1, end: 1.5).animate(_animationController);

    //开始动画
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.blue,
      height: 200,
      child: SizeTransition(
        sizeFactor: _animation,
        axis: Axis.horizontal,
        child: Container(
          height: 100,
          width: 100,
          color: Colors.red,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
```

`axis`表示变化的方向，水平或者垂直。

效果如下，红色为子控件，蓝色为父控件：

<img src="../img/SizeTransition/SizeTransition_1.gif" style="zoom:50%;" />

