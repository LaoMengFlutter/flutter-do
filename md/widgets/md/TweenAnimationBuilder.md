---
title: 'TweenAnimationBuilder'
description: '控件介绍'
type: widgets

---

# TweenAnimationBuilder

开发App中有时需要一个简单的动画，可以通过AnimationController实现，但比较麻烦，有没有一个内置的隐式动画组件来解决这个问题？TweenAnimationBuilder可以满足你对所有自定义动画的需求，而不用关系AnimationController。

TweenAnimationBuilder用法比较简单，首先需要一个动画时长参数：
```
TweenAnimationBuilder<double>(
	duration: Duration(seconds: 2),
)
```
然后添加一个builder方法，用法如下：
```
builder: (context, value, child) {
        return Container(
          height: value,
          width: value,
          child: child,
        );
      }
```
builder方法有3个参数，第一个是BuildContext，第二个value的类型取决于你要做动画的数据，比如：
```
TweenAnimationBuilder<double>(
	builder: (context, value, child) {
	}
)
```
value的类型就是double，如果是`TweenAnimationBuilder<Color>`,value的类型就是Color。
第三个就是TweenAnimationBuilder的子组件，用于优化。

设置tween（动画的值），比如需要一个100到200的差值，设置如下：
```
tween: Tween<double>(begin: 100.0, end: 200),
```
如果需要颜色值使用`ColorTween`,这样我们的动画组件就可以动起来了。

我们也可以设置动画曲线，设置如下：
```
TweenAnimationBuilder<double>(
	 curve: Curves.bounceIn,
)
```
通过onEnd监听动画完成通知，用法如下：
```
TweenAnimationBuilder<double>(
	 onEnd: () {}
)
```

下面写一个图片不断放大变小的demo：
```
double _value = 200;
  
  @override
  Widget build(BuildContext context) {
    return Center(
        child: TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 100.0, end: _value),
      duration: Duration(seconds: 2),
      curve: Curves.bounceIn,
      builder: (context, value, child) {
        return Container(
          height: value,
          width: value,
          child: child,
        );
      },
      onEnd: () {
        setState(() {
          _value = _value == 200 ? 250 : 200;
        });
      },
      child: Image.network(
        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
        fit: BoxFit.fill,
      ),
    ));
  }
```

效果如下：

![](https://img-blog.csdnimg.cn/20200302175924444.gif)












