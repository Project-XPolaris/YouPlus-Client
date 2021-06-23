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
          return Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Text(
                          "My NAS",
                          style: TextStyle(
                              color: Color(0xff2a2a2a),
                              fontWeight: FontWeight.w300,
                              fontSize: 32),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Text(
                          provider.deviceInfo?.hostname ?? "Unknown",
                          style: TextStyle(
                              color: Color(0xff2a2a2a),
                              fontWeight: FontWeight.w300,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1,),
                EntryItem(
                  icon: Icon(
                    Icons.apps,
                    size: 32,
                    color: Colors.teal,
                  ),
                  primary: "Apps",
                  desc: "${provider.nasInfo?.appCount ?? 0} apps installed",
                  onClick: (){

                  },
                ),
                Divider(height: 1,),
                EntryItem(
                  icon: Icon(
                    Icons.person,
                    size: 32,
                    color: Colors.blue,
                  ),
                  primary: "Users",
                  desc: "${provider.nasInfo?.userCount ?? 0} users",
                ),
                Divider(height: 1,),
                EntryItem(
                    icon: Icon(
                      Icons.storage,
                      size: 32,
                      color: Colors.green,
                    ),
                    primary: "Storage",
                    desc: "${provider.nasInfo?.storageCount ?? 0} storage"),
                Divider(height: 1,),
                EntryItem(
                    icon: Icon(
                      Icons.dns,
                      size: 32,
                      color: Colors.red,
                    ),
                    primary: "ZFS",
                    desc: "${provider.nasInfo?.zfsCount ?? 0} zfs pool"),
                Divider(height: 1,),
                EntryItem(
                    icon: Icon(
                      Icons.data_usage,
                      size: 32,
                      color: Colors.indigo,
                    ),
                    primary: "Disks",
                    desc: "${provider.nasInfo?.diskCount ?? 0} disks"),
                Divider(height: 1,),
                EntryItem(
                    icon: Icon(
                      Icons.folder,
                      size: 32,
                      color: Colors.pink,
                    ),
                    primary: "Share folder",
                    desc: "${provider.nasInfo?.shareFolderCount ?? 0} share folders")
              ],
            ),
          );
        }));
  }
}

class EntryItem extends StatelessWidget {
  final Icon icon;
  final String primary;
  final String desc;
  final Function()? onClick;
  const EntryItem(
      {Key? key, required this.icon, required this.primary, required this.desc,this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                child: icon,
                margin: EdgeInsets.only(right: 16),
              ),
              Expanded(
                  child: Text(
                primary,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              )),
              Text(
                desc,
                style: TextStyle(color: Colors.black54),
              )
            ],
          ),
        ),
      ),
    );
  }
}
