import 'package:sqflite/sqflite.dart';

import 'db_helper.dart';

///
/// des:浏览历史
///
class BrowseDb {
  static final String _table = 'Browse';

  factory BrowseDb() => _getInstance();
  static BrowseDb _instance;
  static Database _db;

  BrowseDb._() {}

  static _getInstance() {
    if (_instance == null) {
      _instance = BrowseDb._();
    }
    return _instance;
  }

  initDb() async {
    _db = await DbHelper().getDb(version: 1);
  }

  static onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $_table (title TEXT PRIMARY KEY, desc TEXT, url TEXT, tags TEXT)');
    print('create table:$_table');
  }

  deleteAll() async {
    await _db.delete(_table);
  }

  save(String title,
      {String desc = '', String url = '', String tags = ''}) async {
    try {
      await _db.insert('$_table', {
        'title': title,
        'desc': desc,
        'url': url,
        'tags': tags,
      });
    } catch (e) {
      print('$e,${title}');
    }
  }

  Future<List<Map<String, dynamic>>> findAll() async {
    return await _db.query('$_table');
  }

  Future<Map<String, dynamic>> find(String title) async {
    var result =
        await _db.query('$_table', where: 'title=?', whereArgs: [title]);
    if (result != null && result.length > 0) {
      return result.first;
    }
  }

  Future close() async => _db.close();
}
