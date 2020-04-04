import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_fly/db/article_db.dart';
import 'package:flutter_fly/db/widget_db.dart';
import 'package:flutter_fly/entry/article_info.dart';
import 'package:flutter_fly/entry/widget_info.dart';
import 'package:flutter_fly/http/http_factory.dart';
import 'package:flutter_fly/pages/home/view_page.dart';
import 'package:flutter_fly/widgets/custom_web_view.dart';

///
/// des:首页
///
class HomeItemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeItemPageState();
}

class _HomeItemPageState extends State<HomeItemPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<ArticleInfo> _newsList = [];
  List<ArticleInfo> _technologyList = [];
  var _bannerList = [];
  var _newsKey = PageStorageKey('news');
  var _technologyKey = PageStorageKey('technology');

  @override
  void initState() {
    _loadData();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  ///
  /// 加载数据,先加载本地数据，然后加载服务器数据
  ///
  _loadData() async {
    await _loadLocalBannerData();
    await _loadLocalArticleData();
    await _loadRemoteData();
  }

  ///
  /// 加载本地Banner数据
  ///
  _loadLocalBannerData() async {
    var jsonStr = await DefaultAssetBundle.of(context)
        .loadString('assets/json/banner.json');
    _bannerList = json.decode(jsonStr);
    setState(() {});
  }

  ///
  /// 加载本地文章数据，先加载数据库，
  /// 如果数据库没有数据，加载本地json数据,然后将本地json数据保存到数据库
  ///
  _loadLocalArticleData() async {
    await ArticleDb().initDb();
    var list = await ArticleDb().findAll();
    if (list != null && list.length > 0) {
      _newsList = list.where((f) {
        return f.type == ArticleType.news;
      }).toList();

      _technologyList = list.where((f) {
        return f.type == ArticleType.technology;
      }).toList();
      setState(() {});
    } else {
      //加载json
      var newsJson = await DefaultAssetBundle.of(context)
          .loadString('assets/json/news.json');
      List<dynamic> newsData = json.decode(newsJson);
      newsData.forEach((f) {
        _newsList.add(ArticleInfo(
            title: f['title'],
            url: f['url'],
            author: f['author'],
            type: ArticleType.news));
      });

      var technologyJson = await DefaultAssetBundle.of(context)
          .loadString('assets/json/technology.json');
      List<dynamic> technologyData = json.decode(technologyJson);
      technologyData.forEach((f) {
        _technologyList.add(ArticleInfo(
            title: f['title'],
            url: f['url'],
            author: f['author'],
            type: ArticleType.technology));
      });
      _sortData();
      _saveData(_newsList);
      _saveData(_technologyList);
    }
  }

  ///
  /// 资讯和技术文章排序并重构
  ///
  _sortData() {
    _newsList.sort((a, b) {
      return b.time.compareTo(a.time);
    });
    _technologyList.sort((a, b) {
      return b.time.compareTo(a.time);
    });
    setState(() {});
  }

  ///
  /// 加载服务器数据
  ///
  _loadRemoteData() async {
    var result = await HttpFactory().getData();
    _handleBanner(result);
    var addArticleList = _handleArticle(result);
    _sortData();
    setState(() {});
    _saveData(addArticleList);
    _handlerWidgets(result);
  }

  ///
  /// 解析banner数据
  ///
  _handleBanner(dynamic data) {
    var result = data['banner'];
    if (result != null && result.length > 0) {
      _bannerList = result;
    }
  }

  ///
  /// 解析文章数据
  ///
  _handleArticle(dynamic data) {
    var result = data['article'];
    if (result != null && result.length > 0) {
      //去除重复
      result.removeWhere((f) {
        return _newsList.any((v) {
          return v.title == f['title'];
        });
      });
      result.removeWhere((f) {
        return _technologyList.any((v) {
          return v.title == f['title'];
        });
      });

      if (result.length > 0) {
        List<ArticleInfo> saveList = [];
        result.forEach((f) {
          print('新增文章:${f['title']}');
          if (f['type'] == 0) {
            var info = ArticleInfo(
                title: f['title'],
                url: f['url'],
                author: f['author'],
                type: ArticleType.news);
            _newsList.add(info);
            saveList.add(info);
          } else {
            var info = ArticleInfo(
                title: f['title'],
                url: f['url'],
                author: f['author'],
                type: ArticleType.technology);
            _technologyList.add(info);
            saveList.add(info);
          }
        });
        return saveList;
      }
    }
  }

  ///
  /// 解析控件数据
  ///
  _handlerWidgets(dynamic data) async {
    var result = data['widget'];
    if (result != null && result.length > 0) {
      List<WidgetInfo> list = [];
      result.forEach((f) {
        list.add(WidgetInfo.fromJson(f));
      });
      await WidgetDb().initDb();
      await WidgetDb().save(list);
    }
  }

  ///
  /// 保存文章数据到数据库
  ///
  _saveData(List<ArticleInfo> list) async {
    if (list == null || list.length == 0) {
      return;
    }
    await ArticleDb().initDb();
    await ArticleDb().save(list);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, bool) {
        return [
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.transparent,
            expandedHeight: 230,
            flexibleSpace: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: ViewPage(_bannerList),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyTabBarDelegate(
              child: TabBar(
                labelColor: Colors.black,
                controller: this._tabController,
                tabs: <Widget>[
                  Tab(text: '资讯'),
                  Tab(text: '技术'),
                ],
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: this._tabController,
        children: <Widget>[
          _buildTabNewsList(_newsKey, _newsList),
          _buildTabNewsList(_technologyKey, _technologyList),
        ],
      ),
    );
  }

  ///
  /// 每一个tab下的list
  ///
  _buildTabNewsList(Key key, List<ArticleInfo> list) {
    return ListView.separated(
        key: key,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(list[index].title),
            subtitle: Text('作者：${list[index].author}'),
            onTap: () {
              toWebView(context, list[index].title, list[index].url);
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 8,
          );
        },
        itemCount: list.length);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: this.child,
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
