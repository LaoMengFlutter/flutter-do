import 'dart:math';

import 'package:flutter/material.dart';

///
/// 开关默认width
///
const double _kDefaultWidth = 80;

///
/// 开关默认height
///
const double _kDefaultHeight = 30;

///
/// 开启状态下默认颜色
///
const Color _kDefaultActiveColor = Colors.blue;

///
/// 关闭状态下默认颜色
///
const Color _kDefaultInactiveColor = Colors.grey;

///
/// 开启状态下默认文字
///
const String _kDefaultActiveText = 'ON';

///
/// 关闭状态下默认文字
///
const String _kDefaultInactiveText = 'OFF';

///
/// 开启状态下默认文字样式
///
const TextStyle _kDefaultActiveTextStyle =
    TextStyle(color: Colors.white, fontSize: 10);

///
/// 关闭状态下默认文字样式
///
const TextStyle _kDefaultInactiveTextStyle =
    TextStyle(color: Colors.white, fontSize: 10);

///
/// 默认过度动画时长
///
const Duration _kDefaultDuration = Duration(milliseconds: 800);

///
/// desc: 滚动效果滑块
///
class WheelSwitch extends StatefulWidget {
  const WheelSwitch({
    Key key,
    @required this.value,
    this.onChanged,
    this.width = _kDefaultWidth,
    this.height = _kDefaultHeight,
    this.activeTrackColor = _kDefaultActiveColor,
    this.inactiveTrackColor = _kDefaultInactiveColor,
    this.activeThumbColor = _kDefaultActiveColor,
    this.inactiveThumbColor = _kDefaultInactiveColor,
    this.activeText = _kDefaultActiveText,
    this.inactiveText = _kDefaultInactiveText,
    this.activeTextStyle = _kDefaultActiveTextStyle,
    this.inactiveTextStyle = _kDefaultInactiveTextStyle,
    this.duration = _kDefaultDuration,
  })  : assert(value != null, 'value cannot be null'),
        assert(duration != null, 'duration cannot be null'),
        super(key: key);

  /// 开关是开还是关，不能设置为null
  final bool value;

  /// 开关发生变化时回调
  final ValueChanged<bool> onChanged;

  /// 开关 width
  final double width;

  /// 开关 height
  final double height;

  /// 开启状态下轨道的颜色
  final Color activeTrackColor;

  /// 关闭状态下轨道的颜色
  final Color inactiveTrackColor;

  /// 开启状态下滑块的颜色
  final Color activeThumbColor;

  /// 关闭状态下滑块的颜色
  final Color inactiveThumbColor;

  /// 开启状态下滑块的文字
  final String activeText;

  /// 关闭状态下滑块的文字
  final String inactiveText;

  /// 开启状态下文字的样式
  final TextStyle activeTextStyle;

  /// 关闭状态下文字的样式
  final TextStyle inactiveTextStyle;

  /// 过度动画时长
  final Duration duration;

  @override
  _WheelSwitchState createState() => _WheelSwitchState();
}

class _WheelSwitchState extends State<WheelSwitch>
    with SingleTickerProviderStateMixin {
  double _paddingHorizontal = 1.5;

  AnimationController _controller;
  bool _value;
  Animation<Color> _colorTrackAnimation;
  Animation<Color> _colorThumbAnimation;
  Animation<TextStyle> _textStyleAnimation;
  Animation<Alignment> _alignmentAnimation;

  @override
  void initState() {
    _value = widget.value;
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _colorTrackAnimation = ColorTween(
      begin: widget.value ? widget.activeTrackColor : widget.inactiveTrackColor,
      end: !widget.value ? widget.activeTrackColor : widget.inactiveTrackColor,
    ).animate(_controller);

    _colorThumbAnimation = ColorTween(
      begin: widget.value ? widget.activeThumbColor : widget.inactiveThumbColor,
      end: !widget.value ? widget.activeThumbColor : widget.inactiveThumbColor,
    ).animate(_controller);

    _textStyleAnimation = TextStyleTween(
      begin: !widget.value ? widget.activeTextStyle : widget.inactiveTextStyle,
      end: widget.value ? widget.activeTextStyle : widget.inactiveTextStyle,
    ).animate(_controller);

    _alignmentAnimation = AlignmentTween(
      begin: !widget.value ? Alignment.centerLeft : Alignment.centerRight,
      end: widget.value ? Alignment.centerLeft : Alignment.centerRight,
    ).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _thumbSize = _computeThumbSize();

    return GestureDetector(
      onTap: () {
        if (_controller.isAnimating) {
          return;
        }
        if (_controller.isDismissed) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
        _value = !_value;
        widget.onChanged?.call(_value);
      },
      child: AnimatedBuilder(
        animation: _colorTrackAnimation,
        builder: (BuildContext context, Widget child) {
          var _text;
          if (_controller.isAnimating) {
            _text = _controller.value > 0.5
                ? widget.activeText
                : widget.inactiveText;
          } else {
            _text = _value ? widget.activeText : widget.inactiveText;
          }
          return Container(
            height: widget.height,
            width: widget.width,
            alignment: _alignmentAnimation.value,
            padding: EdgeInsets.symmetric(horizontal: _paddingHorizontal),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(widget.height),
                border:
                    Border.all(width: 1, color: _colorTrackAnimation.value)),
            child: Transform(
              transform: Matrix4.rotationZ(widget.value
                  ? -1 * _controller.value * pi * 2
                  : _controller.value * pi * 2),
              origin: Offset(_thumbSize / 2, _thumbSize / 2),
              child: Container(
                height: _thumbSize,
                width: _thumbSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _colorThumbAnimation.value,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${_text}',
                  style: _textStyleAnimation.value,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  double _computeThumbSize() {
    return min(widget.height, widget.width) - _paddingHorizontal * 2;
  }
}
