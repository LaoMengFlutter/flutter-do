import 'package:flutter_fly/entry/widget_info.dart';
import 'package:sqflite/sqflite.dart';

import 'db_helper.dart';

///
/// des:控件db
///
class WidgetDb {
  static final String _table = 'Widget';

  factory WidgetDb() => _getInstance();
  static WidgetDb _instance;
  static Database _db;

  WidgetDb._() {}

  static _getInstance() {
    if (_instance == null) {
      _instance = WidgetDb._();
    }
    return _instance;
  }

  initDb() async {
    _db = await DbHelper()
        .getDb(version: 1, onCreate: (Database db, int version) async {});
  }

  static onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $_table (title TEXT PRIMARY KEY, desc TEXT, url TEXT, tags TEXT)');
    print('create table:$_table');
  }

  deleteAll() async {
    await _db.delete(_table);
  }

  save(List<WidgetInfo> list) async {
    list.forEach((f) async {
      try {
        await _db.insert('$_table',
            {'title': f.title, 'desc': f.desc, 'url': f.url, 'tags': f.tags});
      } catch (e) {
        print('$e,${f.title}');
      }
    });
  }

  Future<List<WidgetInfo>> findAll() async {
    var result = await _db.query('$_table');
    List<WidgetInfo> list = List();
    result.forEach((f) {
      var info = {
        'title': f['title'],
        'desc': f['desc'],
        'url': f['url'],
        'tags': f['tags']
      };
      list.add(WidgetInfo.fromJson(info));
    });
    return list;
  }

  Future<WidgetInfo> find(String title) async {
    var result =
        await _db.query('$_table', where: 'title=?', whereArgs: [title]);
    if (result != null && result.length > 0) {
      var info = {
        'title': result.first['title'],
        'desc': result.first['desc'],
        'url': result.first['url'],
        'tags': result.first['tags']
      };
      return WidgetInfo.fromJson(info);
    }
    return WidgetInfo();
  }

  Future close() async => _db.close();
}
