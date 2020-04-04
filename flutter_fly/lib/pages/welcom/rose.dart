import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_fly/pages/welcom/rose_data.dart';

///
/// des:
///
class Rose extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RoseState();
}

class _RoseState extends State<Rose> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<num> _animation;

  List<Offset> _flowerPaths = [];
  List<Offset> _branchPaths = [];
  List<Offset> _leafBranchPoints1 = [];
  List<Offset> _leafPoints1 = [];
  List<Offset> _leafBranchPoints2 = [];
  List<Offset> _leafPoints2 = [];

  @override
  void initState() {
    _controller = AnimationController(
        duration: Duration(seconds: 3), vsync: this)
      ..addListener(() {
        setState(() {
          int currAnimationValue = _animation.value.floor();
          int flowerPointsNum = RoseData.flowerPoints.length;
          int branchPointsNum = RoseData.branchPoints.length;
          int leafBranchPoints1Num = RoseData.leafBranchPoints1.length;
          int leafPoints1Num = RoseData.leafPoints1.length;
          int leafBranchPoints2Num = RoseData.leafBranchPoints2.length;
          int leafPoints2Num = RoseData.leafPoints2.length;

          if (currAnimationValue < flowerPointsNum) {
            //只有花
            _flowerPaths = RoseData.flowerPoints.sublist(0, currAnimationValue);
          } else if (currAnimationValue > flowerPointsNum &&
              currAnimationValue < flowerPointsNum + branchPointsNum) {
            //花和枝干
            _flowerPaths = RoseData.flowerPoints;
            _branchPaths = RoseData.branchPoints
                .sublist(0, _animation.value.floor() - flowerPointsNum);
          } else if (currAnimationValue > flowerPointsNum + branchPointsNum &&
              currAnimationValue <
                  flowerPointsNum + branchPointsNum + leafBranchPoints1Num) {
            _flowerPaths = RoseData.flowerPoints;
            _branchPaths = RoseData.branchPoints;

            _leafBranchPoints1 = RoseData.leafBranchPoints1.sublist(
                0, currAnimationValue - flowerPointsNum - branchPointsNum);
          } else if (_animation.value.floor() >
                  flowerPointsNum + branchPointsNum + leafBranchPoints1Num &&
              currAnimationValue <
                  flowerPointsNum +
                      branchPointsNum +
                      leafBranchPoints1Num +
                      leafPoints1Num) {
            _flowerPaths = RoseData.flowerPoints;
            _branchPaths = RoseData.branchPoints;
            _leafBranchPoints1 = RoseData.leafBranchPoints1;
            _leafPoints1 = RoseData.leafPoints1.sublist(
                0,
                currAnimationValue -
                    flowerPointsNum -
                    branchPointsNum -
                    leafBranchPoints1Num);
          } else if (currAnimationValue >
                  flowerPointsNum +
                      branchPointsNum +
                      leafBranchPoints1Num +
                      leafPoints1Num &&
              currAnimationValue <
                  flowerPointsNum +
                      branchPointsNum +
                      leafBranchPoints1Num +
                      leafPoints1Num +
                      leafBranchPoints2Num) {
            _flowerPaths = RoseData.flowerPoints;
            _branchPaths = RoseData.branchPoints;
            _leafBranchPoints1 = RoseData.leafBranchPoints1;
            _leafPoints1 = RoseData.leafPoints1;

            _leafBranchPoints2 = RoseData.leafBranchPoints2.sublist(
                0,
                currAnimationValue -
                    flowerPointsNum -
                    branchPointsNum -
                    leafBranchPoints1Num -
                    leafPoints1Num);
          } else if (currAnimationValue >
              flowerPointsNum +
                  branchPointsNum +
                  leafBranchPoints1Num +
                  leafPoints1Num +
                  leafBranchPoints2Num) {
            _flowerPaths = RoseData.flowerPoints;
            _branchPaths = RoseData.branchPoints;
            _leafBranchPoints1 = RoseData.leafBranchPoints1;
            _leafPoints1 = RoseData.leafPoints1;
            _leafBranchPoints2 = RoseData.leafBranchPoints2;

            _leafPoints2 = RoseData.leafPoints2.sublist(
                0,
                currAnimationValue -
                    flowerPointsNum -
                    branchPointsNum -
                    leafBranchPoints1Num -
                    leafPoints1Num -
                    leafBranchPoints2Num);
          }
        });
      });

    _animation = Tween(
            begin: 0.0,
            end: RoseData.flowerPoints.length +
                RoseData.branchPoints.length +
                RoseData.leafBranchPoints1.length +
                RoseData.leafPoints1.length +
                RoseData.leafBranchPoints2.length +
                RoseData.leafPoints2.length)
        .animate(_controller);
    super.initState();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 700,
      child: CustomPaint(
        painter: RosePaint(_flowerPaths,
            branchPaths: _branchPaths,
            leafBranchPoints1: _leafBranchPoints1,
            leafPoints1: _leafPoints1,
            leafBranchPoints2: _leafBranchPoints2,
            leafPoints2: _leafPoints2),
      ),
    );
  }
}

class RosePaint extends CustomPainter {
  RosePaint(this.flowerPaths,
      {this.branchPaths,
      this.leafBranchPoints1,
      this.leafPoints1,
      this.leafBranchPoints2,
      this.leafPoints2});

  final List<Offset> flowerPaths;
  final List<Offset> branchPaths;
  final List<Offset> leafBranchPoints1;
  final List<Offset> leafPoints1;
  final List<Offset> leafBranchPoints2;
  final List<Offset> leafPoints2;

  Paint _paint = Paint()..strokeWidth = 1.0;
  Color _strokeColor = Colors.black..withOpacity(.4);
  Color _flowerColor = Color(0xFFF84120);
  Color _leafColor = Color(0xFFF2C651C);

  @override
  void paint(Canvas canvas, Size size) {
    _drawFlower(canvas, size);
    _drawBranch(canvas, size);
    _drawLeaf1(canvas, size);
    _drawLeaf2(canvas, size);
  }

  ///
  /// 绘制花骨朵
  ///
  _drawFlower(Canvas canvas, Size size) {
    //将花变为红色
    if (flowerPaths.length >= RoseData.flowerPoints.length) {
      var path = Path();
      for (int i = 0; i < flowerPaths.length; i++) {
        if (i == 0) {
          path.moveTo(flowerPaths[i].dx, flowerPaths[i].dy);
        } else {
          path.lineTo(flowerPaths[i].dx, flowerPaths[i].dy);
        }
      }
      _paint.style = PaintingStyle.fill;
      _paint.color = _flowerColor;
      canvas.drawPath(path, _paint);
    }
    //绘制线
    _paint.style = PaintingStyle.stroke;
    _paint.color = _strokeColor;
    //去掉最后2个点，最后2个点为了绘制红色
    var points = flowerPaths.sublist(0, max(0, flowerPaths.length - 2));
    canvas.drawPoints(PointMode.polygon, points, _paint);
  }

  ///
  /// 花干
  ///
  _drawBranch(Canvas canvas, Size size) {
    if (branchPaths.length <= 0) {
      return;
    }
    _paint.style = PaintingStyle.stroke;
    _paint.color = _strokeColor;

    canvas.drawPoints(PointMode.polygon, branchPaths, _paint);
  }

  _drawLeaf1(Canvas canvas, Size size) {
    //如果开始绘制枝干，则将花变为红色
    if (leafPoints1.length >= RoseData.leafPoints1.length) {
      var path = Path();
      for (int i = 0; i < leafPoints1.length; i++) {
        if (i == 0) {
          path.moveTo(leafPoints1[i].dx, leafPoints1[i].dy);
        } else {
          path.lineTo(leafPoints1[i].dx, leafPoints1[i].dy);
        }
      }
      _paint.style = PaintingStyle.fill;
      _paint.color = _leafColor;
      canvas.drawPath(path, _paint);
    }
    _paint.style = PaintingStyle.stroke;
    _paint.color = _strokeColor;
    canvas.drawPoints(PointMode.polygon, leafBranchPoints1, _paint);
    canvas.drawPoints(PointMode.polygon, leafPoints1, _paint);
  }

  _drawLeaf2(Canvas canvas, Size size) {
    //如果开始绘制枝干，则将花变为红色
    if (leafPoints2.length >= RoseData.leafPoints2.length) {
      var path = Path();
      for (int i = 0; i < leafPoints2.length; i++) {
        if (i == 0) {
          path.moveTo(leafPoints2[i].dx, leafPoints2[i].dy);
        } else {
          path.lineTo(leafPoints2[i].dx, leafPoints2[i].dy);
        }
      }
      _paint.style = PaintingStyle.fill;
      _paint.color = _leafColor;
      canvas.drawPath(path, _paint);
    }
    _paint.style = PaintingStyle.stroke;
    _paint.color = _strokeColor;
    canvas.drawPoints(PointMode.polygon, leafBranchPoints2, _paint);
    canvas.drawPoints(PointMode.polygon, leafPoints2, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
