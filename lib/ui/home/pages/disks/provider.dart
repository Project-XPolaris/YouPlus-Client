import 'package:flutter/material.dart';
import 'package:youplus/api/client.dart';
import 'package:youplus/api/disk_list_response.dart';

class DiskListProvider extends ChangeNotifier {
  List<Disk> disks = [];
  bool first = true;
  refresh({force = false})async {
    if (!first && !force) {
      return;
    }
    first = false;
    var response = await ApiClient().fetchDiskList();
    if (response.disks != null) {
      disks = response.disks!;
      disks.sort((a,b) { return (a.name ?? "Unknown").compareTo(b.name ?? "Unknown"); });
    }
    notifyListeners();
  }
}