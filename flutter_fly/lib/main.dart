import 'package:flutter/material.dart';
import 'package:flutter_fly/pages/routes/Routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Fly',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Color(0xFF5DC782),
        backgroundColor: Color(0xFFF2F2F2)
      ),
      routes: Routes.routes,
      initialRoute: Routes.welcome_page,
      debugShowCheckedModeBanner: false,
    );
  }
}
