import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youplus/ui/home/pages/apps/apps.dart';
import 'package:youplus/ui/home/pages/device/device.dart';
import 'package:youplus/ui/home/pages/folder/folder.dart';
import 'package:youplus/ui/home/pages/index/index.dart';
import 'package:youplus/ui/home/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
        create: (_) => HomeProvider(),
    child: Consumer<HomeProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(title: Text("YouPlus"),elevation: 0,),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: provider.currentIndex,
          onTap: (idx) => provider.onChangeIndex(idx),
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black54,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.apps),label: "Apps"),
            BottomNavigationBarItem(icon: Icon(Icons.folder),label: "Folder"),
            BottomNavigationBarItem(icon: Icon(Icons.wysiwyg_outlined),label: "Device"),
          ],
        ),
        body: IndexedStack(
          index:provider.currentIndex,
          children: [
            HomeIndex(),
            HomeApps(),
            HomeFolder(),
            HomeDevicePage()
          ],
        ),
      );
    }));

  }
}

