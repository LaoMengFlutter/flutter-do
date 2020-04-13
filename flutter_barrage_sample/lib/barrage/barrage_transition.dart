import 'package:flutter/material.dart';

///
/// des: 弹幕平移
///
class BarrageTransition extends StatefulWidget {
  const BarrageTransition(
      {Key key,
      @required this.child,
      @required this.duration,
      this.onComplete,
      this.direction = TransitionDirection.rtl})
      : super(key: key);

  final Widget child;

  ///
  /// 平移时间（秒）
  ///
  final Duration duration;

  ///
  /// 平移方向，默认从左到右
  ///
  final TransitionDirection direction;
  final ValueChanged onComplete;

  getComplete() {}

  @override
  State<StatefulWidget> createState() => BarrageTransitionState();
}

class BarrageTransitionState extends State<BarrageTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _animation;

  bool get isComplete => _animationController.isCompleted;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: widget.duration, vsync: this)
    ..addStatusListener((status){
      if(status == AnimationStatus.completed){
        widget.onComplete('');
      }
    });
    var begin = Offset(-1.0, .0);
    var end = Offset(1.0, .0);
    switch (widget.direction) {
      case TransitionDirection.ltr:
        begin = Offset(-1.0, .0);
        end = Offset(1.0, .0);
        break;
      case TransitionDirection.rtl:
        begin = Offset(1.0, .0);
        end = Offset(-1.0, .0);
        break;
      case TransitionDirection.ttb:
        begin = Offset(.0, .0);
        end = Offset(.0, 2.0);
        break;
      case TransitionDirection.btt:
        begin = Offset(.0, 2.0);
        end = Offset(.0, .0);
        break;
    }
    _animation = Tween(begin: begin, end: end).animate(_animationController);
    //开始动画
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

enum TransitionDirection {
  ///
  /// 从左到右
  ///
  ltr,

  ///
  /// 从右到左
  ///
  rtl,

  ///
  /// 从上到下
  ///
  ttb,

  ///
  /// 从下到上
  ///
  btt
}
