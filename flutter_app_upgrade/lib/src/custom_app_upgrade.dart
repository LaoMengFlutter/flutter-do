import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_upgrade/flutter_app_upgrade.dart';
import 'package:flutter_app_upgrade/src/download_status.dart';

///
/// des:自定义UI
///
class CustomAppUpgradeWidget extends StatefulWidget {
  const CustomAppUpgradeWidget(
      {this.downloadUrl,
      this.force = false,
      required this.iosAppId,
      this.appMarketInfo,
      this.onOk,
      required this.dialogBuilder,
      this.downloadProgress,
      this.downloadStatusChange});

  ///
  /// app安装包下载url,没有下载跳转到应用宝等渠道更新
  ///
  final String? downloadUrl;

  ///
  /// 是否强制升级,设置true没有取消按钮
  ///
  final bool force;

  ///
  /// ios app id,用于跳转app store
  ///
  final String iosAppId;

  final Widget Function(VoidCallback onOk) dialogBuilder;

  ///
  /// 指定跳转的应用市场，
  /// 如果不指定将会弹出提示框，让用户选择哪一个应用市场。
  ///
  final AppMarketInfo? appMarketInfo;

  final VoidCallback? onOk;
  final DownloadProgressCallback? downloadProgress;
  final DownloadStatusChangeCallback? downloadStatusChange;

  @override
  State<StatefulWidget> createState() => _CustomAppUpgradeWidget();
}

class _CustomAppUpgradeWidget extends State<CustomAppUpgradeWidget> {
  static final String _downloadApkName = 'temp.apk';

  ///
  /// 下载进度
  ///
  double _downloadProgress = 0.0;

  DownloadStatus _downloadStatus = DownloadStatus.none;

  @override
  Widget build(BuildContext context) {
    return widget.dialogBuilder(_onOk);
  }

  void _onOk() {
    _clickOk();
  }

  ///
  /// 点击确定按钮
  ///
  _clickOk() async {
    widget.onOk?.call();
    if (Platform.isIOS) {
      //ios 需要跳转到app store更新，原生实现
      FlutterUpgrade.toAppStore(widget.iosAppId);
      return;
    }
    if (widget.downloadUrl == null || widget.downloadUrl!.isEmpty) {
      //没有下载地址，跳转到第三方渠道更新，原生实现
      FlutterUpgrade.toMarket(appMarketInfo: widget.appMarketInfo);
    }
    String path = await FlutterUpgrade.apkDownloadPath;
    _downloadApk(widget.downloadUrl!, '$path/$_downloadApkName');
  }

  ///
  /// 下载apk包
  ///
  _downloadApk(String url, String path) async {
    if (_downloadStatus == DownloadStatus.start ||
        _downloadStatus == DownloadStatus.downloading ||
        _downloadStatus == DownloadStatus.done) {
      print('当前下载状态：$_downloadStatus,不能重复下载。');
      return;
    }

    _updateDownloadStatus(DownloadStatus.start);
    try {
      var dio = Dio();
      await dio.download(url, path, onReceiveProgress: (int count, int total) {
        if (total == -1) {
          _downloadProgress = 0.01;
        } else {
          widget.downloadProgress?.call(count, total);
          _downloadProgress = count / total.toDouble();
        }
        setState(() {});
        if (_downloadProgress == 1) {
          //下载完成，跳转到程序安装界面
          _updateDownloadStatus(DownloadStatus.done);
          Navigator.pop(context);
          FlutterUpgrade.installAppForAndroid(path);
        }
      });
    } catch (e) {
      print('$e');
      _downloadProgress = 0;
      _updateDownloadStatus(DownloadStatus.error, error: e);
    }
  }

  _updateDownloadStatus(DownloadStatus downloadStatus, {dynamic error}) {
    _downloadStatus = downloadStatus;
    widget.downloadStatusChange?.call(_downloadStatus, error: error);
  }
}
