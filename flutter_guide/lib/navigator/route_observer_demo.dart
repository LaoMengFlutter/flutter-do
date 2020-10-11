import 'package:flutter/material.dart';
import 'package:guide/main.dart';

///
/// des:
///
class ARouteObserverDemo extends StatefulWidget {
  @override
  _RouteObserverDemoState createState() => _RouteObserverDemoState();
}

class _RouteObserverDemoState extends State<ARouteObserverDemo> with RouteAware {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: RaisedButton(
          child: Text('A RouteObserver'),
          onPressed: () {
            Navigator.of(context).pushNamed('/BRouteObserver');
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  @override
  void didPush() {
    final route = ModalRoute.of(context).settings.name;
    print('A-didPush route: $route');
  }

  @override
  void didPopNext() {
    final route = ModalRoute.of(context).settings.name;
    print('A-didPopNext route: $route');
  }

  @override
  void didPushNext() {
    final route = ModalRoute.of(context).settings.name;
    print('A-didPushNext route: $route');
  }

  @override
  void didPop() {
    final route = ModalRoute.of(context).settings.name;
    print('A-didPop route: $route');
  }

}
