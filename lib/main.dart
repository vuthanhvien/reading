import 'package:flutter/material.dart';
import 'screens/auth/index.dart';
import 'screens/home/index.dart';

void main() async {
  final routes = <String, WidgetBuilder>{
    '/Auth': (BuildContext context) => new Auth(),
    '/Home': (BuildContext context) => new Home()
  };

  {
    runApp(new MaterialApp(
      title: 'Flutter Demo',
      routes: routes,
      theme: ThemeData(fontFamily: 'RobotoSlab'),
      home: new Home(),
    ));
  }
}
