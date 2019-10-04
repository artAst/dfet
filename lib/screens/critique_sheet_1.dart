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

var judge;

class critique_sheet_1 extends StatefulWidget {
  @override
  _critique_sheet_1State createState() => new _critique_sheet_1State();
}

class _critique_sheet_1State extends State<critique_sheet_1> {

  HeatInfo heat_info;

  @override
  void initState() {
    super.initState();

    HeatDao.getHeatInfoById("1").then((val){
      setState(() {
        print("val = ${val.toMap()}");
        heat_info = val;
      });
    });
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
                                      tabName: 'Couple 146',
                                      description: '',
                                      demoWidget: new CritiqueForm1(
                                        heat_info: heat_info,
                                        judge: judge,
                                        coupleName: "146",
                                        donePressed: (){
                                          crit2.judge = judge;
                                          Navigator.pushNamed(context, "/critique2");
                                        },
                                      ),
                                      loadMoreCallback: (){}
                                  ),
                                  new PageSelectData(
                                      tabName: 'Couple 576',
                                      description: '',
                                      //demoWidget: _buildTabContents("576", _techniquePainter2, _musicalityPainter2, _partneringPainter2, _presentationPainter2, _feedbackPainter2),
                                      demoWidget: new CritiqueForm1(
                                        heat_info: heat_info,
                                        judge: judge,
                                        coupleName: "576",
                                        donePressed: (){
                                          crit2.judge = judge;
                                          Navigator.pushNamed(context, "/critique2");
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