import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class AppMarket {
  static const MethodChannel _channel = const MethodChannel('com.flutter.app_market');

  ///
  /// 获取手机上安装的所有应用商店，
  /// 仅对Android有效，iOS无效
  ///
  static Future<List<String>> get getInstallMarkets async {
    if (Platform.isIOS) throw UnsupportedError('ios platform is not support ');
    var result = await _channel.invokeMethod('getInstallMarkets');
    List<String> list = [];
    (result as List).forEach((element) {
      list.add(element);
    });
    return list;
  }

  ///
  /// [packageName] 仅用于Android，指包名，
  /// [appleId]  仅用于iOS，指appId，是应用程序在app store中生成到。
  ///
  /// Android:
  /// 如果未指定 [packageName]，且手机上安装多个应用市场
  /// 则弹出对话框，由用户选择进入哪个市场
  /// 如果指定 [packageName]，直接跳转到指定应用市场
  ///
  /// iOS:
  /// 跳转到app store，
  ///
  static toMarket({String? packageName, String? appleId}) async {
    var arguments = {'packageName': packageName ?? '', 'appleId': appleId};
    await _channel.invokeMethod('toMarket', arguments);
  }

  ///
  /// 是否存在当前应用市场，
  /// 仅对Android有效，iOS无效
  ///
  static Future<bool?> exist(String packageName) async {
    if (Platform.isIOS) throw UnsupportedError('ios platform is not support ');

    assert(packageName.isNotEmpty);

    var arguments = {'packageName': packageName};
    return await _channel.invokeMethod('exist', arguments);
  }

  ///
  /// 安装app，
  /// 仅对Android有效，iOS无效
  ///
  static installApk(String apkPath) async {
    if (Platform.isIOS) throw UnsupportedError('ios platform is not support ');

    assert(apkPath.isNotEmpty);

    var arguments = {'path': apkPath};
    await _channel.invokeMethod('installApk', arguments);
  }
}
