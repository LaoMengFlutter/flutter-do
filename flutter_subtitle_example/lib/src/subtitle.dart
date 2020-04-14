import 'package:example/src/subtitle_entry.dart';
import 'package:flutter/material.dart';

///
/// des: 字幕
///
class Subtitle extends StatefulWidget {
  Subtitle(
    this.data, {
    this.selectedTextStyle,
    this.unSelectedTextStyle,
    this.itemExtent = 45,
    this.diameterRatio = 2.0,
  });

  ///
  /// 字幕数据
  ///
  final List<SubtitleEntry> data;

  ///
  /// 选中字体样式
  ///
  final TextStyle selectedTextStyle;

  ///
  /// 未选中字体样式
  ///
  final TextStyle unSelectedTextStyle;

  ///
  /// 圆筒直径和主轴渲染窗口的尺寸的比，默认值是2，越小表示圆筒越圆
  ///
  final double diameterRatio;

  ///
  /// 每一个item的高度
  ///
  final double itemExtent;

  @override
  State<StatefulWidget> createState() => _SubtitleState();
}

class _SubtitleState extends State<Subtitle> {
  ScrollController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    _controller = ScrollController();
    _startAni();
    super.initState();
  }

  ///
  ///启动
  ///
  _startAni() async {
    if (!_controller.hasClients) {
      Future.delayed(Duration(milliseconds: 50), () {
        _startAni();
      });
      return;
    }
    if (_currentIndex >= widget.data.length - 1) {
      return -1;
    }
    _currentIndex++;
    var delay = _computeDelay();
    Future.delayed(Duration(seconds: delay), () {
      _animateNext();
    });
  }

  ///
  /// 移动到下一个
  ///
  _animateNext() {
    _controller.animateTo((_currentIndex * widget.itemExtent),
        duration: Duration(milliseconds: 200), curve: Curves.linear);
    setState(() {});
    _startAni();
  }

  ///
  /// 计算下一个字幕什么时候移动
  /// -1:最后一个不在移动
  /// >0:几秒后移动
  ///
  _computeDelay() {
    if (_currentIndex >= widget.data.length - 1) {
      return -1;
    }

    String currentTime = widget.data[_currentIndex].time;
    var currList = currentTime.split(RegExp(':'));
    var currMinutes = _str2Int(currList[0]);
    var currSeconds = _str2Int(currList[1]);

    String nextTime = widget.data[_currentIndex + 1].time;
    var nextList = nextTime.split(RegExp(':'));
    var nextMinutes = _str2Int(nextList[0]);
    var nextSeconds = _str2Int(nextList[1]);
    int delay =
        (nextMinutes * 60 + nextSeconds) - (currMinutes * 60 + currSeconds);
    return delay;
  }

  ///
  /// 04->int
  ///
  _str2Int(String str) {
    if (str.startsWith(RegExp('0'))) {
      return int.parse(str.substring(1, 2));
    }
    return int.parse(str);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data == null || widget.data.length == 0) {
      return Container();
    }
    return ListWheelScrollView.useDelegate(
      controller: _controller,
      diameterRatio: widget.diameterRatio,
      itemExtent: widget.itemExtent,
      childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                '${widget.data[index].content}',
                style: _currentIndex == index
                    ? widget.selectedTextStyle
                    : widget.unSelectedTextStyle,
              ),
            );
          },
          childCount: widget.data.length),
    );
  }
}
