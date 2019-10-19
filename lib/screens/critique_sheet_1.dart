import 'dart:async';
import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/widgets/DanceframeFormContainerPhoto.dart';
import 'package:danceframe_et/widgets/linear_percent_indicator.dart';
import 'package:danceframe_et/widgets/DanceFramePageSelector.dart';
import 'package:danceframe_et/model/Heat.dart';
import 'package:danceframe_et/dao/HeatDao.dart';
import 'package:danceframe_et/widgets/CritiqueForm1.dart';
import 'critique_sheet_2.dart' as crit2;
import 'package:danceframe_et/widgets/Painter.dart';
import 'package:danceframe_et/util/ScreenUtil.dart';

var judge;
var heats;
var idx;

class critique_sheet_1 extends StatefulWidget {
  @override
  _critique_sheet_1State createState() => new _critique_sheet_1State();
}

class _critique_sheet_1State extends State<critique_sheet_1> {

  HeatInfo heat_info;

  PainterController techniqueP_1;
  PainterController feedbackP_1;
  PainterController musicalityP_1;
  PainterController presentationP_1;
  PainterController partneringP_1;

  PainterController techniqueP_2;
  PainterController feedbackP_2;
  PainterController musicalityP_2;
  PainterController presentationP_2;
  PainterController partneringP_2;

  @override
  void initState() {
    super.initState();

    if(idx == null) {
      idx = 0;
    }

    if(heats != null) {
      print("idx: $idx HEATS[idx]: ${heats[idx].toMap()}");
      /*HeatDao.getHeatInfoById(heats[idx].id.toString()).then((val){
        setState(() {
          print("val = ${val.toMap()}");
          print("assignedcouple length: ${val.assignedCouple.length}");
          heat_info = val;
        });
      });*/
      heat_info = heats[idx];
    }

    techniqueP_1 = _newController();
    musicalityP_1 = _newController();
    feedbackP_1 = _newController();
    presentationP_1 = _newController();
    partneringP_1 = _newController();

    techniqueP_2 = _newController();
    musicalityP_2 = _newController();
    feedbackP_2 = _newController();
    presentationP_2 = _newController();
    partneringP_2 = _newController();
  }

  PainterController _newController() {
    PainterController controller = new PainterController();

    controller.thickness = 2.0;

    controller.backgroundColor = Colors.white;
    return controller;
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
                    headingText: "Judge: ${(judge != null) ? "${judge.first_name.toUpperCase()} ${judge.last_name.toUpperCase()}" : ""}",
                    child: new Container(
                      margin: EdgeInsets.only(left: 40.0, right: 40.0, bottom: 20.0, top: 54.0),
                      //color: Colors.amber,
                      child: new Column(
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              new Text("Heat ${heat_info?.heat_number}: ${heat_info?.heat_title}", style: new TextStyle(
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
                                      tabName: 'Couple ${heat_info.assignedCouple[0]}',
                                      description: '',
                                      demoWidget: new CritiqueForm1(
                                        heat_info: heat_info,
                                        judge: judge,
                                        coupleName: "${heat_info.assignedCouple[0]}",
                                        categoryType: "Intermediate Bronze",
                                        donePressed: (){
                                          if(heats != null && (idx + 1) < heats.length) {
                                            idx += 1;
                                            var _heat = heats[idx];
                                            if(_heat.critiqueSheetType != 1) {
                                              crit2.judge = judge;
                                              crit2.idx = idx;
                                              crit2.heats = heats;
                                              Navigator.popAndPushNamed(context, "/critique2");
                                            } else {
                                              Navigator.popAndPushNamed(context, "/critique1");
                                            }
                                          }
                                          else {
                                            // DONE screen
                                            ScreenUtil.showMainFrameDialog(context, "Critique Form Done", "Please inform event coordinator. Thanks");
                                          }
                                        },
                                        techniqueP: techniqueP_1,
                                        feedbackP: feedbackP_1,
                                        musicalityP: musicalityP_1,
                                        partneringP: partneringP_1,
                                        presentationP: presentationP_1,
                                      ),
                                      loadMoreCallback: (){}
                                  ),
                                  new PageSelectData(
                                      tabName: 'Couple ${heat_info.assignedCouple[1]}',
                                      description: '',
                                      //demoWidget: _buildTabContents("576", _techniquePainter2, _musicalityPainter2, _partneringPainter2, _presentationPainter2, _feedbackPainter2),
                                      demoWidget: new CritiqueForm1(
                                        heat_info: heat_info,
                                        judge: judge,
                                        coupleName: "${heat_info.assignedCouple[1]}",
                                        categoryType: "Full Bronze",
                                        donePressed: (){
                                          if(heats != null && (idx + 1) < heats.length) {
                                            idx += 1;
                                            var _heat = heats[idx];
                                            if(_heat.critiqueSheetType != 1) {
                                              crit2.judge = judge;
                                              crit2.idx = idx;
                                              crit2.heats = heats;
                                              Navigator.popAndPushNamed(context, "/critique2");
                                            } else {
                                              Navigator.popAndPushNamed(context, "/critique1");
                                            }
                                          }
                                          else {
                                            // DONE screen
                                            ScreenUtil.showMainFrameDialog(context, "Critique Form Done", "Please inform event coordinator. Thanks");
                                          }
                                        },
                                        techniqueP: techniqueP_2,
                                        musicalityP: musicalityP_2,
                                        presentationP: presentationP_2,
                                        partneringP: partneringP_2,
                                        feedbackP: feedbackP_2,
                                      ),
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