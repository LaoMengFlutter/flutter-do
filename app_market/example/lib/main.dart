import 'dart:io';

import 'package:app_market/app_market.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _installMarkets = [];

  bool _huaWeiExist;

  @override
  void initState() {
    super.initState();
    getInstallMarkets();
  }

  Future<void> getInstallMarkets() async {
    _installMarkets = await AppMarket.getInstallMarkets;

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> marketList = [
      Text('已安装的应用商店（Installed app market）'),
      Container(
        height: 200,
        child: _installMarkets.isEmpty
            ? Text('没有应用商店')
            : ListView.separated(
                itemBuilder: (context, index) {
                  return Text('${_installMarkets[index]}');
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: _installMarkets.length),
      ),
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Market Example'),
        ),
        body: Column(
          children: [
            if (Platform.isAndroid) ...marketList,
            RaisedButton(
              onPressed: () async {
                await AppMarket.toMarket(appleId: 'xxxx');
              },
              child: Text('跳转到应用商店'),
            ),
            if (Platform.isAndroid)
              RaisedButton(
                onPressed: () async {
                  await AppMarket.toMarket(
                      packageName: AppMarketPackage.huaWei);
                },
                child: Text('跳转华为应用商店'),
              ),
            if (Platform.isAndroid)
              RaisedButton(
                onPressed: () async {
                  _huaWeiExist = await AppMarket.exist(AppMarketPackage.huaWei);
                  setState(() {});
                },
                child: Text('验证华为应用商店是否存在：$_huaWeiExist'),
              ),
          ],
        ),
      ),
    );
  }
}
