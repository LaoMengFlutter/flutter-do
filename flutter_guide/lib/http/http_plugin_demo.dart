import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

///
/// desc:
///

class HttpPluginDemo extends StatefulWidget {
  @override
  _HttpPluginDemoState createState() => _HttpPluginDemoState();
}

class _HttpPluginDemoState extends State<HttpPluginDemo> {
  String _data;

  getData() async {
    var client = http.Client();
    http.Response response = await client
        .get('https://github.com/781238222/flutter-do/blob/master/README.md');
    setState(() {
      _data = response.body;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HttpPluginDemo'),
      ),
      body: Center(
        child: Text('$_data'),
      ),
    );
  }
}
