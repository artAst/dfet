import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/widgets/DanceframeFormContainer.dart';
import 'package:danceframe_et/widgets/DanceFrameFooter.dart';
import 'package:danceframe_et/websocket/DanceFrameCommunication.dart';
import 'package:danceframe_et/model/Heat.dart';
import 'package:danceframe_et/dao/HeatInfoDao.dart';
import 'package:danceframe_et/model/RequestResponse.dart';

class websocket_conn extends StatefulWidget {
  @override
  _websocket_connState createState() => new _websocket_connState();
}

class _websocket_connState extends State<websocket_conn> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.addListener(_onDanceFrameDataReceived);
  }

  _onDanceFrameDataReceived(message) {
    print("message from widget: $message");
    Map jsonData;
    try {
      jsonData = json.decode(message);
    } catch(err) {
      // send error to websocket malformed json
      //game.send("response", "{\"message\": \"malformed json data\"}");
      RequestResponse res = new RequestResponse(action: "response", status_code: 400, message: "malformed json data");
      game.send(res.action, res.toDataMap().toString());
    }
    HeatSocketData data = new HeatSocketData.fromMap(jsonData);
    if(data.data != null) {
      print("heat_info: ${data.data.toMap()}");
      if(data.action == "append") {
        HeaInfoDao.saveHeatInfo(data.data).then((retVal){
          // send success message to websocket
          RequestResponse res = new RequestResponse(action: "response", status_code: 200, message: "saving heat info success");
          game.send(res.action, res.toDataMap().toString());
        }).catchError((err){
          // send error message to websocket
          RequestResponse res = new RequestResponse(action: "response", status_code: 200, message: "saving heat info failed");
          game.send(res.action, res.toDataMap().toString());
        });
      }
      else if(data.action == "update") {
        HeaInfoDao.updateHeatInfo(data.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: new DanceframeAppBar(
          height: 150.0,
          bg: true,
        ),
        body: new Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [new Color(0xFFD6DFDE), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.01, 0.5]
              )
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Expanded(
                // PUT YOUR CONTENTS HERE in Child property
                  child: new DanceframeFormContainer(
                      alignment: Alignment.topCenter,
                      marginRight: 140.0,
                      marginLeft: 140.0,
                      marginBottom: 380.0,
                      flex: 3.0,
                      headingHeight: 40.0,
                      containerMarginTop: 26.0,
                      background: Colors.white,
                      headingText: "WEBSOCKET CONNECTION",
                      child: new Align(
                        alignment: Alignment.topCenter,
                        child: new Container(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                          child: new Text("Messages from Server:",
                            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
                          )
                        ),
                      ),
                  )
              ),
              new DanceFrameFooter()
            ],
          ),
        )
    );
  }
}