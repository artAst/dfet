import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'package:danceframe_et/widgets/DanceframeFormContainer.dart';

class signing_initials extends StatefulWidget {
  @override
  _signing_initialsState createState() => new _signing_initialsState();
}

class _signing_initialsState extends State<signing_initials> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new DanceframeAppBar(
          height: 120.0,
          mode: "TITLE",
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
                  marginBottom: 150.0,
                  flex: 4.0,
                  headingHeight: 40.0,
                  containerMarginTop: 25.0,
                  background: Colors.white,
                  headingText: "MARIA FOLSON",
                  child: new Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                    //color: Colors.amber,
                    child: new Column(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            //color: Colors.blue,
                            margin: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: new Column(
                              children: <Widget>[
                                new RichText(
                                  text: TextSpan(
                                      text: "To save your time signing your initials on every score sheets, please enter your initials inside the boxes four times. We will random select for each score sheet for you",
                                      style: new TextStyle(fontSize: 24.0, color: Colors.black)
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                new Padding(padding: EdgeInsets.only(top: 30.0)),
                                new RichText(
                                  text: TextSpan(
                                      text: "Enter each one inside the boxes and at slightly different angles.",
                                      style: new TextStyle(fontSize: 24.0, color: Colors.black)
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            )
                          ),
                          flex: 3,
                        ),
                        new Expanded(
                          child: Container(
                            //color: Colors.amber,
                            child: new Stack(
                              children: <Widget>[
                                new Positioned(
                                  top: 30.0,
                                  left: 40.0,
                                  child: new Column(
                                    children: <Widget>[
                                      new Container(
                                        decoration: BoxDecoration(
                                            border: Border.all()
                                        ),
                                        height: 100.0,
                                        width: 100.0,
                                      ),
                                      new Text("Initials 1", style: TextStyle(fontSize: 17.0))
                                    ],
                                  )
                                ),
                                new Positioned(
                                    top: 10.0,
                                    left: 175.0,
                                    child: Transform.rotate(
                                      angle: -0.2,
                                      child: new Column(
                                        children: <Widget>[
                                          new Container(
                                            decoration: BoxDecoration(
                                                border: Border.all()
                                            ),
                                            height: 100.0,
                                            width: 100.0,
                                          ),
                                          new Text("Initials 2", style: TextStyle(fontSize: 17.0))
                                        ],
                                      )
                                    )
                                ),
                                new Positioned(
                                    top: 30.0,
                                    left: 310.0,
                                    child: new Column(
                                      children: <Widget>[
                                        new Container(
                                          decoration: BoxDecoration(
                                              border: Border.all()
                                          ),
                                          height: 100.0,
                                          width: 100.0,
                                        ),
                                        new Text("Initials 3", style: TextStyle(fontSize: 17.0))
                                      ],
                                    )
                                ),
                                new Positioned(
                                    bottom: 20.0,
                                    left: 100.0,
                                    child: Transform.rotate(
                                      angle: 0.2,
                                      child: new Column(
                                        children: <Widget>[
                                          new Container(
                                            decoration: BoxDecoration(
                                                border: Border.all()
                                            ),
                                            height: 100.0,
                                            width: 100.0,
                                          ),
                                          new Text("Initials 4", style: TextStyle(fontSize: 17.0))
                                        ],
                                      )
                                    )
                                ),
                                new Positioned(
                                    bottom: 20.0,
                                    left: 240.0,
                                    child: Transform.rotate(
                                        angle: -0.3,
                                        child: new Column(
                                          children: <Widget>[
                                            new Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all()
                                              ),
                                              height: 100.0,
                                              width: 100.0,
                                            ),
                                            new Text("Initials 5", style: TextStyle(fontSize: 17.0))
                                          ],
                                        )
                                    )
                                ),
                              ],
                            ),
                          ),
                          flex: 4,
                        ),
                        new Container(
                          height: 45.0,
                          child: new Row(
                            children: <Widget>[
                              new DanceFrameButton(text: "CANCEL"),
                              new Expanded(child: Container()),
                              new DanceFrameButton(
                                onPressed: () => Navigator.pushNamed(context, "/newJudge"),
                                text: "SAVE"
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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