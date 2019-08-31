import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'package:danceframe_et/widgets/DanceframeFormContainerPhoto.dart';
import 'package:danceframe_et/widgets/linear_percent_indicator.dart';
import 'package:danceframe_et/widgets/ComponentCheckbox.dart';

class critique_sheet_2 extends StatefulWidget {
  @override
  _critique_sheet_2State createState() => new _critique_sheet_2State();
}

class _critique_sheet_2State extends State<critique_sheet_2> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new DanceframeAppBar(
          height: 100.0,
          mode: "TITLE",
          bg: true,
          hasBorder: false,
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
                    flex: 3.0,
                    background: Colors.white,
                    headingText: "Judge: MARIA FOLSON",
                    child: new Container(
                      margin: EdgeInsets.only(left: 40.0, right: 40.0, bottom: 20.0, top: 54.0),
                      //color: Colors.amber,
                      child: new Column(
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              new Text("Heat 123: American Waltz", style: new TextStyle(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w700
                              )),
                              new Padding(
                                  padding: EdgeInsets.only(left: 60.0, top: 5.0),
                                  child: new LinearPercentIndicator(
                                    width: 180.0,
                                    animation: true,
                                    lineHeight: 12.0,
                                    animationDuration: 2500,
                                    percent: 1,
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Colors.lightGreenAccent,
                                  )
                              ),
                            ],
                          ),
                          new Padding(
                            padding: EdgeInsets.only(top: 0.0, bottom: 5.0),
                            child: new Divider(
                              color: Colors.grey,
                            ),
                          ),
                          new Row(
                            children: <Widget>[
                              new Text("For this you have been assigned 2 Critique Sheets", style: new TextStyle(
                                fontSize: 24.0,
                              )),
                            ],
                          ),
                          new Padding(padding: EdgeInsets.only(top: 20.0)),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                width: 180.0,
                                height: 100.0,
                                child: new Column(
                                  children: <Widget>[
                                    new Expanded(
                                        child: Container(
                                          decoration: new BoxDecoration(
                                              borderRadius: BorderRadius.circular(5.0),
                                              color: Color(0xFF2e4c5e)
                                          ),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(5.0),
                                          child: new Wrap(
                                            alignment: WrapAlignment.center,
                                            children: <Widget>[
                                              new RichText(
                                                text: TextSpan(
                                                    style: new TextStyle(
                                                      fontSize: 25.0,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    text: "Critique Couple 146"
                                                ),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                        )
                                    ),
                                    new Container(
                                      alignment: Alignment.center,
                                      child: Text("Intermediate Bronze", style: new TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold
                                      )),
                                    )
                                  ],
                                ),
                              ),
                              new Padding(padding: EdgeInsets.only(left: 30.0)),
                              new Container(
                                width: 180.0,
                                height: 100.0,
                                child: new Column(
                                  children: <Widget>[
                                    new Expanded(
                                        child: Container(
                                          decoration: new BoxDecoration(
                                              borderRadius: BorderRadius.circular(5.0),
                                              color: Color(0xFF2e4c5e)
                                          ),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(5.0),
                                          child: new Wrap(
                                            alignment: WrapAlignment.center,
                                            children: <Widget>[
                                              new RichText(
                                                text: TextSpan(
                                                    style: new TextStyle(
                                                      fontSize: 25.0,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    text: "Critique Couple 576"
                                                ),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                        )
                                    ),
                                    new Container(
                                      alignment: Alignment.center,
                                      child: Text("Full Bronze", style: new TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold
                                      )),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          new Divider(
                            color: Colors.grey,
                          ),
                          new Center(
                            child: new Text("COUPLE 576 - Full Bronze", style: new TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold
                            )),
                          ),
                          new Center(
                            child: new Text("We Loved", style: new TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                            )),
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(
                                    decoration: new BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.black, width: 3.0))
                                    ),
                                    padding: EdgeInsets.only(bottom: 2.0, left: 2.0, right: 2.0),
                                    child: new Text("Technical Components", style: new TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold
                                    )),
                                  ),
                                  new Padding(padding: EdgeInsets.only(top: 5.0)),
                                  new ComponentCheckbox(
                                    text: "Posture",
                                  ),
                                  new ComponentCheckbox(
                                    text: "Footwork",
                                  ),
                                  new ComponentCheckbox(
                                    text: "Timing",
                                  ),
                                ],
                              ),
                              new Padding(padding: EdgeInsets.only(left: 20.0)),
                              new Column(
                                children: <Widget>[
                                  new Container(
                                    decoration: new BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.black, width: 3.0))
                                    ),
                                    padding: EdgeInsets.only(bottom: 5.0, left: 10.0, right: 10.0),
                                    child: new Text("Artistic Components", style: new TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold
                                    )),
                                  ),
                                  new Padding(padding: EdgeInsets.only(top: 5.0)),
                                  new ComponentCheckbox(
                                    text: "Floor Craft",
                                  ),
                                  new ComponentCheckbox(
                                    text: "Partnering",
                                  ),
                                  new ComponentCheckbox(
                                    text: "Showmanship",
                                  ),
                                ],
                              )
                            ],
                          ),
                          new Center(
                            child: new Text("Keep Improving", style: new TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                            )),
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(
                                    decoration: new BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.black, width: 3.0))
                                    ),
                                    padding: EdgeInsets.only(bottom: 2.0, left: 2.0, right: 2.0),
                                    child: new Text("Technical Components", style: new TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold
                                    )),
                                  ),
                                  new Padding(padding: EdgeInsets.only(top: 5.0)),
                                  new ComponentCheckbox(
                                    text: "Posture",
                                  ),
                                  new ComponentCheckbox(
                                    text: "Footwork",
                                  ),
                                  new ComponentCheckbox(
                                    text: "Timing",
                                  ),
                                ],
                              ),
                              new Padding(padding: EdgeInsets.only(left: 20.0)),
                              new Column(
                                children: <Widget>[
                                  new Container(
                                    decoration: new BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.black, width: 3.0))
                                    ),
                                    padding: EdgeInsets.only(bottom: 5.0, left: 10.0, right: 10.0),
                                    child: new Text("Artistic Components", style: new TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold
                                    )),
                                  ),
                                  new Padding(padding: EdgeInsets.only(top: 5.0)),
                                  new ComponentCheckbox(
                                    text: "Floor Craft",
                                  ),
                                  new ComponentCheckbox(
                                    text: "Partnering",
                                  ),
                                  new ComponentCheckbox(
                                    text: "Showmanship",
                                  ),
                                ],
                              )
                            ],
                          ),
                          new Padding(
                            padding: EdgeInsets.only(top: 2.0, bottom: 5.0),
                          ),
                          new Expanded(
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Expanded(
                                    child: Container(
                                      decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.circular(8.0),
                                          border: Border.all(color: Colors.black)
                                      ),
                                      padding: EdgeInsets.all(5.0),
                                      margin: EdgeInsets.only(right: 10.0),
                                      child: new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Container(
                                            padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 2.0, bottom: 2.0),
                                            child: new Text("Additional Feedback", style: new TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold
                                            )),
                                          )
                                        ],
                                      ),
                                    ),
                                    flex: 3,
                                  ),
                                  new Expanded(
                                    child: Container(
                                      child: new Column(
                                        children: <Widget>[
                                          new Expanded(
                                              child: Container(
                                                margin: EdgeInsets.only(left: 5.0, right: 5.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    border: Border.all(color: Colors.black)
                                                ),
                                              )
                                          ),
                                          new Text("Initials", style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                                          new DanceFrameButton(
                                            onPressed: () {
                                              Navigator.pushNamed(context, "/contactUs");
                                            },
                                            text: "Done",
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                          )
                        ],
                      ),
                    )
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