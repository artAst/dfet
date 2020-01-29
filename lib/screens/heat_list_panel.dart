import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'package:danceframe_et/widgets/DanceframeFormContainer.dart';

class heat_list_panel extends StatefulWidget {
  @override
  _heat_list_panelState createState() => new _heat_list_panelState();
}

class _heat_list_panelState extends State<heat_list_panel> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new DanceframeAppBar(
          height: 150.0,
          mode: "TITLE",
          //headerText: "SELECT ACTION MODE",
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
                  alignment: Alignment.topLeft,
                  marginRight: 140.0,
                  marginLeft: 140.0,
                  marginBottom: 100.0,
                  flex: 3.0,
                  background: Colors.white,
                  headingText: "Judge: MARIA FOLSON",
                ),
//                child: new DanceFrameButton(
//                  text: "SAVE",
//                ),
              ),
              new Container(
                decoration: new BoxDecoration(
                    border: new Border(
                        top: BorderSide(color: Colors.black)
                    )
                ),
                height: 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text("Powered By: ", style: new TextStyle(fontSize: 16.0)),
                    new Padding(padding: const EdgeInsets.only(top: 5.0)),
                    new Image.asset("assets/images/Asset_43_4x.png", height: 25.0)
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}