import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/util/Preferences.dart';
import 'package:danceframe_et/model/Person.dart';
import 'package:danceframe_et/widgets/DanceFrameFooter.dart';
import 'new_judge.dart' as new_judge;
import 'critique_sheet_1.dart' as crit1;
import 'critique_sheet_2.dart' as crit2;
import 'device_mode.dart' as deviceMode;

class personalize_device_empty extends StatefulWidget {
  @override
  _personalize_device_emptyState createState() => new _personalize_device_emptyState();
}

class _personalize_device_emptyState extends State<personalize_device_empty> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Preferences.setSharedValue("currentScreen", "personaliseDeviceEmpty");
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: new DanceframeAppBar(
          height: 150.0,
          mode: "TITLE",
          headerText: "Personalize Device",
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
                child: new Container(
                  margin: const EdgeInsets.only(top: 30.0, bottom: 40.0),
                  child: new Center(
                    /*child: new ListView(
                      children: _personWidgets,
                    ),*/
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