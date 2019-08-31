import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'package:danceframe_et/widgets/DanceframeFormContainer.dart';

class change_device_mode extends StatefulWidget {
  @override
  _change_device_modeState createState() => new _change_device_modeState();
}

class _change_device_modeState extends State<change_device_mode> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                      headingText: "CHANGE DEVICE MODE",
                      child: new Container(
                        margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                        child: new Column(
                          children: <Widget>[
                            new Expanded(
                              child: Container(
                                //color: Colors.amber,
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        new Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5.0),
                                            border: Border.all(),
                                          ),
                                          width: 100.0,
                                          height: 100.0,
                                        ),
                                        new Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5.0),
                                              border: Border.all()
                                          ),
                                          width: 100.0,
                                          height: 100.0,
                                        ),
                                        new Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5.0),
                                              border: Border.all()
                                          ),
                                          width: 100.0,
                                          height: 100.0,
                                        ),
                                      ],
                                    ),
                                    new Container(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text("ACCESS CODE", style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w900
                                      )),
                                    )
                                  ],
                                )
                              )
                            ),
                            new Container(
                              height: 45.0,
                              child: new Row(
                                children: <Widget>[
                                  new DanceFrameButton(text: "CANCEL"),
                                  new Expanded(child: Container()),
                                  new DanceFrameButton(
                                      onPressed: () => Navigator.pushNamed(context, "/contactUs"),
                                      width: 140.0,
                                      text: "CONTINUE"
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                  )
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