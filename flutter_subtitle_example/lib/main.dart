import 'dart:convert';

import 'package:example/src/subtitle.dart';
import 'package:example/src/subtitle_entry.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  List<SubtitleEntry> _subtitleList = [];

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    var jsonStr =
        await DefaultAssetBundle.of(context).loadString('assets/subtitle.txt');
    var list = jsonStr.split(RegExp('\n'));
    list.forEach((f) {
      if (f.isNotEmpty) {
        var r = f.split(RegExp(' '));
        if (r.length >= 2) {
          _subtitleList.add(SubtitleEntry(r[0], r[1]));
        }
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('弹幕'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
              child: Image.asset(
            'assets/imgs/background.png',
            fit: BoxFit.cover,
          )),
          Positioned.fill(
              child: Subtitle(
            _subtitleList,
            diameterRatio: 2,
            selectedTextStyle: TextStyle(color: Colors.white, fontSize: 18),
            unSelectedTextStyle: TextStyle(
              color: Colors.black.withOpacity(.6),
            ),
            itemExtent: 45,
          ))
        ],
      ),
    );
  }
}
