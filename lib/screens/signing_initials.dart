import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'package:danceframe_et/widgets/DanceframeFormContainer.dart';
import 'package:danceframe_et/widgets/Painter.dart';
import 'package:danceframe_et/widgets/PainterStack.dart';
import 'package:danceframe_et/util/ScreenUtil.dart';
import 'package:danceframe_et/model/Judge.dart';
import 'package:danceframe_et/dao/PersonDao.dart';
import 'package:danceframe_et/dao/HeatDao.dart';
import 'package:danceframe_et/widgets/DanceFrameFooter.dart';
import 'package:danceframe_et/util/Preferences.dart';
import 'package:danceframe_et/widgets/LoadingIndicator.dart';
import 'device_mode.dart' as new_judge;
import 'critique_sheet_1.dart' as crit1;
import 'critique_sheet_2.dart' as crit2;

class signing_initials extends StatefulWidget {
  @override
  _signing_initialsState createState() => new _signing_initialsState();
}

class _signing_initialsState extends State<signing_initials> {

  PainterController _controller1;
  PainterController _controller2;
  PainterController _controller3;
  PainterController _controller4;
  PainterController _controller5;
  String judgeNameHeader = "Judge";

  @override
  void initState() {
    super.initState();
    _controller1 = _newController();
    _controller2 = _newController();
    _controller3 = _newController();
    _controller4 = _newController();
    _controller5 = _newController();
    if(new_judge.p.first_name.isNotEmpty && new_judge.p.last_name.isNotEmpty) {
      setState(() {
        judgeNameHeader = "${new_judge.p.first_name} ${new_judge.p.last_name}";
      });
    }
  }

  PainterController _newController() {
    PainterController controller = new PainterController();

    controller.thickness = 2.0;

    controller.backgroundColor = Colors.white;
    return controller;
  }

  bool validateInitials() {
    if(!_controller1.hasDrawContent()) {
      ScreenUtil.showMainFrameDialog(context, "Cannot Save", "Please Sign-in Initials 1.");
      return false;
    }
    if(!_controller2.hasDrawContent()) {
      ScreenUtil.showMainFrameDialog(context, "Cannot Save", "Please Sign-in Initials 2.");
      return false;
    }
    if(!_controller3.hasDrawContent()) {
      ScreenUtil.showMainFrameDialog(context, "Cannot Save", "Please Sign-in Initials 3.");
      return false;
    }
    if(!_controller4.hasDrawContent()) {
      ScreenUtil.showMainFrameDialog(context, "Cannot Save", "Please Sign-in Initials 4.");
      return false;
    }
    if(!_controller5.hasDrawContent()) {
      ScreenUtil.showMainFrameDialog(context, "Cannot Save", "Please Sign-in Initials 5.");
      return false;
    }
    return true;
  }

  void loadJudge() {
    PersonDao.getPersonByName("Sammy", "Field").then((judge){
      Preferences.setSharedValue("person_device", judge.toString());
      print("Judge: ${judge.toMap()}");
      HeatDao.getHeatsByJudge(judge.id).then((heats){
        print("heat length: ${heats.length}");
        for(var heat in heats) {
          print(heat.toMap());
        }
        if(heats != null) {
          var _heat = heats[0];
          Judge _temp = new Judge();
          _temp.initials = judge.initials;
          _temp.gender = judge.gender;
          _temp.last_name = judge.last_name;
          _temp.first_name = judge.first_name;
          if(_heat.critiqueSheetType != 1) {
            crit2.judge = _temp;
            crit2.heats = heats;
            Navigator.popAndPushNamed(context, "/critique2");
          } else {
            crit1.judge = _temp;
            crit1.heats = heats;
            Navigator.popAndPushNamed(context, "/critique1");
          }
        }
        else {
          // DONE screen
          ScreenUtil.showMainFrameDialog(context, "No Critique Sheets", "No Critique Sheets assigned for this Judge. Please inform event coordinator. Thanks");
        }
      });
    });
  }

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
                  headingText: judgeNameHeader,
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
                                      text: "To save your time signing your initials on every score sheet, please enter your initials inside the boxes five times. We will randomly select one for each score sheet.",
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
                                            border: Border.all(),
                                        ),
                                        height: 100.0,
                                        width: 100.0,
                                        child: PainterStack(_controller1),
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
                                            child: PainterStack(_controller2),
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
                                          child: PainterStack(_controller3),
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
                                            child: PainterStack(_controller4),
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
                                              child: PainterStack(_controller5),
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
                              new DanceFrameButton(
                                onPressed: () {
                                  _controller1.clear();
                                  _controller2.clear();
                                  _controller3.clear();
                                  _controller4.clear();
                                  _controller5.clear();
                                  Navigator.pop(context);
                                },
                                text: "CANCEL"
                              ),
                              new Expanded(child: Container()),
                              new DanceFrameButton(
                                onPressed: () {
                                  MainFrameLoadingIndicator.showLoading(context);
                                  if(validateInitials()) {
                                    String filename = "${new_judge.p.first_name}_${new_judge.p.last_name}_initials_";
                                    print("Saving initials 1-5...");
                                    _controller1.finish("${filename}1");
                                    _controller2.finish("${filename}2");
                                    _controller3.finish("${filename}3");
                                    _controller4.finish("${filename}4");
                                    _controller5.finish("${filename}5");
                                    new_judge.p.initials = [];
                                    for(int x=1; x <= 5; x++) {
                                      new_judge.p.initials.add("${filename}${x}");
                                    }
                                    Future.delayed(const Duration(seconds: 2), () {
                                      PersonDao.updatePerson(new_judge.p).then((val){
                                        print("Person saved: ID[${val}] ${new_judge.p.toString()}");
                                        loadJudge();
                                        MainFrameLoadingIndicator.hideLoading(context);
                                      });
                                    });

                                  }
                                },
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
              new DanceFrameFooter()
            ],
          ),
        )
    );
  }
}