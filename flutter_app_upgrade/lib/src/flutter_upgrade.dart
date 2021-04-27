import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_app_upgrade/flutter_app_upgrade.dart';

class FlutterUpgrade {
  static const MethodChannel _channel =
      const MethodChannel('flutter_app_upgrade');

  ///
  /// 获取app信息
  ///
  static Future<AppInfo> get appInfo async {
    var result = await _channel.invokeMethod('getAppInfo');
    return AppInfo(
        versionName: result['versionName'],
        versionCode: result['versionCode'],
        packageName: result['packageName']);
  }

  ///
  /// 获取apk下载路径
  ///
  static Future<String> get apkDownloadPath async {
    return await _channel.invokeMethod('getApkDownloadPath');
  }

  ///
  /// Android 安装app
  ///
  static installAppForAndroid(String path) async {
    var map = {'path': path};
    return await _channel.invokeMethod('install', map);
  }

  ///
  /// 跳转到ios app store
  ///
  static toAppStore(String id) async {
    var map = {'id': id};
    return await _channel.invokeMethod('toAppStore', map);
  }

  ///
  /// 获取android手机上安装的应用商店
  ///
  static Future<List<String>> getInstallMarket(
      {List<String>? marketPackageNames}) async {
    List<String> packageNameList = AppMarket.buildInPackageNameList;
    if (marketPackageNames != null && marketPackageNames.length > 0) {
      packageNameList.addAll(marketPackageNames);
    }
    var map = {'packages': packageNameList};
    var result = await _channel.invokeMethod('getInstallMarket', map);
    List<String> resultList = (result as List).map((f) {
      return '$f';
    }).toList();
    return resultList;
  }

  ///
  /// 跳转到应用商店
  ///
  static toMarket({AppMarketInfo? appMarketInfo}) async {
    var map = {
      'marketPackageName':
          appMarketInfo != null ? appMarketInfo.packageName : '',
      'marketClassName': appMarketInfo != null ? appMarketInfo.className : ''
    };
    return await _channel.invokeMethod('toMarket', map);
  }
}
