import 'package:flutter_fly/entry/article_info.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import 'db_helper.dart';

///
/// des:
///
class ArticleDb {
  static final String _table = 'Article';

  factory ArticleDb() => _getInstance();
  static ArticleDb _instance;
  static Database _db;

  ArticleDb._() {}

  static _getInstance() {
    if (_instance == null) {
      _instance = ArticleDb._();
    }
    return _instance;
  }

  initDb() async {
    _db = await DbHelper()
        .getDb(version: 1, onCreate: (Database db, int version) async {});
  }

  static onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $_table (title TEXT PRIMARY KEY,  url TEXT, author TEXT,type INTEGER, time TEXT)');
    print('create table:$_table');
  }

  deleteAll() async {
    await _db.delete(_table);
  }

  save(List<ArticleInfo> list) async {
    list.forEach((f) async {
      try {
        await _db.insert('$_table', {
          'title': f.title,
          'url': f.url,
          'author': f.author,
          'type': f.type.index,
          'time': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
        });
      } catch (e) {
        print('$e,${f.title}');
      }
    });
  }

  Future<List<ArticleInfo>> findAll() async {
    var result = await _db.query('$_table');
    List<ArticleInfo> list = List();
    result.forEach((f) {
      var type = ArticleType.technology;
      if (f['type'] == 0) {
        type = ArticleType.news;
      }
      list.add(ArticleInfo(
          title: f['title'],
          url: f['url'],
          author: f['author'],
          type: type,
          time: DateFormat("yyyy-MM-dd HH:mm:ss").parse(f['time'])));
    });
    return list;
  }

  Future<ArticleInfo> find(String title) async {
    var result =
        await _db.query('$_table', where: 'title=?', whereArgs: [title]);
    if (result != null && result.length > 0) {
      return ArticleInfo(
          title: result.first['title'],
          url: result.first['url'],
          author: result.first['author']);
    }
    return ArticleInfo();
  }

  Future close() async => _db.close();
}
