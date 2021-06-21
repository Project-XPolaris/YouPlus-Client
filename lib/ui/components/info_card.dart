import 'package:flutter/material.dart';

class InfoCard extends StatefulWidget {
  final String label;
  final String value;
  const InfoCard({Key? key,required this.label,required this.value}) : super(key: key);

  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 96,
        width: double.infinity,
        margin: EdgeInsets.only(right: 16),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.label, style: TextStyle(color: Colors.black54),),
            Text(widget.value, style: TextStyle(color: Colors.black87,fontSize: 18),)
          ],
        ),
      ),
    );
  }
}
