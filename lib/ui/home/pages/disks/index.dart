import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youplus/ui/home/pages/disks/provider.dart';

class DiskListPage extends StatefulWidget {
  const DiskListPage({Key? key}) : super(key: key);

  @override
  _DiskListPageState createState() => _DiskListPageState();
}

class _DiskListPageState extends State<DiskListPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DiskListProvider>(
        create: (_) => DiskListProvider(),
        child: Consumer<DiskListProvider>(builder: (context, provider, child) {
          provider.refresh();
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text("Disks"),
            ),
            body: RefreshIndicator(
              onRefresh: ()async{
                await provider.refresh(force: true);
              },
              child: ListView(
                children: provider.disks.map((disk) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green.shade800,
                      child: Icon(Icons.data_usage,color: Colors.white,),
                    ),
                    title: Text(disk.name ?? "Unknown"),
                    subtitle: Text(disk.model ?? "Unknown"),
                  );
                }).toList(),
              ),
            ),
          );
        }));
  }
}
