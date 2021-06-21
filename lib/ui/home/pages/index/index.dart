import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youplus/ui/components/info_card.dart';
import 'package:youplus/ui/home/pages/index/provider.dart';

class HomeIndex extends StatefulWidget {
  const HomeIndex({Key? key}) : super(key: key);

  @override
  _HomeIndexState createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeIndexProvider>(
        create: (_) => HomeIndexProvider(),
        child: Consumer<HomeIndexProvider>(builder: (context, provider, child) {
          provider.refreshDeviceInfo();
          Size size = MediaQuery.of(context).size;
          _renderDeviceInfo(){
            var info = provider.deviceInfo;
            if (info != null) {
             return Wrap(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: 72, maxWidth: 240, minHeight: 72
                    ),
                    child: InfoCard(
                      label: "Hostname",
                      value: info.hostname,
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: 72, maxWidth: 240, minHeight: 72
                    ),
                    child: InfoCard(
                      label: "Board",
                      value: info.board,
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: 72, maxWidth: 240, minHeight: 72),
                    child: InfoCard(
                      label: "CPU",
                      value: info.cpu,
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: 72, maxWidth: 240, minHeight: 72),
                    child: InfoCard(
                      label: "OS",
                      value: info.os,
                    ),
                  ),
                ],
              );
            }
            return Container();
          }
          return Container(
            color: Color(0xFFEEEEEE),
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Overview",
                    style: TextStyle(
                        color: Color(0xff2a2a2a),
                        fontWeight: FontWeight.w300,
                        fontSize: 32),
                  ),
                ),
               _renderDeviceInfo()
              ],
            ),
          );

        }));
  }
}
