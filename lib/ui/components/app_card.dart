import 'package:flutter/material.dart';

class AppCard extends StatefulWidget {
  final String name;
  final String status;
  final Function onStop;
  final Function onStart;
  const AppCard({Key? key,required this.name,required this.status,required this.onStop,required this.onStart}) : super(key: key);
  @override
  _AppCardState createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Icon(Icons.apps),
                ),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      Text("Service")
                    ])),
                PopupMenuButton<String>(
                  onSelected: (String result) { setState(() {  }); },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: "start",
                      child: Text('Start'),
                    ),
                    const PopupMenuItem<String>(
                      value: "stop",
                      child: Text('Stop'),
                    ),
                  ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Text(
                widget.status,
                style: TextStyle(color: Colors.black87, fontSize: 22),
              ),
            )
          ],
        ),
      ),
    );
  }
}
