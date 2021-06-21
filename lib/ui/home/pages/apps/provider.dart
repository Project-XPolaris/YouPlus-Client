import 'package:flutter/material.dart';
import 'package:youplus/api/app.dart';
import 'package:youplus/api/base.dart';
import 'package:youplus/api/client.dart';

class HomeAppsProvider extends ChangeNotifier {
  List<AppResponse> apps = [];
  bool first = true;
  refreshApps({bool force = false})async {
    if (!first && !force) {
      return;
    }
    first = false;
    this.apps = await ApiClient().fetchAppList();
    notifyListeners();
  }
  Future<BaseResponse> startApp(id) async {
    BaseResponse response = await ApiClient().startApp(id);
    refreshApps(force: true);
    return response;
  }
  Future<BaseResponse> stopApp(id) async {
    BaseResponse response = await ApiClient().stopApp(id);
    refreshApps(force: true);
    return response;
  }
}