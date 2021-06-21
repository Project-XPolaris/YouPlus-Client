import 'package:flutter/material.dart';
import 'package:youplus/api/client.dart';
import 'package:youplus/api/info.dart';

class HomeIndexProvider extends ChangeNotifier {
  DeviceInfo? deviceInfo;
  bool firstInfo = true;
  refreshDeviceInfo() async {
    if (!firstInfo) {
      return;
    }
    firstInfo = false;
    this.deviceInfo = await ApiClient().fetchDeviceInfo();
    notifyListeners();
  }
}