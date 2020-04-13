import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_barrage_sample/barrage/huya_barrage.dart';

import 'barrage/barrage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('弹幕'),
        ),
        body: BarrageTest(),
      ),
    );
  }
}

class BarrageTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BarrageTest();
}

class _BarrageTest extends State<BarrageTest> {
  var _barrageKey = GlobalKey<BarrageState>();

  int mills = 500;
  int showCount = 6;
  Timer _timer;
  TextEditingController _millsController;
  TextEditingController _showController;

  List<String> values = [
    '666666666666666666666666666666666666',
    '男人没有等到 3 分钟之后。',
    '但她还是按照计划，一本正经地在心里默念',
    '代号 07 沉默不语。',
    '发弹幕的这位，我觉得你很有想法…',
    '出自鼹鼠的故事',
    'PS.大家想收录就收录，想转载就转载',
    '刘备浇水…',
    '最新实体弹幕！',
    '琴瑟琵琶，八大王一般头面',
  ];

  @override
  void initState() {
    _millsController = TextEditingController()..text = mills.toString();
    _showController = TextEditingController()..text = showCount.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 300,
            color: Colors.blue,
            child: Barrage(
              key: _barrageKey,
              showCount: showCount,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('间隔发送时间(ms)：'),
                    Expanded(
                      child: TextField(
                        controller: _millsController,
                        onChanged: (value) {
                          mills = int.parse(value);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('显示的行数:'),
                    Expanded(
                      child: TextField(
                        controller: _showController,
                        onChanged: (value) {
                          showCount = int.parse(value);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                RaisedButton(
                  child: Text('发送'),
                  onPressed: () {
                    _timer?.cancel();
                    _timer =
                        Timer.periodic(Duration(milliseconds: mills), (timer) {
                      Random random = Random();
                      int _random = random.nextInt(values.length);
                      var text = values[_random];
                      var child;
                      if (_random == 1) {
                        child = HuyaBarrage.level_1(text);
                      } else if (_random == 2) {
                        child = HuyaBarrage.level_2(text);
                      } else if (_random == 3) {
                        child = HuyaBarrage.level_3(text, 20);
                      } else {
                        child = HuyaBarrage.normal(text);
                      }
                      _barrageKey.currentState.addBarrage(child);
                    });
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
