import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
          Size size = MediaQuery.of(context).size;
          _renderCards(){
            if (size.width < 650) {
              return [...List.generate(20, (index) => AppCard(
                onStart: (){},
                onStop: (){},
                name: "AppName",
                status: "Running",
              ),
              )];
            }
            return List.generate(20, (index) => ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: 120, maxWidth: 320, minHeight: 72
              ),
              child:  AppCard(
                onStart: (){},
                onStop: (){},
                name: "AppName",
                status: "Running",
              ),
            )).toList();
          }
          return Container(
            color: Color(0xFFEEEEEE),
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            child: ListView(
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
          );
        }));
  }
}
