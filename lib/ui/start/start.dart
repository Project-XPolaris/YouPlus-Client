import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youplus/api/base.dart';
import 'package:youplus/api/client.dart';
import 'package:youplus/ui/home/home.dart';
import 'package:youplus/util/login_history.dart';

import '../../config.dart';

class StartPage extends StatefulWidget {
  const StartPage() : super();

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String inputUrl = "";
  String inputUsername = "";
  String inputPassword = "";
  String loginMode = "history";

  Future<bool> _init() async {
    await LoginHistoryManager().refreshHistory();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    _onFinishClick() async {
      var uri = Uri.parse(inputUrl);
      if (!uri.hasScheme) {
        inputUrl = "http://" + inputUrl;
      }
      if (!uri.hasPort) {
        inputUrl += ":8999";
      }
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("apiUrl", inputUrl);
      await ApplicationConfig().loadConfig();
      // login with account
      var response = await ApiClient().userAuth(inputUsername, inputPassword);
      if (response.success) {
        ApplicationConfig().token = response.token;
        ApplicationConfig().username = inputUsername;
        LoginHistoryManager().add(LoginHistory(
            apiUrl: inputUrl, username: inputUsername, token: response.token));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }

    _onLoginHistoryClick(LoginHistory history) async {
      var config = ApplicationConfig();
      config.token = history.token;
      config.serviceUrl = history.apiUrl;
      config.username = history.username;
      BaseResponse response = await ApiClient().checkToken(history.token);
      if (response.success) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("user auth failed: ${response.reason}")));
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          _onFinishClick();
        },
        child: Icon(Icons.chevron_right,color: Colors.white,),
      ),
      body: FutureBuilder(
          future: _init(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(),
                        child: Text(
                          "YouPlus",
                          style: TextStyle(
                            fontSize: 48,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 72),
                        child: Text(
                          "from ProjectXPolaris",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Expanded(
                          child: DefaultTabController(
                        length: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 240,
                              margin: EdgeInsets.only(bottom: 16),
                              child: TabBar(
                                  tabs: [
                                Tab(
                                  child: Text(
                                    "History",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ),
                                Tab(
                                  child: Text("New",
                                      style: TextStyle(color: Colors.black87)),
                                )
                              ],indicatorColor: Colors.green,),
                            ),
                            Expanded(
                                child: TabBarView(
                              children: [
                                ListView(
                                  children:
                                      LoginHistoryManager().list.map((history) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      child: ListTile(
                                        onTap: () {
                                          _onLoginHistoryClick(history);
                                        },
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.green.shade800,
                                          child: Icon(Icons.person,color: Colors.white,),
                                        ),
                                        title: Text(history.username),
                                        subtitle: Text(history.apiUrl),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                ListView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 16,left: 16),
                                      child: TextField(
                                        onChanged: (text) {
                                          setState(() {
                                            inputUrl = text;
                                          });
                                        },
                                        cursorColor: Colors.green,
                                        decoration: InputDecoration(
                                          hintText: "Service URL"
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16,right: 16,left: 16),
                                      child: TextField(
                                        onChanged: (text) {
                                          setState(() {
                                            inputUsername = text;
                                          });
                                        },
                                        cursorColor: Colors.green,
                                        decoration: InputDecoration(
                                            hintText: "Username"
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16,right: 16,left: 16),
                                      child: TextField(
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        obscureText: true,
                                        onChanged: (text) {
                                          setState(() {
                                            inputPassword = text;
                                          });
                                        },
                                        cursorColor: Colors.green,
                                        decoration: InputDecoration(
                                            hintText: "Password"
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ))
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              );
            }
            return Container();
          }),
    );
  }
}
