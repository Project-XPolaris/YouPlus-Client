import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginHistory {
  late String apiUrl;
  late String username;
  late String token;

  LoginHistory({required this.apiUrl, required this.username, required this.token});

  LoginHistory.fromJson(Map<String, dynamic> json) {
    apiUrl = json['apiUrl'];
    username = json['username'];
    token = json['token'];
  }
  Map<String, dynamic> toJson() =>
      {
        'apiUrl': apiUrl,
        'username': username,
        "token":token
      };
}

class LoginHistoryManager {
  List<LoginHistory> list = [];
  static final LoginHistoryManager _singleton = LoginHistoryManager._internal();
  factory LoginHistoryManager() {
    return _singleton;
  }
  refreshHistory() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? raw = sharedPreferences.getString("loginHistory");
    if (raw == null) {
      return;
    }
    List<dynamic> rawList = json.decode(raw);
    list = rawList.map((e) => LoginHistory.fromJson(e)).toList();
  }
  add(LoginHistory history) async {
    list.removeWhere((element) => element.apiUrl == history.apiUrl && element.username == history.username);
    list.insert(0, history);
    await save();
  }
  save() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String raw = jsonEncode(list);
    sharedPreferences.setString("loginHistory", raw);
  }
  LoginHistoryManager._internal();
}