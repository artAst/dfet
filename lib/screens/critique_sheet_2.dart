import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/widgets/DanceframeFormContainerPhoto.dart';
import 'package:danceframe_et/widgets/linear_percent_indicator.dart';
import 'package:danceframe_et/widgets/DanceFramePageSelector.dart';
import 'package:danceframe_et/widgets/Painter.dart';
import 'package:danceframe_et/widgets/CritiqueForm2.dart';
import 'package:danceframe_et/model/Heat.dart';
import 'package:danceframe_et/util/ScreenUtil.dart';
import 'package:danceframe_et/widgets/DanceFrameFooter.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'critique_sheet_1.dart' as crit1;
import 'package:danceframe_et/util/LoadContent.dart';

var judge;
var heats;
var idx;

class critique_sheet_2 extends StatefulWidget {
  @override
  _critique_sheet_2State createState() => new _critique_sheet_2State();
}

class _critique_sheet_2State extends State<critique_sheet_2> {
  HeatInfo heat_info;

  PainterController feedbackP_1;
  PainterController feedbackP_2;

  List<String> wl_technical_components_1;
  List<String> wl_artistic_components_1;
  List<String> ki_technical_components_1;
  List<String> ki_artistic_components_1;

  List<String> wl_technical_components_2;
  List<String> wl_artistic_components_2;
  List<String> ki_technical_components_2;
  List<String> ki_artistic_components_2;

  @override
  void initState() {
    super.initState();

    if(idx == null) {
      idx = 0;
    }

    if(heats != null) {
      print("idx: $idx HEATS[idx]: ${heats[idx].toMap()}");
      //heat_info = heats[idx];
      heat_info = null;
    }

    wl_technical_components_1 = [];
    wl_artistic_components_1 = [];
    ki_technical_components_1 = [];
    ki_artistic_components_1 = [];
    feedbackP_1 = _newController();

    wl_technical_components_2 = [];
    wl_artistic_components_2 = [];
    ki_technical_components_2 = [];
    ki_artistic_components_2 = [];
    feedbackP_2 = _newController();

    /*HeatDao.getHeatInfoById("1").then((val){
      setState(() {
        print("val = ${val.toMap()}");
        heat_info = val;
      });
    });*/
    // query heat info
    print("PeopleID: ${judge.id}");
    LoadContent.loadHeatInfoById(heats[idx].id, judge.id).then((_heatInfo){
      setState(() {
        if(_heatInfo != null) {
          heat_info = _heatInfo;
        } else {
          heat_info = null;
        }
      });
    });
  }

  PainterController _newController() {
    PainterController controller = new PainterController();

    controller.thickness = 2.0;

    controller.backgroundColor = Colors.white;
    return controller;
  }

  void changeMode() {
    //Navigator.popUntil(context, ModalRoute.withName("/deviceMode"));
    Navigator.pushNamed(context, "/deviceMode");
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
                    child: (heat_info == null) ? Container() : new Container(
                      margin: EdgeInsets.only(left: 40.0, right: 40.0, bottom: 20.0, top: 4.0),
                      //color: Colors.amber,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new DanceFrameButton(
                            onPressed: changeMode,
                            width: 180.0,
                            text: "Change Mode",
                          ),
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
                                      //demoWidget: _buildTabContents("146", _feedbackPainter),
                                      demoWidget: new CritiqueForm2(
                                        heat_info: heat_info,
                                        judge: judge,
                                        coupleName: "${heat_info.assignedCouple[0]}",
                                        categoryType: "Intermediate Bronze",
                                        feedbackP: feedbackP_1,
                                        wl_technical_components: wl_technical_components_1,
                                        wl_artistic_components: wl_artistic_components_1,
                                        ki_technical_components: ki_technical_components_1,
                                        ki_artistic_components: ki_artistic_components_1,
                                        donePressed: (){
                                          if(heats != null && (idx + 1) < heats.length) {
                                            idx += 1;
                                            var _heat = heats[idx];
                                            if(_heat.critiqueSheetType != 1) {
                                              Navigator.popAndPushNamed(context, "/critique2");
                                            } else {
                                              crit1.judge = judge;
                                              crit1.idx = idx;
                                              crit1.heats = heats;
                                              Navigator.popAndPushNamed(context, "/critique1");
                                            }
                                          }
                                          else {
                                            // DONE screen
                                            //ScreenUtil.showMainFrameDialog(context, "Critique Form Done", "Please inform event coordinator. Thanks");
                                            Navigator.pushNamed(context, "/critiqueDone");
                                          }
                                        },
                                      ),
                                      loadMoreCallback: (){}
                                  ),
                                  new PageSelectData(
                                      tabName: 'Couple ${heat_info.assignedCouple[1]}',
                                      description: '',
                                      //demoWidget: _buildTabContents("576", _feedbackPainter1),
                                      demoWidget: new CritiqueForm2(
                                        heat_info: heat_info,
                                        judge: judge,
                                        coupleName: "${heat_info.assignedCouple[1]}",
                                        categoryType: "Full Bronze",
                                        feedbackP: feedbackP_2,
                                        wl_technical_components: wl_technical_components_2,
                                        wl_artistic_components: wl_artistic_components_2,
                                        ki_technical_components: ki_technical_components_2,
                                        ki_artistic_components: ki_artistic_components_2,
                                        donePressed: (){
                                          if(heats != null && (idx + 1) < heats.length) {
                                            idx += 1;
                                            var _heat = heats[idx];
                                            if(_heat.critiqueSheetType != 1) {
                                              Navigator.popAndPushNamed(context, "/critique2");
                                            } else {
                                              crit1.judge = judge;
                                              crit1.idx = idx;
                                              crit1.heats = heats;
                                              Navigator.popAndPushNamed(context, "/critique1");
                                            }
                                          }
                                          else {
                                            // DONE screen
                                            //ScreenUtil.showMainFrameDialog(context, "Critique Form Done", "Please inform event coordinator. Thanks");
                                            Navigator.pushNamed(context, "/critiqueDone");
                                          }
                                        },
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
              new DanceFrameFooter()
            ],
          ),
        )
    );
  }
}