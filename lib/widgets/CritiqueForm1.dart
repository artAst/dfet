import 'dart:async';
import 'package:flutter/material.dart';
import 'package:danceframe_et/model/Heat.dart';
import 'package:danceframe_et/widgets/Painter.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'package:danceframe_et/dao/CritiqueDao.dart';
import 'package:danceframe_et/model/Judge.dart';

class CritiqueForm1 extends StatefulWidget {
  HeatInfo heat_info;
  Judge judge;
  String coupleName;
  VoidCallback donePressed;
  String categoryType;

  // form data
  PainterController techniqueP;
  PainterController feedbackP;
  PainterController musicalityP;
  PainterController presentationP;
  PainterController partneringP;

  CritiqueForm1({this.heat_info, this.judge, this.coupleName, this.categoryType, this.donePressed, this.techniqueP, this.feedbackP, this.musicalityP, this.presentationP, this.partneringP});

  @override
  _CritiqueForm1State createState() => new _CritiqueForm1State();
}

class _CritiqueForm1State extends State<CritiqueForm1> {
  CritiqueData1 critique;

  Timer saveTimer_tech;
  Timer saveTimer_music;
  Timer saveTimer_part;
  Timer saveTimer_pres;
  Timer saveTimer_feed;

  String filename_tech;
  String filename_music;
  String filename_part;
  String filename_pres;
  String filename_feed;

  @override
  void initState() {
    super.initState();
    /*techniqueP = _newController();
    musicalityP = _newController();
    feedbackP = _newController();
    presentationP = _newController();
    partneringP = _newController();*/
    critique = new CritiqueData1();
  }

  PainterController _newController() {
    PainterController controller = new PainterController();

    controller.thickness = 2.0;

    controller.backgroundColor = Colors.white;
    return controller;
  }

  void saveImg(pt, filename, componentTitle, isSaveData) {
    print("timer_${componentTitle}: [${filename}_${componentTitle}] Saving...");
    pt.partial("${filename}_${componentTitle}");

    if(isSaveData) {
      saveData();
    }
  }

  void saveData() {
    if(filename_tech != null) {
      critique.technique = filename_tech;
    }
    if(filename_music != null) {
      critique.musicality = filename_music;
    }
    if(filename_part != null) {
      critique.partnering_skill = filename_part;
    }
    if(filename_pres != null) {
      critique.presentation = filename_pres;
    }
    if(filename_feed != null) {
      critique.feedback = filename_feed;
    }

    if(critique.id == null) {
      CritiqueDao.saveCritique(critique, 1).then((id) {
        critique.id = id.toString();
      });
    } else {
      CritiqueDao.updateCritique(critique.id, critique, 1);
    }
  }

  void saveState(PainterController pt, coupleName, String componentTitle) {
    // save state changes during user ui input
    String filename = "${widget.judge.first_name}_${widget.judge.last_name}_heat${widget.heat_info.heat_number}_couple${coupleName}";

    switch(componentTitle) {
      case "technique":
        if(saveTimer_tech != null) saveTimer_tech.cancel();
        saveTimer_tech = new Timer(Duration(seconds: 2), () {
          bool isSaveData = filename_tech == null ? true : false;
          filename_tech = "${filename}_${componentTitle}";
          saveImg(pt, filename, componentTitle, isSaveData);
        });
        break;
      case "musicality":
        if(saveTimer_music != null) saveTimer_music.cancel();
        saveTimer_music = new Timer(Duration(seconds: 2), () {
          bool isSaveData = filename_music == null ? true : false;
          filename_music = "${filename}_${componentTitle}";
          saveImg(pt, filename, componentTitle, isSaveData);
        });
        break;
      case "partnering":
        if(saveTimer_part != null) saveTimer_part.cancel();
        saveTimer_part = new Timer(Duration(seconds: 2), () {
          bool isSaveData = filename_part == null ? true : false;
          filename_part = "${filename}_${componentTitle}";
          saveImg(pt, filename, componentTitle, isSaveData);
        });
        break;
      case "presentation":
        if(saveTimer_pres != null) saveTimer_pres.cancel();
        saveTimer_pres = new Timer(Duration(seconds: 2), () {
          bool isSaveData = filename_pres == null ? true : false;
          filename_pres = "${filename}_${componentTitle}";
          saveImg(pt, filename, componentTitle, isSaveData);
        });
        break;
      case "feedback":
        if(saveTimer_feed != null) saveTimer_feed.cancel();
        saveTimer_feed = new Timer(Duration(seconds: 2), () {
          bool isSaveData = filename_feed == null ? true : false;
          filename_feed = "${filename}_${componentTitle}";
          saveImg(pt, filename, componentTitle, isSaveData);
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
          child: new Divider(
            color: Colors.grey,
          ),
        ),
        new Center(
          child: new Text("COUPLE ${widget.coupleName} - ${widget.categoryType}", style: new TextStyle(
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
                      child: new Painter(widget.techniqueP, onChanged: (){
                        // save technique painter
                        saveState(widget.techniqueP, widget.coupleName, "technique");
                      }),
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
                      child: new Painter(widget.musicalityP, onChanged: (){
                        // save technique painter
                        saveState(widget.musicalityP, widget.coupleName, "musicality");
                      }),
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
                      child: new Painter(widget.partneringP, onChanged: (){
                        // save technique painter
                        saveState(widget.partneringP, widget.coupleName, "partnering");
                      }),
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
                      child: new Painter(widget.presentationP, onChanged: (){
                        // save technique painter
                        saveState(widget.presentationP, widget.coupleName, "presentation");
                      }),
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
                          child: new Painter(widget.feedbackP, onChanged: (){
                            // save technique painter
                            saveState(widget.feedbackP, widget.coupleName, "feedback");
                          }),
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
                          onPressed: () => Function.apply(widget.donePressed, []),
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
}