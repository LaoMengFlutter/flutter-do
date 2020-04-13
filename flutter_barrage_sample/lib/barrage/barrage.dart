import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'barrage_transition.dart';

///
/// des:
///
const Duration _kDuration = Duration(seconds: 10);

class Barrage extends StatefulWidget {
  Barrage(
      {Key key, this.showCount = 10, this.padding = 5, this.randomOffset = 0})
      : super(key: key);

  ///
  /// 显示的行数
  ///
  final int showCount;

  ///
  /// 水平弹幕：表示top、bottom的padding
  /// 垂直弹幕：表示left、right的padding
  ///
  final double padding;

  ///
  /// 随机偏移量
  ///
  final int randomOffset;

  @override
  State<StatefulWidget> createState() => BarrageState();
}

class BarrageState extends State<Barrage> {
  ///
  /// 弹幕列表
  ///
  List<_BarrageTransitionItem> _barrageList = [];

  ///
  /// 定时清除弹幕
  ///
  Timer _timer;
  Random _random = Random();
  double _height;
  double _width;
  int barrageIndex = 0;

  ///
  /// 添加弹幕
  ///
  addBarrage(Widget child, {Duration duration = _kDuration}) {
    double perRowHeight = (_height - 2 * widget.padding) / widget.showCount;
    //计算距离顶部的偏移，
    // 不直接使用_barrageList.length的原因：弹幕结束会删除列表中此项，如果
    // 此时正好有一个弹幕来，会造成此弹幕和上一个弹幕同行
    var index = 0;
    if (_barrageList.length == 0) {
      //屏幕中没有弹幕，从顶部开始
      index = 0;
      barrageIndex++;
    } else {
      index = barrageIndex++;
    }
    var top = _computeTop(index, perRowHeight);
    if (barrageIndex > 100000) {
      //避免弹幕数量一直累加超过int的最大值
      barrageIndex = 0;
    }
    var bottom = _height - top - perRowHeight;
    //给每一项生成一个唯一id，用于删除
    String id = '${DateTime.now().toIso8601String()}:${_random.nextInt(1000)}';
    var item = _BarrageTransitionItem(
      id: id,
      top: top,
      bottom: bottom,
      child: child,
      onComplete: _onComplete,
      duration: duration,
    );
    _barrageList.add(item);
    setState(() {});
  }

  ///
  /// 动画执行完毕删除
  ///
  _onComplete(id) {
    //动画执行完毕删除
    _barrageList.removeWhere((f) {
      return f.id == id;
    });
  }

  @override
  void initState() {
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      _barrageList.removeWhere((f) {
        return false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraintType) {
        _height = constraintType.maxHeight;
        _width = constraintType.maxWidth;

        return ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Stack(
            children: []..addAll(_barrageList),
          ),
        );
      },
    );
  }

  ///
  /// 计算每一行距顶部的偏移，将显示弹幕分为[showCount]份，如果弹幕的比[showCount]多，
  /// 第二轮显示在2个【111111】中间，如下：
  ///
  /// 11111111111111
  ///             2222222
  /// 11111111111111
  ///           2222222
  /// 11111111111111
  ///           2222222
  /// 11111111111111
  ///
  _computeTop(int index, double perRowHeight) {
    //第几轮弹幕
    int num = (index / widget.showCount).floor();
    var top;
    top = (index % widget.showCount) * perRowHeight + widget.padding;

    if (num % 2 == 1 && index % widget.showCount != widget.showCount - 1) {
      //第二轮在第一轮2行弹幕中间
      top += perRowHeight / 2;
    }
    if (widget.randomOffset != 0 && top > widget.randomOffset) {
      top += _random.nextInt(widget.randomOffset) * 2 - widget.randomOffset;
    }
    return top;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _barrageList.clear();
    super.dispose();
  }
}

class _BarrageTransitionItem extends StatelessWidget {
  _BarrageTransitionItem(
      {this.id,
      this.top,
      this.bottom,
      this.child,
      this.onComplete,
      this.duration});

  final String id;
  final double top;
  final double bottom;
  final Widget child;
  final ValueChanged onComplete;
  final Duration duration;
  var _key = GlobalKey<BarrageTransitionState>();

  bool get isComplete => _key.currentState.isComplete;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: top,
      bottom: bottom,
      child: BarrageTransition(
        key: _key,
        child: child,
        onComplete: (v) {
          onComplete(id);
        },
        duration: duration,
      ),
    );
  }
}
