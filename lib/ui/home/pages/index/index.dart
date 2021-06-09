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
          Size size = MediaQuery.of(context).size;
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
                Wrap(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: 72, maxWidth: 240, minHeight: 72
                      ),
                      child: InfoCard(
                        label: "Apps",
                        value: "123",
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: 72, maxWidth: 240, minHeight: 72
                      ),
                      child: InfoCard(
                        label: "Disks",
                        value: "8",
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: 72, maxWidth: 240, minHeight: 72),
                      child: InfoCard(
                        label: "Storage",
                        value: "8",
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: 72, maxWidth: 240, minHeight: 72),
                      child: InfoCard(
                        label: "Folders",
                        value: "8",
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: 72, maxWidth: 240, minHeight: 72),
                      child: InfoCard(
                        label: "Users",
                        value: "8",
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }));
  }
}
