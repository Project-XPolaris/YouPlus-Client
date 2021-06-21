import 'package:flutter/material.dart';
import 'package:youplus/api/base.dart';
import 'package:youplus/api/client.dart';
import 'package:youplus/ui/start/start.dart';
import 'package:youplus/util/dialog.dart';

class HomeDevicePage extends StatefulWidget {
  const HomeDevicePage({Key? key}) : super(key: key);

  @override
  _HomeDevicePageState createState() => _HomeDevicePageState();
}

class _HomeDevicePageState extends State<HomeDevicePage> {
  @override
  Widget build(BuildContext context) {
    onShutdown(){
      showConfirmDialog(context: context, content: "device will shutdown", onOk: () async {
        BaseResponse  response = await ApiClient().shutdown();
        if (response.success) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("device will shutdown")));
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => StartPage()));
        }else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("shutdown failed: ${response.reason}")));
        }
      });
    }
    onReboot(){
      showConfirmDialog(context: context, content: "device will reboot", onOk: ()async {
        BaseResponse  response = await ApiClient().reboot();
        if (response.success) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("device will reboot")));
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => StartPage()));
        }else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("reboot failed: ${response.reason}")));
        }
      });
    }
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      color: Color(0xFFEEEEEE),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Text(
              "Device",
              style: TextStyle(
                  color: Color(0xff2a2a2a),
                  fontWeight: FontWeight.w300,
                  fontSize: 32),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Text(
              "Actions",
              style: TextStyle(
                  color: Color(0xff2a2a2a),
                  fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 16),
                child: ElevatedButton(child: Text("Shutdown"),onPressed: onShutdown,),
              ),
              Container(
                child: ElevatedButton(child: Text("Reboot"),onPressed: onReboot,),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16,top: 32),
            child: Text(
              "Account",
              style: TextStyle(
                color: Color(0xff2a2a2a),
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(child: Text("Signout"),onPressed: (){
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => StartPage()));
            },),
          ),
        ],
      ),
    );
  }
}
