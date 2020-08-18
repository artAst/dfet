import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:danceframe_et/model/config/DeviceConfig.dart';
import 'package:danceframe_et/websocket/DanceFrameCommunication.dart';

class DanceFrameFooter extends StatefulWidget {
  final bool isContactPage;
  DanceFrameFooter({this.isContactPage = false});
  @override
  _DanceFrameFooterState createState() => new _DanceFrameFooterState();
}

class _DanceFrameFooterState extends State<DanceFrameFooter> {
  List<String> deviceInfo = [];
  String deviceId = "";

  @override
  void initState() {
    super.initState();

    game.playerId = DeviceConfig.deviceNum;
    game.addListener(_onMessageRecieved);

    getDeviceDetails().then((value) {
      print("val: ${value.toString()}");
      setState(() {
        deviceInfo.addAll(value);
        deviceId = deviceInfo[2];
      });
    });
  }

  void _onMessageRecieved(e) {
    print("ON MSG RECEIVED: ${e.toMap()}");
  }

  static Future<List<String>> getDeviceDetails() async {
    String deviceName;
    String deviceVersion;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId;  //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor;  //UUID for iOS
      }
    } catch(e) {
      print('Failed to get platform version');
    }

    return [deviceName, deviceVersion, identifier];
  }

  @override
  Widget build(BuildContext context) {

    return new Container(
      decoration: new BoxDecoration(
          border: new Border(
              top: BorderSide(color: Colors.black)
          )
      ),
      height: 40.0,
      child: new Stack(
        children: <Widget>[
          new Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text("Powered By: ", style: new TextStyle(fontSize: 16.0)),
                new Padding(padding: const EdgeInsets.only(top: 5.0)),
                new Image.asset("assets/images/Asset_43_4x.png", height: 25.0),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text("DeviceID [$deviceId]", style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600)),
                )
              ],
            ),
          ),
          widget.isContactPage == false ? new Align(
            alignment: Alignment.centerRight,
            child: new InkWell(
              onTap: (){
                Navigator.pushNamed(context, "/contactUs");
              },
              child: new Container(
                padding: const EdgeInsets.only(right: 20.0, top: 1.0),
                child: new Column(
                  children: <Widget>[
                    new Container(
                      //margin: const EdgeInsets.only(top: 10.0, bottom: 0.0, left: 10.0, right: 10.0),
                      child: new Icon(Icons.feedback, size: 20.0),
                    ),
                    new Text("Contact Us", style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            )
          ) : Container()
        ],
      )
    );
  }
}