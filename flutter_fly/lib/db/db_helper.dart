import 'dart:io';

import 'package:flutter_fly/db/article_db.dart';
import 'package:flutter_fly/db/browse_db.dart';
import 'package:flutter_fly/db/collection_db.dart';
import 'package:flutter_fly/db/widget_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

///
/// des: 数据库帮助类
///
class DbHelper {
  DbHelper();

  final String _dbName = 'flutter_do.db';
  Database _db;

  final _lock = Lock();

  Future<Database> getDb(
      {int version,
      OnDatabaseConfigureFn onConfigure,
      OnDatabaseCreateFn onCreate,
      OnDatabaseVersionChangeFn onUpgrade,
      OnDatabaseVersionChangeFn onDowngrade,
      OnDatabaseOpenFn onOpen,
      bool readOnly = false,
      bool singleInstance = true}) async {
    await _createDatabaseDir();
    if (_db == null) {
      await _lock.synchronized(() async {
        if (_db == null) {
          _db = await openDatabase(_dbName,
              version: version,
              onConfigure: onConfigure,
              onCreate: _onCreate,
              onUpgrade: onUpgrade,
              onDowngrade: onDowngrade,
              onOpen: onOpen,
              readOnly: readOnly,
              singleInstance: singleInstance);
        }
      });
    }
    return _db;
  }

  _createDatabaseDir() async {
    var databasesPath = await getDatabasesPath();
    // Make sure the directory exists
    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (_) {}
  }

  _onCreate(Database db, int version) async {
    await WidgetDb.onCreate(db, version);
    await CollectionDb.onCreate(db, version);
    await BrowseDb.onCreate(db, version);
    await ArticleDb.onCreate(db, version);
  }
}
