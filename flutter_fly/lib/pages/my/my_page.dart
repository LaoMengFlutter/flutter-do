import 'package:flutter/material.dart';
import 'package:flutter_fly/db/browse_db.dart';
import 'package:flutter_fly/db/collection_db.dart';
import 'package:flutter_fly/pages/routes/Routes.dart';

///
/// des: 我的
///
class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _collectionCount = 0;
  int _browseCount = 0;

  _loadData() async {
    await CollectionDb().initDb();
    var result = await CollectionDb().findAll();
    await BrowseDb().initDb();
    var result1 = await BrowseDb().findAll();
    setState(() {
      _collectionCount = result.length;
      _browseCount = result1.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadData();
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          _buildAuthor(context),
          SizedBox(
            height: 10,
          ),
          _buildCollectionAndRecord(context),
          SizedBox(
            height: 10,
          ),
          _buildItem('关于', () {
            Navigator.pushNamed(context, Routes.about_page);
          }),
        ],
      ),
    );
  }

  ///
  /// 作者简介
  ///
  _buildAuthor(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.my_detail_page);
      },
      child: Container(
        height: 100,
        color: Colors.white,
        padding: EdgeInsets.only(left: 25, right: 15),
        child: Container(
          child: Row(
            children: <Widget>[
              //头像
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/header.png'),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(60))),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '老孟程序员',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '一枚有态度的程序员',
                      style: TextStyle(color: Color(0xFF727272)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFC9C9C9)),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// 收藏和浏览记录
  ///
  _buildCollectionAndRecord(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildItem('我收藏的文章($_collectionCount)', () {
            Navigator.pushNamed(context, Routes.collections_page);
          }),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Divider(
              height: 1,
            ),
          ),
          _buildItem('我浏览的文章($_browseCount)', () {
            Navigator.pushNamed(context, Routes.browse_page);
          }),
        ],
      ),
    );
  }

  _buildItem(String title, onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 65,
        color: Colors.white,
        padding: EdgeInsets.only(left: 25, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFC9C9C9)),
          ],
        ),
      ),
    );
  }
}
