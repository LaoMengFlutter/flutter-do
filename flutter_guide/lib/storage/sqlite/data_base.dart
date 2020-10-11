import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'user.dart';

class DBProvider {
  static final DBProvider _singleton = DBProvider._internal();

  factory DBProvider() {
    return _singleton;
  }

  DBProvider._internal();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDB();
    return _db;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'dbName');
    return await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  ///
  /// 创建Table
  ///
  Future _onCreate(Database db, int version) async {
    return await db.execute("CREATE TABLE User ("
        "id integer primary key AUTOINCREMENT,"
        "name TEXT,"
        "age integer,"
        "sex integer"
        ")");
  }

  ///
  /// 更新Table
  ///
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  Future saveData(User user) async {
    var _db = await db;
    return await _db.insert('User', user.toJson());
  }

  Future rawInsert(User user) async {
    var _db = await db;
    return await _db.rawInsert('INSERT Into User (name,age,sex) VALUES (?,?,?)',
        [user.name, user.age, user.sex]);
  }

  Future<List<User>> findAll() async {
    var _db = await db;
    List<Map<String, dynamic>> result = await _db.query('User');

    return result.isNotEmpty
        ? result.map((e) {
            return User.fromJson(e);
          }).toList()
        : [];
  }

  Future<List<User>> find(int age) async {
    var _db = await db;
    List<Map<String, dynamic>> result =
        await _db.query('User', where: 'age = ?', whereArgs: [age]);

    return result.isNotEmpty
        ? result.map((e) {
            return User.fromJson(e);
          }).toList()
        : [];
  }

  Future<int> update(User user) async {
    var _db = await db;
    return await _db
        .update('User', user.toJson(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<int> delete(int id) async {
    var _db = await db;
    return await _db.delete('User', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    var _db = await db;
    return await _db.delete('User');
  }
}
