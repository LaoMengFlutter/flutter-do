---
title: 'RelativePositionedTransition'
description: '控件介绍'
type: widgets

---



## RelativePositionedTransition

定位控件动画，用在Stack子组件中，用法如下：

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

    _animation = RectTween(
            begin: Rect.fromLTRB(10.0, 10.0, 10.0, 10.0),
            end: Rect.fromLTRB(300.0, 300.0, 0.0, 0.0))
        .animate(_animationController);

    //开始动画
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      color: Colors.blue,
      child: Stack(
        children: <Widget>[
          RelativePositionedTransition(
            rect: _animation,
            size: Size(0.0,0.0),
            child: Container(
              color: Colors.red,
            ),
          )
        ],
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

效果如下：

<img src="../img/RelativePositionedTransition/RelativePositionedTransition_1.gif" style="zoom:50%;" />

