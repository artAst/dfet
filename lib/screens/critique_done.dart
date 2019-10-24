import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/widgets/DanceframeFormContainer.dart';
import 'package:danceframe_et/widgets/DanceFrameFooter.dart';

class critique_done extends StatefulWidget {
  @override
  _critique_doneState createState() => new _critique_doneState();
}

class _critique_doneState extends State<critique_done> {

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
                      headingText: "CRITIQUE FORM DONE",
                      child: new Align(
                        alignment: Alignment.topCenter,
                        child: new Container(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                          child: new Text("Critique Form Done. Please inform event coordinator. Thanks",
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