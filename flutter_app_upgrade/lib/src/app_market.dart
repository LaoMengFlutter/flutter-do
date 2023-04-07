///
/// des:
///

class AppMarket {
  ///
  /// 获取所有内置的应用商店的包名
  ///
  static List<String> get buildInPackageNameList {
    return buildInMarketList.map((f) {
      return f.packageName;
    }).toList();
  }

  ///
  /// 通过包名获取内置应用商店
  ///
  static List<AppMarketInfo> getBuildInMarketList(List<String> packageNames) {
    List<AppMarketInfo> marketList = [];
    packageNames.forEach((packageName) {
      buildInMarketList.forEach((f) {
        if (f.packageName == packageName) {
          marketList.add(f);
        }
      });
    });
    return marketList;
  }

  static AppMarketInfo? getBuildInMarket(String packageName) {
    AppMarketInfo? _info;
    buildInMarketList.forEach((f) {
      if (f.packageName == packageName) {
        _info = f;
      }
    });
    return _info;
  }

  ///
  /// 获取所有内置的应用商店
  ///
  static List<AppMarketInfo> get buildInMarketList {
    return [
      xiaoMi,
      meiZu,
      vivo,
      oppo,
      huaWei,
      zte,
      qiHoo,
      tencent,
      pp,
      wanDouJia
    ];
  }

  ///
  /// 小米
  ///
  static final xiaoMi = AppMarketInfo(
      'xiaoMi', "com.xiaomi.market", "com.xiaomi.market.ui.AppDetailActivity");

  ///
  /// 魅族
  ///
  static final meiZu = AppMarketInfo('meiZu', "com.meizu.mstore",
      "com.meizu.flyme.appcenter.activitys.AppMainActivity");

  ///
  /// vivo
  ///
  static final vivo = AppMarketInfo(
      'vivo', "com.bbk.appstore", "com.bbk.appstore.ui.AppStoreTabActivity");

  ///
  /// oppo
  ///
  static final oppo = AppMarketInfo('oppo', "com.oppo.market", "a.a.a.aoz");

  ///
  /// 华为
  ///
  static final huaWei = AppMarketInfo('huaWei', "com.huawei.appmarket",
      "com.huawei.appmarket.service.externalapi.view.ThirdApiActivity");

  ///
  /// zte
  ///
  static final zte = AppMarketInfo('zte', "zte.com.market",
      "zte.com.market.view.zte.drain.ZtDrainTrafficActivity");

  ///
  /// 360
  ///
  static final qiHoo = AppMarketInfo('qiHoo', "com.qihoo.appstore",
      "com.qihoo.appstore.distribute.SearchDistributionActivity");

  ///
  /// 应用宝
  ///
  static final tencent = AppMarketInfo(
      'tencent',
      "com.tencent.android.qqdownloader",
      "com.tencent.pangu.link.LinkProxyActivity");

  ///
  /// pp助手
  ///
  static final pp = AppMarketInfo(
      'pp', "com.pp.assistant", "com.pp.assistant.activity.MainActivity");

  ///
  /// 豌豆荚
  ///
  static final wanDouJia = AppMarketInfo('wanDouJia', "com.wandoujia.phoenix2",
      "com.pp.assistant.activity.PPMainActivity");
}

class AppMarketInfo {
  const AppMarketInfo(this.marketName, this.packageName, this.className);

  final String marketName;
  final String packageName;
  final String className;
}
