import 'dart:typed_data';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

///
/// desc:
///

typedef void _TeamCallback(_Team team);
typedef void _PieceDataCallback(_PieceData pieceData);
enum _Team {
  black,
  white,
}

// The data representing a piece placed on the board.
//
// In this demo, a piece can be placed at any coordinate on the board (not
// necessarily at locations allowed by the rules of go).
class _PieceData {
  const _PieceData({
    this.offset,
    this.team,
  });

  final Offset offset;
  final _Team team;
}

// The entire game UI. Game board and piece inventory.
class Game extends StatefulWidget {
  Game({
    Key key,
  }) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  final GlobalKey _dragTargetKey = GlobalKey();
  double _imageAspectRatio;
  Uint8List _imageData;
  final List<_PieceData> _pieces = <_PieceData>[];
  final TransformationController _transformationController = TransformationController();

  // Cached value of board size and constraints aspect ratio at last render.
  Size _boardSize;
  double _constraintsAspectRatio;

  void _onRemovePiece(_PieceData pieceData) {
    setState(() {
      _pieces.remove(pieceData);
    });
  }

  void _onAddPiece(_PieceData pieceData) {
    setState(() {
      _pieces.add(pieceData);
    });
  }

  // Handles one of the off-board inventory pieces being tapped.
  void _onTapPieceInventory(_Team team) {
    // Calculate the offset that will put the piece near the center of the part
    // of the board that is visible.
    final Size constraintsSize = Size(
      _boardSize.width * math.max(1.0, _constraintsAspectRatio),
      _boardSize.height / math.min(1.0, _constraintsAspectRatio),
    );
    final Offset sceneOffset = _transformationController.toScene(Offset(
      constraintsSize.width / 2,
      constraintsSize.height / 2,
    ));
    setState(() {
      _pieces.add(_PieceData(
        offset: Offset(
          sceneOffset.dx / constraintsSize.width - _kPieceSizeVsBoard / 2,
          sceneOffset.dy / constraintsSize.height - _kPieceSizeVsBoard / 2,
        ),
        team: team,
      ));
    });
  }

  // Load the image in advance in order to get its size.
  void _loadImage() async {
    // from https://www.1001freedownloads.com/free-clipart/go-board-9-x-9
    // under CC license: https://creativecommons.org/publicdomain/zero/1.0/
    final ByteData imageByteData = await rootBundle.load('assets/images/go_board_09x09.png');
    final Uint8List imageData = imageByteData.buffer.asUint8List(
      imageByteData.offsetInBytes,
      imageByteData.lengthInBytes,
    );
    final ui.Image image = await decodeImageFromList(imageData);
    setState(() {
      _imageData = imageData;
      _imageAspectRatio = image.width.toDouble() / image.height.toDouble();
    });
  }

  // Called when a piece is dropped on the board.
  void _onAcceptWithDetails(DragTargetDetails details, Size size) {
    final RenderBox renderBox = _dragTargetKey.currentContext.findRenderObject();
    final Offset localOffset = renderBox.globalToLocal(details.offset);
    final Offset offset = Offset(
      localOffset.dx / size.width,
      localOffset.dy / size.height,
    );
    _onAddPiece(_PieceData(
      offset: offset,
      team: details.data,
    ));
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    // Don't render until the image has been loaded.
    if (_imageData == null || _imageAspectRatio == null) {
      return SizedBox.shrink();
    }

    return Stack(
      children: <Widget>[
        Center(
          child: InteractiveViewer(
            transformationController: _transformationController,
            child:
              Image.asset('assets/images/go_board_09x09.png')
//            Image.memory(_imageData)
//            Stack(
//              children: <Widget>[
//                Container(
//                  child: Center(
//                    child: LayoutBuilder(
//                      builder: (BuildContext context, BoxConstraints constraints) {
//                        // Calculate the size of the board assuming it is sized to
//                        // fill the constraints.
//                        _constraintsAspectRatio = constraints.maxWidth / constraints.maxHeight;
//                        _boardSize = Size(
//                          _imageAspectRatio > _constraintsAspectRatio
//                              ? constraints.maxWidth
//                              : constraints.maxHeight * _imageAspectRatio,
//                          _imageAspectRatio > _constraintsAspectRatio
//                              ? constraints.maxWidth / _imageAspectRatio
//                              : constraints.maxHeight,
//                        );
//
//                        return DragTarget<_Team>(
//                          key: _dragTargetKey,
//                          onAcceptWithDetails: (DragTargetDetails details) {
//                            _onAcceptWithDetails(details, _boardSize);
//                          },
//                          onWillAccept: (_Team team) => true,
//                          builder: (BuildContext context, List<_Team> candidateData, List rejectedData) {
//                            // The length of a side of a square piece. It's an
//                            // arbitrary proportion of the board size.
//                            final double pieceSide = math.min(_boardSize.width, _boardSize.height) * _kPieceSizeVsBoard;
//                            return Stack(
//                              children: <Widget>[
//                                Padding(
//                                  padding: const EdgeInsets.all(8.0),
//                                  child: Container(
//                                    color: Colors.brown,
//                                    child: Image.memory(_imageData),
//                                  ),
//                                ),
//                                ..._pieces
//                                    .map((_PieceData pieceData) => Positioned(
//                                  left: pieceData.offset.dx * _boardSize.width,
//                                  top: pieceData.offset.dy * _boardSize.height,
//                                  child: _DraggablePiece(
//                                    height: pieceSide,
//                                    onDragStarted: () {
//                                      _onRemovePiece(pieceData);
//                                    },
//                                    team: pieceData.team,
//                                    width: pieceSide,
//                                  ),
//                                ))
//                                    .toList(),
//                              ],
//                            );
//                          },
//                        );
//                      },
//                    ),
//                  ),
//                ),
//              ],
//            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 120.0,
            color: Colors.grey,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _InventoryPiece(
                    onTap: _onTapPieceInventory,
                    team: _Team.black,
                  ),
                  _InventoryPiece(
                    onTap: _onTapPieceInventory,
                    team: _Team.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// The size of a piece outside of InteractiveViewer.
const double _kPieceDimension = 40.0;
// The size of a piece as a fraction of the board.
const double _kPieceSizeVsBoard = 1 / 12;

// A single game piece.
class _Piece extends StatelessWidget {
  _Piece({
    Key key,
    this.height = _kPieceDimension,
    this.isDragging = false,
    this.team,
    this.width = _kPieceDimension,
  })  : assert(team != null),
        assert(height != null),
        assert(width != null),
        super(key: key);

  final double height;
  final bool isDragging;
  final _Team team;
  final double width;

  @override
  Widget build(BuildContext context) {
    final double opacity = isDragging ? 0.4 : 1.0;
    return Container(
      decoration: BoxDecoration(
        color: team == _Team.black ? Colors.black.withOpacity(opacity) : Colors.white.withOpacity(opacity),
        shape: BoxShape.circle,
      ),
      width: width,
      height: height,
    );
  }
}

// A game piece that can be dragged.
class _DraggablePiece extends StatelessWidget {
  _DraggablePiece({
    Key key,
    this.height = _kPieceDimension,
    this.isDragging = false,
    this.onDragStarted,
    this.team,
    this.width = _kPieceDimension,
  })  : assert(team != null),
        super(key: key);

  final double height;
  final bool isDragging;
  final VoidCallback onDragStarted;
  final double width;
  final _Team team;

  @override
  Widget build(BuildContext context) {
    return Draggable<_Team>(
      data: team,
      // TODO(justinmc): It would be cool if the feedback widget perfectly
      // matched the size of the widget that will be placed on the board when
      // it's dropped, but that might be more work than it's worth.
      feedback: _Piece(
        height: height,
        isDragging: true,
        team: team,
        width: width,
      ),
      onDragStarted: onDragStarted,
      child: _Piece(
        height: height,
        team: team,
        width: width,
      ),
    );
  }
}

// One of the two pieces on the side of the board that can be used to create
// new pieces on the board.
class _InventoryPiece extends StatelessWidget {
  _InventoryPiece({
    Key key,
    @required this.team,
    @required this.onTap,
  }) : assert(team != null),
        assert(onTap != null),
        super(key: key);

  final _TeamCallback onTap;
  final _Team team;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(team);
      },
      child: _DraggablePiece(
        team: team,
      ),
    );
  }
}