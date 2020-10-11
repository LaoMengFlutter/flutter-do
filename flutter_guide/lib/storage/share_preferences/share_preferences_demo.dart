import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// des:
///
class SharePreferencesDemo extends StatefulWidget {
  @override
  _SharePreferencesDemoState createState() => _SharePreferencesDemoState();
}

class _SharePreferencesDemoState extends State<SharePreferencesDemo> {
  _saveData() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setStringList('Key_StringList', ['laomeng', 'Flutter']);
  }

  Future<List<String>> _readData() async {
    var prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('Key_StringList');
    return result ?? [];
  }

  Future<bool> _deleteData() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('Key');
  }

  Future<bool> _clearData() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<Set<String>> _getKeys() async {
    var prefs = await SharedPreferences.getInstance();
    var keys = prefs.getKeys();
    return keys ?? [];
  }

  Future<bool> _containsKey() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('Key') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RaisedButton(
          child: Text('保存数据'),
          onPressed: () {
            _saveData();
            _readData();
            _getKeys();
          },
        ),
      ),
    );
  }
}
