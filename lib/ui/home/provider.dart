import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int currentIndex = 0;
  onChangeIndex(int index){
     currentIndex = index;
     notifyListeners();
  }
}