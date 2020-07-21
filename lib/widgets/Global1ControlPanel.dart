import 'dart:io';
import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'package:danceframe_et/util/ScreenUtil.dart';

class Global1ControlPanel extends StatefulWidget {
  @override
  _Global1ControlPanelState createState() => new _Global1ControlPanelState();
}

class _Global1ControlPanelState extends State<Global1ControlPanel> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 380.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("GLOBAL RESET", style: TextStyle(fontSize: 30.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700)),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text("Only use this when setting up a new event. All data on all tablets and all data on RPI will be deleted.", textAlign: TextAlign.center, style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w600)),
            Padding(padding: EdgeInsets.only(top: 50.0)),
            new DanceFrameButton(
              text: "RESET",
              onPressed: (){
                ScreenUtil.showWipeDialogWithCancel(context, "Wipe Global Data", "Are you absolutely sure you want to wipe/reset everything for a new competition?").then((val){
                  print("VALUE: $val");
                  if(val.toLowerCase() == "ok") {
                    ScreenUtil.showMainFrameDialog(context, "Wipe Success", "Application will restart. Press ok to Exit").then((val){
                      exit(0);
                    });
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}