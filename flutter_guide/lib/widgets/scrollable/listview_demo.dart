import 'package:flutter/material.dart';

///
/// des:
///

class ListViewDemo extends StatefulWidget {
  @override
  _ListViewDemoState createState() => _ListViewDemoState();
}

class _ListViewDemoState extends State<ListViewDemo> {
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController()
      ..addListener(() {
        print('${_controller.position}');
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Container(
          child: RaisedButton(
            child: Text('滚动到指定位置'),
            onPressed: () {
              _controller.animateTo(200,
                  duration: Duration(milliseconds: 300), curve: Curves.linear);
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: _controller,
            reverse: false,
            itemBuilder: (BuildContext context, int index) {
              return _ListItem(
                title: '$index',
              );
            },
            itemCount: 30,
            itemExtent: 50,
          ),
        )
      ],
    );
  }

  _buildList2() {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 45,
          alignment: Alignment.center,
          child: Text('$index'),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
      itemCount: 30,
    );
  }

  _buildList1() {
    return ListView.builder(
      controller: _controller,
      reverse: false,
      itemBuilder: (BuildContext context, int index) {
        return _ListItem(
          title: '$index',
        );
      },
      itemCount: 30,
      itemExtent: 50,
    );
  }

  _buildList() {
    return ListView(
      children: <Widget>[
        _ListItem(
          title: '1',
        ),
        _ListItem(
          title: '2',
        ),
        _ListItem(
          title: '3',
        ),
        _ListItem(
          title: '4',
        ),
        _ListItem(
          title: '5',
        ),
        _ListItem(
          title: '6',
        ),
      ],
    );
  }
}

class _ListItem extends StatelessWidget {
  final String title;

  const _ListItem({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 45,
        alignment: Alignment.center,
        child: Text('$title'),
      ),
    );
  }
}
