import 'package:flutter/material.dart';

class FolderCard extends StatefulWidget {
  const FolderCard({Key? key}) : super(key: key);

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
                  child: Icon(Icons.folder),
                ),
                Expanded(
                    child: Container(
                        child: Text("Folder name"),
                        margin: EdgeInsets.only(left: 16)))
              ],
            )
          ],
        ),
      ),
    );
  }
}
