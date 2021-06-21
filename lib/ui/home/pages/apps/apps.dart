import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youplus/api/base.dart';
import 'package:youplus/ui/components/app_card.dart';
import 'package:youplus/ui/home/pages/apps/provider.dart';

class HomeApps extends StatefulWidget {
  const HomeApps({Key? key}) : super(key: key);

  @override
  _HomeAppsState createState() => _HomeAppsState();
}

class _HomeAppsState extends State<HomeApps> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeAppsProvider>(
        create: (_) => HomeAppsProvider(),
        child: Consumer<HomeAppsProvider>(builder: (context, provider, child) {
          provider.refreshApps();
          Size size = MediaQuery.of(context).size;
          onStartApp(String id) async {
            BaseResponse response = await provider.startApp(id);
            if (response.success) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("start app success")));
            }else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("start app failed: ${response.reason}")));
            }
          }
          onStopApp(String id) async {
            BaseResponse response = await provider.stopApp(id);
            if (response.success) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("stop app success")));
            }else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("stop app failed: ${response.reason}")));
            }
          }
          List<Widget> _renderCards(){
            if (size.width < 650) {
              return [...provider.apps.map((app) => AppCard(
                onStart: () => onStartApp(app.id),
                onStop: () => onStopApp(app.id),
                name: app.name,
                status: app.status,
                id: app.id,
              ),
              )];
            }
            return provider.apps.map((app) =>  ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: 120, maxWidth: 320, minHeight: 72
              ),
              child:  AppCard(
                onStart: () => onStartApp(app.id),
                onStop: () => onStopApp(app.id),
                name: app.name,
                status: app.status,
                id: app.id,
              ),
            )).toList();
          }
          return RefreshIndicator(
            onRefresh: () async{
              provider.refreshApps(force: true);
            },
            child: Container(
              color: Color(0xFFEEEEEE),
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Text(
                      "Apps",
                      style: TextStyle(
                          color: Color(0xff2a2a2a),
                          fontWeight: FontWeight.w300,
                          fontSize: 32),
                    ),
                  ),
                  Wrap(
                    children: [
                      ..._renderCards()
                    ],
                  )
                ],
              ),
            ),
          );
        }));
  }
}
