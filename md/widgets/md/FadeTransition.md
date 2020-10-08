---
title: 'FadeTransition'
description: '控件介绍'
type: widgets

---

# FadeTransition

FadeTransition提供了快速构建渐隐渐显动画的组件，用法如下：

```dart
class FadeTransitionDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FadeTransitionDemo();
}

class _FadeTransitionDemo extends State<FadeTransitionDemo>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))..repeat();
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: animation,
        child: Container(
          color: Colors.red,
          width: 100,
          height: 100,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
```

动画效果：

![](../img/FadeTransition/20200313183752723.gif)

