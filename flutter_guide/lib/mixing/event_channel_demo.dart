import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventChannelDemo extends StatefulWidget {
  @override
  _EventChannelDemoState createState() => _EventChannelDemoState();
}

class _EventChannelDemoState extends State<EventChannelDemo> {

  var _eventChannel = EventChannel('com.flutter.guide.EventChannel');
  var _data;
  @override
  void initState() {
    super.initState();
    _eventChannel.receiveBroadcastStream().listen(_onData);

  }

  _onData(event){
    setState(() {
      _data = event;
    });
  }

  _onError(){

  }

  _onDone(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('$_data'),
      ),
    );
  }
}
