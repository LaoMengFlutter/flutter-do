import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

///
/// desc: 吃豆人
///

class PacmanLoading extends StatefulWidget {
  final Color mouthColor;
  final Color ballColor;
  final Duration mouthDuration;
  final Duration ballDuration;
  final Curve curve;

  const PacmanLoading(
      {Key key,
      this.mouthColor = Colors.white,
      this.ballColor = Colors.white,
      this.mouthDuration = const Duration(milliseconds: 800),
      this.ballDuration = const Duration(milliseconds: 2000),
      this.curve = Curves.linear})
      : super(key: key);

  @override
  _PacmanLoadingState createState() => _PacmanLoadingState();
}

class _PacmanLoadingState extends State<PacmanLoading>
    with TickerProviderStateMixin {
  AnimationController _controller, _controller1;
  Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: widget.mouthDuration)
          ..repeat(reverse: true);

    _controller1 =
        AnimationController(vsync: this, duration: widget.ballDuration)
          ..repeat();

    _animation = Tween(begin: 0.0, end: pi / 2)
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          left: 3,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                painter: _PointTranslatePainter(_controller1.value,
                    color: widget.ballColor),
              );
            },
          ),
        ),
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                painter:
                    _PacmanPainter(_animation.value, color: widget.mouthColor),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PacmanPainter extends CustomPainter {
  final double angle;
  final Color color;

  Paint _paint = Paint()..style = PaintingStyle.fill;

  _PacmanPainter(
    this.angle, {
    this.color = Colors.white,
  }) {
    _paint.color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var _radius = min(size.width, size.height) / 2;
    canvas.drawArc(Rect.fromLTWH(0, 0, _radius * 2, _radius * 2), angle / 2,
        2 * pi - angle, true, _paint);
  }

  @override
  bool shouldRepaint(covariant _PacmanPainter old) {
    return color != old.color ||
        angle != old.angle;
  }
}

class _PointTranslatePainter extends CustomPainter {
  final double progress;
  final int count;
  final Color color;
  final double radius;

  Paint _paint = Paint()..style = PaintingStyle.fill;

  _PointTranslatePainter(
    this.progress, {
    this.count = 5,
    this.color = Colors.white,
    this.radius = 3.0,
  }) {
    _paint.color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var _perX = size.width / (count - 1);

    for (int i = 0; i < count * 2; i++) {
      var _x = _perX * i - size.width * progress;
      if (_x >= 0 && _x <= size.width) {
        canvas.drawCircle(Offset(_x, size.height / 2), radius, _paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _PointTranslatePainter old) {
    return color != old.color ||
        progress != old.progress ||
        count != old.count ||
        radius != old.radius;
  }
}
