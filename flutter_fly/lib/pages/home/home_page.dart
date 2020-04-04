import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fly/http/http_factory.dart';
import 'package:flutter_fly/pages/my/my_page.dart';
import 'package:flutter_fly/pages/search/search_page.dart';
import 'package:flutter_fly/pages/widgets_item/widget_page.dart';
import 'package:flutter_fly/widgets/fluid_nav_bar/fluid_nav_bar.dart';
import 'package:flutter_upgrade/upgrade.dart';
import 'home_item_page.dart';

///
/// des: 首页底部导航及页面切换
///

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 当前body
  int _currIndex = 0;
  AppBar _appBar;
  AppBar _defaultAppBar = AppBar(
    title: Text('Flutter Fly'),
    centerTitle: true,
    elevation: 0,
  );

  @override
  void initState() {
    super.initState();
    _appBar = _defaultAppBar;
    AppUpgrade.appUpgrade(context, _checkAppInfo(),
        okBackgroundColors: [Color(0xFF5DC782), Color(0xFF5DC782)],
        progressBarColor: Color(0xFF5DC782).withOpacity(.5));
  }

  ///
  /// 检测app升级
  ///
  Future<AppUpgradeInfo> _checkAppInfo() async {
    var updateInfo = await HttpFactory().getUpgradeInfo();
    var appInfo = await FlutterUpgrade.appInfo;
    if (updateInfo['version'] != appInfo.versionName) {
      return Future.value(AppUpgradeInfo(
        title: updateInfo['title'],
        contents: (updateInfo['content'] as String).split('\r\n'),
        apkDownloadUrl: updateInfo['apkDownloadUrl'],
        force: updateInfo['force'],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: IndexedStack(
        index: _currIndex,
        children: <Widget>[HomeItemPage(), WidgetPage(), MyPage()],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  ///
  /// 构建底部导航
  ///
  Widget _buildBottomNavigationBar(BuildContext context) {
    return FluidNavBar(
      icons: <Widget>[
        Icon(Icons.bookmark_border),
        Icon(Icons.apps),
        Icon(Icons.perm_identity),
      ],
      activeIcons: <Widget>[
        Icon(
          Icons.bookmark_border,
          color: Theme.of(context).accentColor,
        ),
        Icon(Icons.apps, color: Theme.of(context).accentColor),
        Icon(Icons.person, color: Theme.of(context).accentColor),
      ],
      titles: <Widget>[
        Text('首页'),
        Text('控件'),
        Text('我的'),
      ],
      onChange: _navBarOnChange,
    );
  }

  ///
  /// 切换动画，渐隐渐显
  ///
  _navBarOnChange(int index) {
    HapticFeedback.lightImpact();
    _currIndex = index;
    if (_currIndex == 1) {
      _appBar = _getWidgetAppBar();
    } else {
      _appBar = _defaultAppBar;
    }
    setState(() {});
  }

  _getWidgetAppBar() {
    return AppBar(
      title: InkWell(
        onTap: () {
          showSearch(context: context, delegate: WidgetSearchDelegate());
        },
        child: Container(
          height: 45,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.centerLeft,
          child: Icon(Icons.search),
        ),
      ),
    );
  }
}
