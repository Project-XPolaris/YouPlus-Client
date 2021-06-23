import 'package:flutter/material.dart';

class FolderCard extends StatefulWidget {
  final  String name;
  FolderCard({Key? key,required this.name}) : super(key: key);

  @override
  _FolderCardState createState() => _FolderCardState();
}

class _FolderCardState extends State<FolderCard> {
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
                  backgroundColor: Colors.green.shade700,
                  child: Icon(Icons.folder,color: Colors.white,),
                ),
                Expanded(
                    child: Container(
                        child: Text(widget.name),
                        margin: EdgeInsets.only(left: 16)))
              ],
            )
          ],
        ),
      ),
    );
  }
}
