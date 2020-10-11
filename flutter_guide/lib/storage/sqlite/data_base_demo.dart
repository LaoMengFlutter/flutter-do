import 'package:flutter/material.dart';
import 'data_base.dart';
import 'user.dart';

///
/// des:
///
class DatabaseDemo extends StatefulWidget {
  @override
  _DatabaseDemoState createState() => _DatabaseDemoState();
}

class _DatabaseDemoState extends State<DatabaseDemo> {
  List<User> _list = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    _list = await DBProvider().findAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sqlite Demo'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text('查询数据'),
                onPressed: () {
                  _loadData();
                },
              ),
              RaisedButton(
                child: Text('添加数据'),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return _AddUser();
                  }));
                },
              ),

            ],
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text('修改第一行数据'),
                onPressed: () {
                  if (_list.length > 0) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return _AddUser(
                        user: _list[0],
                      );
                    }));
                  }
                },
              ),
              RaisedButton(
                child: Text('删除第一行数据'),
                onPressed: () async {
                  if (_list.length > 0) {
                    await DBProvider().deleteAll();
                    _loadData();
                  }
                },
              ),
            ],
          ),
          Table(
            children: [
              TableRow(children: [
                TableCell(child: Text('id')),
                TableCell(child: Text('姓名')),
                TableCell(child: Text('年龄')),
                TableCell(child: Text('性别')),
              ]),
              ..._list.map((user) {
                return TableRow(children: [
                  TableCell(child: Text('${user.id}')),
                  TableCell(child: Text('${user.name}')),
                  TableCell(child: Text('${user.age}')),
                  TableCell(child: Text(user.sex == 0 ? '男' : '女')),
                ]);
              }).toList()
            ],
          )
        ],
      ),
    );
  }
}

class _AddUser extends StatefulWidget {
  final User user;

  const _AddUser({Key key, this.user}) : super(key: key);

  @override
  __AddUserState createState() => __AddUserState();
}

class __AddUserState extends State<_AddUser> {
  String _radioGroupValue = '0';
  TextEditingController _nameController;
  TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    if (widget.user != null) {
      _nameController.text = '${widget.user.name}';
      _ageController.text = '${widget.user.age}';
      _radioGroupValue = '${widget.user.sex}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('保存数据'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('姓名：'),
              Flexible(
                child: TextField(
                  controller: _nameController,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text('年龄：'),
              Flexible(
                child: TextField(
                  controller: _ageController,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text('性别：'),
              Flexible(
                child: RadioListTile(
                  title: Text('男'),
                  value: '0',
                  groupValue: _radioGroupValue,
                  onChanged: (value) {
                    setState(() {
                      _radioGroupValue = value;
                    });
                  },
                ),
              ),
              Flexible(
                child: RadioListTile(
                  title: Text('女'),
                  value: '1',
                  groupValue: _radioGroupValue,
                  onChanged: (value) {
                    setState(() {
                      _radioGroupValue = value;
                    });
                  },
                ),
              ),
            ],
          ),
          Builder(
            builder: (BuildContext context) {
              return RaisedButton(
                child: Text('保存'),
                onPressed: () async {
                  var user = User(
                      name: '${_nameController.text}',
                      age: int.parse('${_ageController.text}'),
                      sex: int.parse('$_radioGroupValue'));
                  if (widget.user == null) {
                    _saveData(context,user);
                  } else {
                    _updateData(context,user);
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }

  _saveData(BuildContext context,User user) async {
    int result = await DBProvider().rawInsert(user);
    if (result > 0) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('保存数据成功，result:$result'),
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('保存数据失败，result:$result'),
      ));
    }
  }

  _updateData(BuildContext context,User user) async {
    user.id = widget.user.id;
    int result = await DBProvider().update(user);
    if (result > 0) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('修改数据成功，result:$result'),
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('修改数据失败，result:$result'),
      ));
    }
  }
}
