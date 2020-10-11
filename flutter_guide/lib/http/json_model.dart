import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

///
/// desc:
///

class Json2Model extends StatefulWidget {
  @override
  _Json2ModelState createState() => _Json2ModelState();
}

class _Json2ModelState extends State<Json2Model> {
  getData() async {
    String jsonStr = "{\"name\":\"laomeng\",\"age\":12,\"email\":\"flutter@example.com\"}";
    var jsonMap = json.decode(jsonStr);
    var user =
        User(name: jsonMap['name'], age: jsonMap['age'], email: jsonMap['email']);
    print('$user');
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class User {
  final String name;
  final int age;
  final String email;

  User({this.name, this.age, this.email});

  @override
  String toString() {
    return 'name:$name,age:$age,email:$email';
  }
}
