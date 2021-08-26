import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool isAuthMode = false;
  static const _methodMessageChannel = MethodChannel("authplugin");

  Future<bool> _init() async {
    await LoginHistoryManager().refreshHistory();
    isAuthMode = await _methodMessageChannel.invokeMethod("isAuthMode");
    return true;
  }

  @override
  Widget build(BuildContext context) {
    bool _applyUrl() {
      if (inputUrl.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("please input service url")));
        return false;
      }
      Uri uri;
      try {
        uri = Uri.parse(inputUrl);
      } on FormatException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("input service url invalidate")));
        return false;
      }
      String uriString = inputUrl;
      if (!uri.hasScheme) {
        uriString = "http://" + inputUrl;
      }
      if (!uri.hasPort) {
        uriString += ":8999";
      }
      ApplicationConfig().serviceUrl = uriString;
      return true;
    }

    _appAuth(String username, String token) {
      _methodMessageChannel
          .invokeMethod("authApp", {"username": username, "token": token});
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }

    _onFinishClick() async {
      if (!_applyUrl()) {
        return;
      }
      print(ApplicationConfig().serviceUrl);
      // login with account
      var response = await ApiClient().userAuth(inputUsername, inputPassword);
      if (response.success) {
        ApplicationConfig().token = response.token;
        ApplicationConfig().username = inputUsername;
        LoginHistoryManager().add(LoginHistory(
            apiUrl: inputUrl, username: inputUsername, token: response.token!));
        if (isAuthMode) {
          _appAuth(inputUsername, response.token!);
          return;
        }
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("login failed:${response.reason}")));
      }
    }

    _onLoginHistoryClick(LoginHistory history) async {
      var config = ApplicationConfig();
      config.token = history.token;
      config.serviceUrl = history.apiUrl;
      config.username = history.username;
      BaseResponse response =
          await ApiClient().checkToken(history.token + "1234");
      if (response.success) {
        if (isAuthMode) {
          _appAuth(history.username, history.token);
          return;
        }
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
                          style: TextStyle(
                              fontSize: 12,
                              color:
                                  isAuthMode ? Colors.green : Colors.black87),
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
                                        style:
                                            TextStyle(color: Colors.black87)),
                                  )
                                ],
                                indicatorColor: Colors.green,
                              ),
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
                                          backgroundColor:
                                              Colors.green.shade800,
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
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
                                      padding: const EdgeInsets.only(
                                          right: 16, left: 16, top: 16),
                                      child: TextField(
                                        onChanged: (text) {
                                          setState(() {
                                            inputUrl = text;
                                          });
                                        },
                                        cursorColor: Colors.green,
                                        decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green,
                                                  width: 1.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black12,
                                                  width: 1.0),
                                            ),
                                            labelText: "URL",
                                            labelStyle: TextStyle(
                                                color: Colors.black54)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16, right: 16, left: 16),
                                      child: TextField(
                                        onChanged: (text) {
                                          setState(() {
                                            inputUsername = text;
                                          });
                                        },
                                        cursorColor: Colors.green,
                                        decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green,
                                                  width: 1.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black12,
                                                  width: 1.0),
                                            ),
                                            labelText: "Username",
                                            labelStyle: TextStyle(
                                                color: Colors.black54)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16, right: 16, left: 16),
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
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green,
                                                  width: 1.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black12,
                                                  width: 1.0),
                                            ),
                                            labelText: "Password",
                                            labelStyle: TextStyle(
                                                color: Colors.black54)),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(
                                          top: 16, right: 16, left: 16),
                                      child: ElevatedButton(
                                        child: Text("Login"),
                                        onPressed: _onFinishClick,
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
