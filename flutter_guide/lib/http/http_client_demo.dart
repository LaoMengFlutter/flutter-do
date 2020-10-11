import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

///
/// desc:
///

class HttpClientDemo extends StatefulWidget {
  @override
  _HttpClientDemoState createState() => _HttpClientDemoState();
}

class _HttpClientDemoState extends State<HttpClientDemo> {
  String _data;

  getData() async {
    var httpClient = new HttpClient();
    var uri = Uri(
        scheme: 'https',
        host: 'github.com',
        path: '781238222/flutter-do/blob/master/README.md');

    HttpClientRequest request = await httpClient.getUrl(uri);
    request.headers.add('name', 'value');
    HttpClientResponse response = await request.close();
    String responseBody = await response.transform(utf8.decoder).join();
    print('responseBody:$responseBody');
    setState(() {
      _data = responseBody;
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
        title: Text('HttpClient'),
      ),
      body: Center(
        child: Text('$_data'),
      ),
    );
  }
}
