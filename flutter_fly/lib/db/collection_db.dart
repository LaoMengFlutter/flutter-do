import 'package:flutter_fly/entry/collection_info.dart';
import 'package:sqflite/sqflite.dart';

import 'db_helper.dart';

///
/// des: 收藏数据库
///
class CollectionDb {
  static final String _table = 'Collection';

  factory CollectionDb() => _getInstance();
  static CollectionDb _instance;
  static Database _db;

  CollectionDb._() {}

  static _getInstance() {
    if (_instance == null) {
      _instance = CollectionDb._();
    }
    return _instance;
  }

  initDb() async {
    _db = await DbHelper().getDb(
      version: 1,
    );
  }

  static onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $_table (title TEXT PRIMARY KEY, desc TEXT, url TEXT, tags TEXT)');
    print('create table:$_table');
  }

  deleteAll() async {
    await _db.delete(_table);
  }

  save(CollectionInfo info) async {
    try {
      await _db.insert('$_table', {
        'title': info.title,
        'desc': info.desc,
        'url': info.url,
        'tags': info.tags,
      });
    } catch (e) {
      print('$e,${info.title}');
    }
  }

  saveList(List<CollectionInfo> list) async {
    list.forEach((f) async {
      try {
        await _db.insert('$_table', {
          'title': f.title,
          'desc': f.desc,
          'url': f.url,
          'tags': f.tags,
        });
      } catch (e) {
        print('$e,${f.title}');
      }
    });
  }

  Future<List<CollectionInfo>> findAll() async {
    var result = await _db.query('$_table');
    List<CollectionInfo> list = List();
    result.forEach((f) {
      list.add(CollectionInfo(
        title: f['title'] as String,
        desc: f['desc'] as String,
        url: f['url'] as String,
        tags: f['tags'] as String,
      ));
    });
    return list;
  }

  Future<CollectionInfo> find(String title) async {
    var result =
        await _db.query('$_table', where: 'title=?', whereArgs: [title]);
    if (result != null && result.length > 0) {
      return CollectionInfo(
        title: result.first['title'] as String,
        desc: result.first['desc'] as String,
        url: result.first['url'] as String,
        tags: result.first['tags'] as String,
      );
    }
    return CollectionInfo();
  }

  delete(String title) async {
    var result = await _db.delete(_table, where: 'title=?', whereArgs: [title]);
    return result >= 0;
  }

  Future close() async => _db.close();
}
