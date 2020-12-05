import 'dart:math';

import 'package:flutter/material.dart';

import 'square.dart';

///
/// desc:
///

class Square4OpacityLoading extends StatefulWidget {
  final Color color;
  final Duration duration;
  final Curve curve;

  const Square4OpacityLoading(
      {Key key,
        this.color = Colors.white,
        this.duration = const Duration(milliseconds: 800),
        this.curve = Curves.linear})
      : super(key: key);


  @override
  _Square4OpacityLoadingState createState() => _Square4OpacityLoadingState();
}

class _Square4OpacityLoadingState extends State<Square4OpacityLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  List<List<Color>> _colors = [];
  List<double> opacity = [0.2, 0.3, 0.4, 1.0];

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: widget.duration)
          ..repeat();
    _animation = CurveTween(curve: widget.curve).animate(_controller);

    List.generate(opacity.length, (index) {
      List<Color> colorList = [];

      List<double> _opacityIndexList = [];
      _opacityIndexList
          .addAll(opacity.sublist(opacity.length - index, opacity.length));
      _opacityIndexList.addAll(opacity.sublist(0, opacity.length - index));

      for (int i = 0; i < opacity.length; i++) {
        colorList.add(widget.color.withOpacity(_opacityIndexList[i]));
      }

      _colors.add(colorList);
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          var index = (_animation.value * opacity.length).floor();
          return Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Square(
                        color: _colors[index][0],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Square(
                        color: _colors[index][1],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                  child: Row(
                children: [
                  Expanded(
                    child: Square(
                      color: _colors[index][3],
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Square(
                      color: _colors[index][2],
                    ),
                  ),
                ],
              )),
            ],
          );
        });
  }
}
