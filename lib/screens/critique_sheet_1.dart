import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'package:danceframe_et/widgets/DanceframeFormContainerPhoto.dart';
import 'package:danceframe_et/widgets/linear_percent_indicator.dart';
import 'package:danceframe_et/widgets/Painter.dart';
import 'package:danceframe_et/widgets/DanceFramePageSelector.dart';

class critique_sheet_1 extends StatefulWidget {
  @override
  _critique_sheet_1State createState() => new _critique_sheet_1State();
}

class _critique_sheet_1State extends State<critique_sheet_1> {

  PainterController _techniquePainter;
  PainterController _techniquePainter2;
  PainterController _musicalityPainter;
  PainterController _musicalityPainter2;
  PainterController _partneringPainter;
  PainterController _partneringPainter2;
  PainterController _presentationPainter;
  PainterController _presentationPainter2;
  PainterController _feedbackPainter;
  PainterController _feedbackPainter2;

  @override
  void initState() {
    super.initState();
    _techniquePainter = _newController();
    _techniquePainter2 = _newController();
    _musicalityPainter = _newController();
    _musicalityPainter2 = _newController();
    _partneringPainter = _newController();
    _partneringPainter2 = _newController();
    _presentationPainter = _newController();
    _presentationPainter2 = _newController();
    _feedbackPainter = _newController();
    _feedbackPainter2 = _newController();
  }

  PainterController _newController() {
    PainterController controller = new PainterController();

    controller.thickness = 2.0;

    controller.backgroundColor = Colors.white;
    return controller;
  }

  Widget _buildTabContents(String coupleName, techniqueP, musicalityP, partneringP, presentationP, feedbackP) {
    return new Column(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
          child: new Divider(
            color: Colors.grey,
          ),
        ),
        new Center(
          child: new Text("COUPLE $coupleName - Full Bronze", style: new TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold
          )),
        ),
        new Padding(padding: EdgeInsets.only(top: 5.0)),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black, width: 3.0))
              ),
              padding: EdgeInsets.only(bottom: 5.0, left: 10.0, right: 10.0),
              child: new Text("Technical Components", style: new TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
              )),
            ),
            new Padding(padding: EdgeInsets.only(left: 20.0)),
            new Container(
              decoration: new BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black, width: 3.0))
              ),
              padding: EdgeInsets.only(bottom: 5.0, left: 10.0, right: 10.0),
              child: new Text("Artistic Components", style: new TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
              )),
            ),
          ],
        ),
        new Padding(padding: EdgeInsets.only(top: 15.0)),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Container(
              width: 120.0,
              height: 140.0,
              child: new Column(
                children: <Widget>[
                  new Text("Technique", style: new TextStyle(fontSize: 18.0)),
                  new Expanded(
                    child: new Container(
                      margin: EdgeInsets.only(left: 5.0, right: 5.0),
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black, width: 1.5)
                      ),
                      child: new Painter(techniqueP),
                    ),
                  ),
                  new Text("1-10", style: new TextStyle(fontSize: 18.0)),
                ],
              ),
            ),
            new Container(
              width: 120.0,
              height: 140.0,
              child: new Column(
                children: <Widget>[
                  new Text("Musicality", style: new TextStyle(fontSize: 18.0)),
                  new Expanded(
                    child: new Container(
                      margin: EdgeInsets.only(left: 5.0, right: 5.0),
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black, width: 1.5)
                      ),
                      child: new Painter(musicalityP),
                    ),
                  ),
                  new Text("1-10", style: new TextStyle(fontSize: 18.0)),
                ],
              ),
            ),
            new Container(
              width: 120.0,
              height: 140.0,
              child: new Column(
                children: <Widget>[
                  new Text("Partnering Skills", style: new TextStyle(fontSize: 15.6)),
                  new Expanded(
                    child: new Container(
                      margin: EdgeInsets.only(left: 5.0, right: 5.0),
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black, width: 1.5)
                      ),
                      child: new Painter(partneringP),
                    ),
                  ),
                  new Text("1-10", style: new TextStyle(fontSize: 18.0)),
                ],
              ),
            ),
            new Container(
              width: 120.0,
              height: 140.0,
              child: new Column(
                children: <Widget>[
                  new Text("Presentation", style: new TextStyle(fontSize: 18.0)),
                  new Expanded(
                    child: new Container(
                      margin: EdgeInsets.only(left: 5.0, right: 5.0),
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black, width: 1.5)
                      ),
                      child: new Painter(presentationP),
                    ),
                  ),
                  new Text("1-10", style: new TextStyle(fontSize: 18.0)),
                ],
              ),
            ),
          ],
        ),
        new Padding(
          padding: EdgeInsets.only(top: 2.0, bottom: 5.0),
          child: new Divider(
            color: Colors.grey,
          ),
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
                          height: 30.0,
                        ),
                        new Expanded(child: Container(
                          child: new Painter(feedbackP),
                        ))
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
                            Navigator.pushNamed(context, "/critique2");
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
    );
  }

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
                          new Expanded(
                              child: new MFPageSelector(
                                pageWidgets: [
                                  new PageSelectData(
                                      tabName: 'Couple 146',
                                      description: '',
                                      demoWidget: _buildTabContents("146", _techniquePainter, _musicalityPainter, _partneringPainter, _presentationPainter, _feedbackPainter),
                                      loadMoreCallback: (){}
                                  ),
                                  new PageSelectData(
                                      tabName: 'Couple 576',
                                      description: '',
                                      demoWidget: _buildTabContents("576", _techniquePainter2, _musicalityPainter2, _partneringPainter2, _presentationPainter2, _feedbackPainter2),
                                      loadMoreCallback: (){}
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