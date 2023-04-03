import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_upgrade/flutter_app_upgrade.dart';

import 'custom_app_upgrade.dart';
import 'download_status.dart';
import 'simple_app_upgrade.dart';

///
/// des:App 升级组件
///
class AppUpgrade {
  ///
  /// App 升级组件入口函数，在`initState`方法中调用此函数即可。不要在[MaterialApp]控件的`initState`方法中调用，
  /// 需要在[Scaffold]的`body`控件内调用。
  ///
  /// `context`: 用于`showDialog`时使用。
  ///
  /// `future`：返回Future<AppUpgradeInfo>，通常情况下访问后台接口获取更新信息
  ///
  /// `titleStyle`：title 文字的样式
  ///
  /// `contentStyle`：版本信息内容文字样式
  ///
  /// `cancelText`：取消按钮文字，默认"取消"
  ///
  /// `cancelTextStyle`：取消按钮文字样式
  ///
  /// `okText`：升级按钮文字，默认"立即体验"
  ///
  /// `okTextStyle`：升级按钮文字样式
  ///
  /// `okBackgroundColors`：升级按钮背景颜色，需要2种颜色，左到右线性渐变,默认是系统的[primaryColor,primaryColor]
  ///
  /// `progressBarColor`：下载进度条颜色
  ///
  /// `borderRadius`：圆角半径，默认20
  ///
  /// `iosAppId`：ios app id,用于跳转app store,格式：idxxxxxxxx
  ///
  /// `appMarketInfo`：指定Android平台跳转到第三方应用市场更新，如果不指定将会弹出提示框，让用户选择哪一个应用市场。
  ///
  /// `onCancel`：点击取消按钮回调
  ///
  /// `onOk`：点击更新按钮回调
  ///
  /// `downloadProgress`：下载进度回调
  ///
  /// `downloadStatusChange`：下载状态变化回调
  ///
  static void appUpgrade(
    BuildContext context,
    Future<AppUpgradeInfo?> future, {
    TextStyle? titleStyle,
    TextStyle? contentStyle,
    String? cancelText,
    TextStyle? cancelTextStyle,
    String? okText,
    TextStyle? okTextStyle,
    List<Color>? okBackgroundColors,
    Color? progressBarColor,
    double borderRadius = 20.0,
    required String iosAppId,
    AppMarketInfo? appMarketInfo,
    VoidCallback? onCancel,
    VoidCallback? onOk,
    DownloadProgressCallback? downloadProgress,
    DownloadStatusChangeCallback? downloadStatusChange,
    Widget Function(VoidCallback onOk)? dialogBuilder,
  }) {
    future.then((AppUpgradeInfo? appUpgradeInfo) {
      if (appUpgradeInfo != null) {
        _showUpgradeDialog(
            context, appUpgradeInfo.title, appUpgradeInfo.contents,
            apkDownloadUrl: appUpgradeInfo.apkDownloadUrl,
            force: appUpgradeInfo.force,
            titleStyle: titleStyle,
            contentStyle: contentStyle,
            cancelText: cancelText,
            cancelTextStyle: cancelTextStyle,
            okBackgroundColors: okBackgroundColors,
            okText: okText,
            okTextStyle: okTextStyle,
            borderRadius: borderRadius,
            progressBarColor: progressBarColor,
            iosAppId: iosAppId,
            appMarketInfo: appMarketInfo,
            onCancel: onCancel,
            onOk: onOk,
            downloadProgress: downloadProgress,
            downloadStatusChange: downloadStatusChange,
            //自定义升级界面
            dialogBuilder: dialogBuilder);
      }
    }).catchError((onError) {
      print('$onError');
    });
  }

  ///
  /// 展示app升级提示框
  ///
  static void _showUpgradeDialog(
    BuildContext context,
    String title,
    List<String> contents, {
    String? apkDownloadUrl,
    bool force = false,
    TextStyle? titleStyle,
    TextStyle? contentStyle,
    String? cancelText,
    TextStyle? cancelTextStyle,
    String? okText,
    TextStyle? okTextStyle,
    List<Color>? okBackgroundColors,
    Color? progressBarColor,
    double borderRadius = 20.0,
    required String iosAppId,
    AppMarketInfo? appMarketInfo,
    VoidCallback? onCancel,
    VoidCallback? onOk,
    DownloadProgressCallback? downloadProgress,
    DownloadStatusChangeCallback? downloadStatusChange,
    Widget Function(VoidCallback onOk)? dialogBuilder,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: dialogBuilder != null
                ? Dialog(
                    insetPadding:
                        EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                    child: CustomAppUpgradeWidget(
                        iosAppId: iosAppId, dialogBuilder: dialogBuilder),
                    backgroundColor: Colors.transparent,
                  )
                : Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(borderRadius))),
                    child: SimpleAppUpgradeWidget(
                        title: title,
                        titleStyle: titleStyle,
                        contents: contents,
                        contentStyle: contentStyle,
                        cancelText: cancelText,
                        cancelTextStyle: cancelTextStyle,
                        okText: okText,
                        okTextStyle: okTextStyle,
                        okBackgroundColors: okBackgroundColors ??
                            [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor
                            ],
                        progressBarColor: progressBarColor,
                        borderRadius: borderRadius,
                        downloadUrl: apkDownloadUrl,
                        force: force,
                        iosAppId: iosAppId,
                        appMarketInfo: appMarketInfo,
                        onCancel: onCancel,
                        onOk: onOk,
                        downloadProgress: downloadProgress,
                        downloadStatusChange: downloadStatusChange)),
          );
        });
  }
}

class AppInfo {
  AppInfo(
      {required this.versionName,
      required this.versionCode,
      required this.packageName});

  String versionName;
  String versionCode;
  String packageName;
}

class AppUpgradeInfo {
  AppUpgradeInfo(
      {required this.title,
      required this.contents,
      this.apkDownloadUrl,
      this.force = false});

  ///
  /// title,显示在提示框顶部
  ///
  final String title;

  ///
  /// 升级内容
  ///
  final List<String> contents;

  ///
  /// apk下载url
  ///
  final String? apkDownloadUrl;

  ///
  /// 是否强制升级
  ///
  final bool force;
}

///
/// 下载进度回调
///
typedef DownloadProgressCallback = Function(int count, int total);

///
/// 下载状态变化回调
///
typedef DownloadStatusChangeCallback = Function(DownloadStatus downloadStatus,
    {dynamic error});
