import 'package:flutter/material.dart';

class ScrollbarCase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyScrollbar(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
              height: 45,
              alignment: Alignment.center,
              child: Text('$index'),
            ),
          );
        },
        itemExtent: 50,
        itemCount: 50,
      ),
    );
  }
}

class MyScrollbar extends StatefulWidget {
  final Widget child;

  const MyScrollbar({Key key, this.child}) : super(key: key);

  @override
  _MyScrollbarState createState() => _MyScrollbarState();
}

class _MyScrollbarState extends State<MyScrollbar> {
  double _alignmentY = -1;

  bool _handleScrollNotification(ScrollNotification notification) {
    final ScrollMetrics metrics = notification.metrics;
    if (metrics.maxScrollExtent <= metrics.minScrollExtent) {
      return false;
    }
    setState(() {
      _alignmentY = -1 + (metrics.pixels / metrics.maxScrollExtent) * 2;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          widget.child,
          Container(
            alignment: Alignment(1, _alignmentY),
            padding: EdgeInsets.only(right: 5),
            child: _ScrollBar(),
          )
        ],
      ),
    );
  }
}

class _ScrollBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 60,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.blue),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.arrow_drop_up,
            size: 18,
          ),
          Icon(
            Icons.arrow_drop_down,
            size: 18,
          ),
        ],
      ),
    );
  }
}