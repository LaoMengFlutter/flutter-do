import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// des:
///
class NavigationAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第一个页面'),
      ),
      body: Center(
        child: OutlineButton(
          child: Text('跳转'),
          onPressed: () {
            Navigator.push(context, CustomPageRoute(this, _TwoPage()));
          },
        ),
      ),
    );
  }
}

class _TwoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第二个页面'),
      ),
      body: Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text(
          '第二个页面',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class LeftToRightPageRoute extends PageRouteBuilder {
  final Widget newPage;

  LeftToRightPageRoute(this.newPage)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              newPage,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween(begin: Offset(-1, 0), end: Offset(0, 0))
                .animate(animation),
            child: child,
          ),
        );
}

class CustomPageRoute extends PageRouteBuilder {
  final Widget currentPage;
  final Widget newPage;

  CustomPageRoute(this.currentPage, this.newPage)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              currentPage,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Stack(
            children: <Widget>[
              SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(0, 0),
                  end: const Offset(0, -1),
                ).animate(animation),
                child: currentPage,
              ),
              SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset(0, 0),
                ).animate(animation),
                child: newPage,
              )
            ],
          ),
        );
}

class MyPageRoute extends PageRouteBuilder {
  final Widget currentPage;
  final Widget newPage;

  Animation _animation, _animation1;
  Widget _upperChild1, _upperChild2, _lowerChild1, _lowerChild2;

  MyPageRoute(this.currentPage, this.newPage)
      : super(
            pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) =>
                currentPage);

  @override
  Duration get transitionDuration => Duration(seconds: 3);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (_animation == null) {
      _animation = Tween(begin: .0, end: pi / 2)
          .animate(CurvedAnimation(parent: animation, curve: Interval(.0, .5)));
      _animation1 = Tween(begin: -pi / 2, end: 0.0).animate(
          CurvedAnimation(parent: animation, curve: Interval(.5, 1.0)));
    }

    _upperChild1 = ClipRect(
      child: Align(
        alignment: Alignment.centerLeft,
        widthFactor: 0.5,
        child: currentPage,
      ),
    );

    _upperChild2 = ClipRect(
      child: Align(
        alignment: Alignment.centerLeft,
        widthFactor: 0.5,
        child: newPage,
      ),
    );

    _lowerChild1 = ClipRect(
      child: Align(
        alignment: Alignment.centerRight,
        widthFactor: 0.5,
        child: newPage,
      ),
    );

    _lowerChild2 = ClipRect(
      child: Align(
        alignment: Alignment.centerRight,
        widthFactor: 0.5,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: newPage,
        ),
      ),
    );


    return Row(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(child: _upperChild2),
              Positioned.fill(
                  child: Transform(
                alignment: Alignment.centerRight,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(_animation1.value),
                child: _upperChild1,
              ))
            ],
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(child: _lowerChild1),
              Positioned.fill(
                  child: Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(_animation.value),
                child: _lowerChild2,
              ))
            ],
          ),
        )
      ],
    );
  }
}
