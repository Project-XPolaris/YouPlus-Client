import 'package:flutter/material.dart';
import 'package:youplus/ui/home/home.dart';
import 'package:youplus/ui/start/start.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouPlus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
        ),
        primaryColor: Colors.green,
        accentColor: Colors.yellow,

      ),
      home: StartPage(),
    );
  }
}
