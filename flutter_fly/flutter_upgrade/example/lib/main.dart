import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_upgrade/src/flutter_upgrade.dart';
import 'package:flutter_upgrade/src/app_market.dart';
import 'package:flutter_upgrade/src/app_upgrade.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App 升级测试'),
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Home(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AppInfo _appInfo;
  List<AppMarketInfo> _appMarketList = [];

  @override
  void initState() {
    _checkAppUpgrade();
    _getInstallMarket();
    super.initState();
  }

  _checkAppUpgrade() {
    AppUpgrade.appUpgrade(context, _checkAppInfo(),
        okBackgroundColors: [Colors.blue, Colors.lightBlue],
        cancelText: '以后再说',
        cancelTextStyle: TextStyle(color: Colors.grey),
        okText: '马上升级',
        okTextStyle: TextStyle(color: Colors.red),
        titleStyle: TextStyle(fontSize: 30),
        contentStyle: TextStyle(fontSize: 18),

        progressBarColor: Colors.lightBlue.withOpacity(.4),
        borderRadius: 15,
        iosAppId: 'id88888888',
        appMarketInfo: AppMarket.huaWei);
  }

  Future<AppUpgradeInfo> _checkAppInfo() {
    return Future.value(AppUpgradeInfo(
      title: '新版本V1.1.1',
      contents: [
        '1、支持立体声蓝牙耳机，同时改善配对性能',
        '2、提供屏幕虚拟键盘',
        '3、更简洁更流畅，使用起来更快',
        '4、修复一些软件在使用时自动退出bug',
        '5、新增加了分类查看功能'
      ],
//      apkDownloadUrl:
//          'https://storage.jd.com/arvrdata/0b7a580a-503b-49b1-8b86-80f0e5467e2f?Expires=1899191583&AccessKey=8Xc003t1kQzVk1eK&Signature=0g%2BxFBfGLejmPjOjogBzTrrORTE%3D',
      force: false,
    ));
  }

  _getAppInfo() async {
    var appInfo = await FlutterUpgrade.appInfo;
    setState(() {
      _appInfo = appInfo;
    });
  }

  _getInstallMarket() async {
    List<String> marketList = await FlutterUpgrade.getInstallMarket();
    var packageName = marketList[0];
    AppMarketInfo _marketInfo = AppMarket.getBuildInMarket(packageName);
    print('${_marketInfo.marketName}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('packageName:${_appInfo?.packageName}'),
        Text('versionName:${_appInfo?.versionName}'),
        Text('versionCode:${_appInfo?.versionCode}'),
        Text('安装的应用商店:${_appMarketList.map((f) {
          return f.marketName;
        }).toList()}'),
      ],
    );
  }
}
