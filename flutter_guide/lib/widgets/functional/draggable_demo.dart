import 'dart:ui' as ui;

import 'package:flutter/material.dart';

const _strokeWidth = 8.0;

///
/// desc:
///

class DragTargetDetailsExample extends StatefulWidget {
  @override
  _DragTargetDetailsExampleState createState() =>
      _DragTargetDetailsExampleState();
}

class _DragTargetDetailsExampleState extends State<DragTargetDetailsExample> {
  static const _feedbackSize = Size(100.0, 100.0);
  static const _padding = 16.0;

  static final _decoration = BoxDecoration(
    border: Border.all(
      color: Colors.blue,
      width: _strokeWidth,
    ),
    borderRadius: BorderRadius.circular(12),
  );

  Offset _lastDropOffset;
  int _lastDropIndex;

  Widget _buildSourceRowChild(int index) => Expanded(
      child: Padding(
          padding: EdgeInsets.all(_padding),
          child: Draggable<int>(
              data: index,
              dragAnchor: DragAnchor.pointer,
              feedback: Transform.translate(
                  offset: Offset(
                      -_feedbackSize.width / 2.0, -_feedbackSize.height / 2.0),
                  child: Container(
                      decoration: _decoration,
                      width: _feedbackSize.width,
                      height: _feedbackSize.height)),
              child: Container(
                  decoration: _decoration,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('drag me'),
                        Text('$index', style: TextStyle(fontSize: 32.0))
                      ])))));

  void _handleAcceptWithDetails(
      BuildContext dragTargetContext, DragTargetDetails details) {
    // Convert global to local coordinates.
    RenderBox renderBox = dragTargetContext.findRenderObject();
    final localOffset = renderBox.globalToLocal(details.offset);
    setState(() {
      _lastDropOffset = localOffset;
      _lastDropIndex = details.data;
    });
  }

  Widget _buildDragTargetChild() => Padding(
      padding: EdgeInsets.all(_padding),
      child: Container(
          decoration: _decoration,
          // Note use of builder to get a context for the [DragTarget] which is
          // available to pass to [_handleAcceptWithDetails].
          child: Builder(
              builder: (targetContext) => DragTarget<int>(
                  builder: (_, candidateData, __) => Container(
                      color: candidateData.isNotEmpty
                          ? Color(0x2200FF00)
                          : Color(0x00000000),
                      child: CustomPaint(
                          painter: _Painter(_lastDropOffset, _lastDropIndex))),
                  onAcceptWithDetails: (details) =>
                      _handleAcceptWithDetails(targetContext, details)))));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              flex: 1,
              child: Row(
                  children: List<Widget>.generate(3, _buildSourceRowChild))),
          Expanded(flex: 4, child: _buildDragTargetChild())
        ]));
  }
}

class _Painter extends CustomPainter {
  static final _diameter = 24.0;

  static final _linePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = _strokeWidth
    ..color = Colors.blue;

  static final _whiteFillPaint = Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.white;

  static final _blueFillPaint = Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.blue;

  final Offset _offset;
  final int _index;

  _Painter(this._offset, this._index);

  @override
  void paint(Canvas canvas, Size size) {
    if (_offset == null || _index == null) return;
    canvas.drawLine(
        Offset(_offset.dx, 0.0), Offset(_offset.dx, size.height), _linePaint);
    canvas.drawLine(
        Offset(0.0, _offset.dy), Offset(size.width, _offset.dy), _linePaint);

    canvas.drawCircle(_offset, _diameter + _strokeWidth, _blueFillPaint);
    canvas.drawCircle(_offset, _diameter, _whiteFillPaint);

    final paragraphBuilder =
        ui.ParagraphBuilder(ui.ParagraphStyle(textAlign: TextAlign.center))
          ..pushStyle(ui.TextStyle(
              fontStyle: FontStyle.normal,
              color: Colors.blue,
              fontSize: _diameter))
          ..addText('$_index');
    final paragraph = paragraphBuilder.build();
    paragraph.layout(ui.ParagraphConstraints(width: _diameter));
    canvas.drawParagraph(
        paragraph, _offset - Offset(_diameter / 2.0, _diameter / 2.0));
  }

  @override
  bool shouldRepaint(_Painter oldPainter) => false;
}
