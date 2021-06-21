import 'package:flutter/material.dart';
import 'package:youplus/api/client.dart';
import 'package:youplus/api/folder.dart';

class HomeFolderProvider extends ChangeNotifier {
  List<ShareFolder> folders = [];
  bool first = true;
  refreshFolders({bool force = false})async {
    if (!first && !force) {
      return;
    }
    first = false;
    this.folders = await ApiClient().fetchShareFolderList();
    notifyListeners();
  }
}