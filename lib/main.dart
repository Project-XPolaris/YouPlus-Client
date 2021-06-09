
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:youplus/ui/home/home.dart';
import 'package:youplus/ui/layout/index.dart';

void main() {
  runApp(MyApp());


    doWhenWindowReady(() {
      final win = appWindow;
      final initialSize = Size(1280, 720);
      win.size = initialSize;
      win.alignment = Alignment.center;
      win.title = "Custom window with Flutter";
      win.show();
    });

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouPlus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: Layout(
        child: HomePage(),
      ),
    );
  }
}
