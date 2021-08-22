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
          onStartApp(int id) async {
            BaseResponse response = await provider.startApp(id);
            if (response.success) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("start app success")));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("start app failed: ${response.reason}")));
            }
          }

          onStopApp(int id) async {
            BaseResponse response = await provider.stopApp(id);
            if (response.success) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("stop app success")));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("stop app failed: ${response.reason}")));
            }
          }

          List<Widget> _renderCards() {
            if (size.width < 650) {
              return [
                ...provider.apps.map((app) => ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.apps,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green.shade700,
                      ),
                      title: Text(app.name),
                      subtitle: Text(app.status),
                      trailing: PopupMenuButton<String>(
                        onSelected: (String result) {
                          if (result == "start") {
                            onStartApp(app.id);
                          }
                          if (result == "stop") {
                            onStopApp(app.id);
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: "start",
                            child: Text('Start'),
                          ),
                          const PopupMenuItem<String>(
                            value: "stop",
                            child: Text('Stop'),
                          ),
                        ],
                      ),
                    ))
              ];
            }
            return [
              Container(
                padding: EdgeInsets.all(16),
                child: Wrap(
                  children: [
                    ...provider.apps
                        .map((app) => ConstrainedBox(
                              constraints: BoxConstraints(
                                  minWidth: 120, maxWidth: 320, minHeight: 72),
                              child: AppCard(
                                onStart: () => onStartApp(app.id),
                                onStop: () => onStopApp(app.id),
                                name: app.name,
                                status: app.status,
                                id: app.id,
                              ),
                            ))
                        .toList()
                  ],
                ),
              )
            ];
          }

          return RefreshIndicator(
            onRefresh: () async {
              provider.refreshApps(force: true);
            },
            child: Container(
              color: size.width < 650 ? Colors.white : Color(0xFFEEEEEE),
              width: double.infinity,
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  Container(
                    margin: EdgeInsets.all(16),
                    child: Text(
                      "Apps",
                      style: TextStyle(
                          color: Color(0xff2a2a2a),
                          fontWeight: FontWeight.w300,
                          fontSize: 32),
                    ),
                  ),
                  ..._renderCards()
                ],
              ),
            ),
          );
        }));
  }
}
