import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youplus/ui/components/folder_card.dart';
import 'package:youplus/ui/home/pages/folder/provider.dart';

class HomeFolder extends StatefulWidget {
  const HomeFolder({Key? key}) : super(key: key);

  @override
  _HomeFolderState createState() => _HomeFolderState();
}

class _HomeFolderState extends State<HomeFolder> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeFolderProvider>(
        create: (_) => HomeFolderProvider(),
        child: Consumer<HomeFolderProvider>(builder: (context, provider, child) {
          Size size = MediaQuery.of(context).size;
          _renderCards(){
            if (size.width < 650) {
              return [...List.generate(20, (index) => FolderCard(

              ),
              )];
            }
            return List.generate(20, (index) => ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: 120, maxWidth: 320, minHeight: 72
              ),
              child:  FolderCard(

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
                    "Folders",
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
