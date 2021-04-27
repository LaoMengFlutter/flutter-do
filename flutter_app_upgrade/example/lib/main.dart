import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_upgrade/flutter_app_upgrade.dart';

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
  AppInfo? _appInfo;
  List<AppMarketInfo> _appMarketList = [];
  String _installMarkets = '';

  @override
  void initState() {
    _checkAppUpgrade();
    _getInstallMarket();
    _getAppInfo();
    super.initState();
  }

  _checkAppUpgrade() {
    AppUpgrade.appUpgrade(
      context,
      _checkAppInfo(),
      cancelText: '以后再说',
      okText: '马上升级',
      iosAppId: 'id88888888',
      appMarketInfo: AppMarket.huaWei,
      onCancel: () {
        print('onCancel');
      },
      onOk: () {
        print('onOk');
      },
      downloadProgress: (count, total) {
        print('count:$count,total:$total');
      },
      downloadStatusChange: (DownloadStatus status, {dynamic error}) {
        print('status:$status,error:$error');
      },
    );
  }

  ///自定义界面
  _checkAppUpgrade2() {
    AppUpgrade.appUpgrade(context, _checkAppInfo(),
        iosAppId: 'id88888888',
        downloadProgress: (count, total) {
          print('count:$count,total:$total');
        },
        downloadStatusChange: (DownloadStatus status, {dynamic error}) {
          print('status:$status,error:$error');
        },
        dialogBuilder: (onOk) => MaterialButton(
              onPressed: onOk,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 2),
              color: Colors.blueAccent,
              child: Text("升级",
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ));
  }

  Future<AppUpgradeInfo> _checkAppInfo() async {
    //这里一般访问网络接口，将返回的数据解析成如下格式
    return Future.delayed(Duration(seconds: 1), () {
      return AppUpgradeInfo(
        title: '新版本V1.1.1',
        contents: [
          '1、支持立体声蓝牙耳机，同时改善配对性能',
          '2、提供屏幕虚拟键盘',
          '3、更简洁更流畅，使用起来更快',
          '4、修复一些软件在使用时自动退出bug',
          '5、新增加了分类查看功能'
        ],
        force: false,
      );
    });
  }

  _getAppInfo() async {
    var appInfo = await FlutterUpgrade.appInfo;
    setState(() {
      _appInfo = appInfo;
    });
  }

  _getInstallMarket() async {
    List<String> marketList = await FlutterUpgrade.getInstallMarket();
    marketList.forEach((f) {
      _installMarkets += '$f,';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('packageName:${_appInfo?.packageName}'),
        Text('versionName:${_appInfo?.versionName}'),
        Text('versionCode:${_appInfo?.versionCode}'),
        Text('安装的应用商店:$_installMarkets'),
      ],
    );
  }
}
