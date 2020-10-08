---
title: 'AnimatedBuilder'
description: '控件介绍'
type: widgets
---

# AnimatedBuilder

AnimatedBuilder可以让我们轻松的构建动画控件，下面的案例是让flutter logo图片旋转，代码如下：

```dart
class _TestState extends State<Test> with TickerProviderStateMixin {
AnimationController animationController;

@override
void initState() {
  animationController =
      AnimationController(duration: Duration(seconds: 2), vsync: this)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            animationController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            animationController.forward();
          }
        });
  animation = Tween(begin: 0.0, end: 2.0 * pi).animate(animationController);
  //开始动画
  animationController.forward();
)

@override
Widget build(BuildContext context) {
  return AnimatedBuilder(
    animation: animation,
    builder: (BuildContext context, Widget child) {
      return Transform.rotate(
        angle: animation.value,
        child: child,
      );
    },
    child: FlutterLogo(size: 60,),
  );
}
@override
  dispose() {
    super.dispose();
    animationController.dispose();
  }
}
```

效果如下：

![](../img/AnimatedBuilder/20200324155951524.gif)

`builder`方法是animation的值发生变化会调用builder函数，构建新的组件。

`animation`参数表示动画。

`child`参数将会传递给builder方法，如果`builder`返回一个不依赖于animation的组件，那么这个子控件不会每次都重建，`child`参数可以不设置，但官方建议设置，它在某些情况下可以优化其体验。

