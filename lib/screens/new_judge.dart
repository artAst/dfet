import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'package:danceframe_et/widgets/DanceframeFormContainer.dart';

class new_judge extends StatefulWidget {
  @override
  _new_judgeState createState() => new _new_judgeState();
}

class _new_judgeState extends State<new_judge> {

  String gender = "";

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
                  marginBottom: 220.0,
                  flex: 4.0,
                  headingHeight: 40.0,
                  containerMarginTop: 26.0,
                  background: Colors.white,
                  headingText: "ADD NEW JUDGE",
                  child: new Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                    child: new Column(
                      children: <Widget>[
                        new Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: ExactAssetImage("assets/images/person.png", scale: 0.6),
                                colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.1), BlendMode.dstATop),
                              )
                            ),
                            alignment: Alignment.center,
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                  padding: EdgeInsets.only(left: 40.0, right: 40.0),
                                  child: new TextFormField(
                                    decoration: new InputDecoration(
                                        labelText: "First Name",
                                        labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                                        border: OutlineInputBorder()
                                    ),
                                  ),
                                ),
                                new Container(
                                  padding: EdgeInsets.only(top: 10.0, left: 40.0, right: 40.0),
                                  child: new TextField(
                                    decoration: new InputDecoration(
                                        labelText: "Last Name",
                                        labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                                        border: OutlineInputBorder()
                                    ),
                                  ),
                                ),
                                new Container(
                                  padding: EdgeInsets.only(top: 10.0, left: 40.0, right: 40.0),
                                  child: new Row(
                                    children: <Widget>[
                                      new Expanded(
                                        child: Container(
                                          height: 40.0, 
                                          //color: Colors.amber,
                                          child: new Row(
                                            children: <Widget>[
                                              new Image.asset("assets/images/Asset_2_4x.png"),
                                              new Container(
                                                margin: EdgeInsets.only(left: 5.0, right: 5.0),
                                                child: new Icon(Icons.radio_button_checked)
                                              ),
                                              new Text("Gentleman", style: TextStyle(fontSize: 22.0))
                                            ],
                                          )
                                        ),
                                      ),
                                      new Expanded(
                                        child: Container(
                                          height: 40.0,
                                          //color: Colors.blue,
                                            child: new Row(
                                              children: <Widget>[
                                                new Container(
                                                  margin: EdgeInsets.only(left: 30.0),
                                                  child: new Image.asset("assets/images/Asset_1_4x.png")
                                                ),
                                                new Container(
                                                    margin: EdgeInsets.only(left: 5.0, right: 5.0),
                                                    child: new Icon(Icons.radio_button_unchecked)
                                                ),
                                                new Text("Lady", style: TextStyle(fontSize: 22.0))
                                              ],
                                            )
                                        )
                                      ),
                                    ],
                                  )
                                )
                              ],
                            ),
                          )
                        ),
                        new Container(
                          height: 45.0,
                          child: new Row(
                            children: <Widget>[
                              new DanceFrameButton(text: "CANCEL"),
                              new Expanded(child: Container()),
                              new DanceFrameButton(
                                  onPressed: () => Navigator.pushNamed(context, "/critique1"),
                                  text: "SAVE"
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