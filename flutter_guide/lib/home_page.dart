import 'package:flutter/material.dart';

///
/// des:
///
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('跳转'),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return _PageB();
          }));
        },
      ),
    );
  }
}

class _PageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _PageC(),
    );
  }
}


class _PageC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('弹出Dialog'),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('提示'),
                    content: Text('确认删除吗？'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('取消'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text('确认'),
                        onPressed: () {},
                      ),
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
