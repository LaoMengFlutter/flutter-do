import 'package:flutter/material.dart';
import 'package:m_loading/m_loading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'MLoading Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Color _color = Theme.of(context).primaryColor;
    Duration _duration = Duration(seconds: 10);
    Curve _curve = Curves.bounceIn;

    BallStyle _ballStyle = BallStyle(
      color: _color,
    );
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: 40,
          height: 50,
          child: PouringHourGlassLoading(
            color: Colors.blue,
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // backgroundColor: Color(0xFFBBDEFB),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        children: [
          // _item(BallPulseLoading(ballStyle: _ballStyle,)),
          // _item(Ball4ScaleLoading(ballStyle: _ballStyle,)),
          // _item(BallGridPulseLoading(ballStyle: _ballStyle,)),
          // _item(BallCirclePulseLoading(ballStyle: _ballStyle,)),
          // _item(Ball3OpacityLoading(ballStyle: _ballStyle,)),
          // _item(Ball4OpacityLoading(ballStyle: _ballStyle,)),
          // _item(BallGridOpacityLoading(ballStyle: _ballStyle,)),
          // _item(BallCircleRotateLoading(ballStyle: _ballStyle,)),
          // _item(BallBounceLoading(ballStyle: _ballStyle,)),
          // _item(BallRotateScaleLoading(ballStyle: _ballStyle,)),
          // _item(Ball2TrianglePathLoading(ballStyle: _ballStyle,), width: 40, height: 40),
          //
          _item(
              BallCircleOpacityLoading(
                ballStyle: BallStyle(
                    size: 5, color: Colors.red, ballType: BallType.solid),
              ),
              width: 40,
              height: 40),

          // _item(Ball3TrianglePathLoading(ballStyle: _ballStyle,)),
          // _item(BallInsideBallLoading(ballStyle: _ballStyle,backgroundColor: _color.withOpacity(0.3),), width: 40, height: 40),
          // _item(BallClipRotatePulseLoading(ballStyle: _ballStyle,ringColor: _color,), width: 40, height: 40),
          //
          // _item(BallCircleInsideRotateLoading(ballStyle: _ballStyle,), width: 40, height: 40),
          //
          // _item(RingRotate(color: _color,), width: 40, height: 40),
          // _item(Ring2InsideLoading(color: _color,), width: 40, height: 40),
          // _item(Ring2SymmetryLoading(color: _color,), width: 40, height: 40),
          // _item(RingBallRotateLoading(ballColor: _color,circleColor: _color.withOpacity(0.3),), width: 40, height: 40),
          // _item(RingClipRotateMultiple(innerColor: _color,outerColor: _color,), width: 40, height: 40),
          // _item(WaterCircleLoading(color: _color,)),
          // _item(Water2CircleLoading(color: _color,)),
          // _item(WaterRipple(color: _color,)),
          // _item(WaterMultipleCircleLoading(color: _color,)),
          // _item(WaterPulseLoading(color: _color,)),
          // _item(BarPulseLoading(color: _color,), width: 40, height: 40),
          // _item(BarScaleLoading(color: _color,), width: 40, height: 40),
          // _item(BarScale1Loading(color: _color,), width: 40, height: 40),
          // _item(BarScalePulseOutLoading(color: _color,), width: 40, height: 40),
          // _item(BarMusicLoading(color: _color,), width: 26, height: 40),
          // // _item(Square4RotateLoading(color: _color,)),
          // _item(Square4OpacityLoading(color: _color,), width: 40, height: 40),
          // _item(SquareFadingLoading(color: _color,), width: 40, height: 40),
          // _item(SquareRotateLoading(color: _color,), width: 40, height: 40),
          // _item(SquareGridScaleLoading(color: _color,)),
          // _item(CircleRotateLoading(color: _color,), width: 40, height: 40),
          // _item(CirclePulseLoading(color: _color,), width: 40, height: 40),
          // _item(
          //     CircleSquareLoading(
          //       size: 30,
          //       color: _color,
          //     ),
          //     width: 30,
          //     height: 30),
          // _item(Circle2InsideScaleLoading(smallCircleColor: _color,), width: 40, height: 40),
          // _item(PouringHourGlassLoading(color: _color,), width: 30, height: 40),
          // _item(PacmanLoading(mouthColor: _color,ballColor: _color,), width: 80, height: 40),
        ],
      ),
    );
  }

  _item(
    Widget loading, {
    double width = 60,
    double height = 60,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(
                height: height,
                width: width,
                child: loading,
              ),
            ),
          );
        }));
      },
      child: Center(
        child: Container(
          height: height,
          width: width,
          child: loading,
        ),
      ),
    );
  }
}
