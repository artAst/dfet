import 'dart:async';
import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'package:danceframe_et/widgets/Painter.dart';
import 'package:danceframe_et/widgets/ComponentCheckbox.dart';
import 'package:danceframe_et/model/Judge.dart';
import 'package:danceframe_et/model/Heat.dart';
import 'package:danceframe_et/dao/CritiqueDao.dart';

class CritiqueForm2 extends StatefulWidget {
  HeatInfo heat_info;
  Judge judge;
  String coupleName;

  // form data
  PainterController feedbackP;

  List<String> wl_technical_components;
  List<String> wl_artistic_components;
  List<String> ki_technical_components;
  List<String> ki_artistic_components;

  CritiqueForm2({
    this.heat_info,
    this.judge,
    this.coupleName,
    this.feedbackP,
    this.wl_technical_components,
    this.wl_artistic_components,
    this.ki_technical_components,
    this.ki_artistic_components,
  });

  @override
  _CritiqueForm2State createState() => new _CritiqueForm2State();
}

class _CritiqueForm2State extends State<CritiqueForm2> {

  CritiqueData2 critique;
  Timer saveTimer_feed;
  Timer saveTimer_component;
  String filename_feed;

  @override
  void initState() {
    super.initState();
    /*wl_technical_components = [];
    wl_artistic_components = [];
    ki_technical_components = [];
    ki_artistic_components = [];
    feedbackP = _newController();*/
    critique = new CritiqueData2();
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
    if(filename_feed != null) {
      critique.feedback = filename_feed;
    }
    if(widget.wl_technical_components != null && widget.wl_technical_components.isNotEmpty) {
      critique.wl_technical_components = [];
      critique.wl_technical_components.addAll(widget.wl_technical_components);
    }
    if(widget.wl_artistic_components != null && widget.wl_artistic_components.isNotEmpty) {
      critique.wl_artistic_components = [];
      critique.wl_artistic_components.addAll(widget.wl_artistic_components);
    }
    if(widget.ki_artistic_components != null && widget.ki_artistic_components.isNotEmpty) {
      critique.ki_artistic_components = [];
      critique.ki_artistic_components.addAll(widget.ki_artistic_components);
    }
    if(widget.ki_technical_components != null && widget.ki_technical_components.isNotEmpty) {
      critique.ki_technical_components = [];
      critique.ki_technical_components.addAll(widget.ki_technical_components);
    }

    if(critique.id == null) {
      CritiqueDao.saveCritique(critique, 2).then((id) {
        critique.id = id.toString();
      });
    } else {
      CritiqueDao.updateCritique(critique.id, critique, 2);
    }
  }

  void saveState(PainterController pt, coupleName, String componentTitle) {
    // save state changes during user ui input
    String filename = "${widget.judge.first_name}_${widget.judge.last_name}_heat${widget.heat_info.heat_number}_couple${coupleName}";

    switch(componentTitle) {
      case "component":
        if(saveTimer_component != null) saveTimer_component.cancel();
        saveTimer_component = new Timer(Duration(seconds: 2), () {
          saveData();
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

  void checkboxChanged(isChecked, val, List<String> listItems) {
//    print("list: ${listItems.toString()}");
    if(isChecked) {
      if(!listItems.contains(val)) {
        listItems.add(val);
      }
    } else {
      if(listItems.contains(val)) {
        listItems.remove(val);
//        print("Removed - $val");
      }
    }
    print("list after: ${listItems.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Divider(
          color: Colors.grey,
        ),
        new Center(
          child: new Text("COUPLE ${widget.coupleName} - Full Bronze", style: new TextStyle(
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
                  value: "posture",
                  groupValue: widget.wl_technical_components,
                  onChange: (val){
                    checkboxChanged(val, "posture", widget.wl_technical_components);
                    print("apply change");
                    saveState(widget.feedbackP, widget.coupleName, "component");
                  },
                ),
                new ComponentCheckbox(
                  text: "Footwork",
                  value: "footwork",
                  groupValue: widget.wl_technical_components,
                  onChange: (val){
                    checkboxChanged(val, "footwork", widget.wl_technical_components);
                    saveState(widget.feedbackP, widget.coupleName, "component");
                  },
                ),
                new ComponentCheckbox(
                  text: "Timing",
                  value: "timing",
                  groupValue: widget.wl_technical_components,
                  onChange: (val){
                    checkboxChanged(val, "timing", widget.wl_technical_components);
                    saveState(widget.feedbackP, widget.coupleName, "component");
                  },
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
                  value: "floor_craft",
                  groupValue: widget.wl_artistic_components,
                  onChange: (val){
                    checkboxChanged(val, "floor_craft", widget.wl_artistic_components);
                    saveState(widget.feedbackP, widget.coupleName, "component");
                  },
                ),
                new ComponentCheckbox(
                  text: "Partnering",
                  value: "partnering",
                  groupValue: widget.wl_artistic_components,
                  onChange: (val){
                    checkboxChanged(val, "partnering", widget.wl_artistic_components);
                    saveState(widget.feedbackP, widget.coupleName, "component");
                  },
                ),
                new ComponentCheckbox(
                  text: "Showmanship",
                  value: "showmanship",
                  groupValue: widget.wl_artistic_components,
                  onChange: (val){
                    checkboxChanged(val, "showmanship", widget.wl_artistic_components);
                    saveState(widget.feedbackP, widget.coupleName, "component");
                  },
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
                  value: "posture",
                  groupValue: widget.ki_technical_components,
                  onChange: (val){
                    checkboxChanged(val, "posture", widget.ki_technical_components);
                    saveState(widget.feedbackP, widget.coupleName, "component");
                  },
                ),
                new ComponentCheckbox(
                  text: "Footwork",
                  value: "footwork",
                  groupValue: widget.ki_technical_components,
                  onChange: (val){
                    checkboxChanged(val, "footwork", widget.ki_technical_components);
                    saveState(widget.feedbackP, widget.coupleName, "component");
                  },
                ),
                new ComponentCheckbox(
                  text: "Timing",
                  value: "timing",
                  groupValue: widget.ki_technical_components,
                  onChange: (val){
                    checkboxChanged(val, "timing", widget.ki_technical_components);
                    saveState(widget.feedbackP, widget.coupleName, "component");
                  },
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
                  value: "floor_craft",
                  groupValue: widget.ki_artistic_components,
                  onChange: (val){
                    checkboxChanged(val, "floor_craft", widget.ki_artistic_components);
                    saveState(widget.feedbackP, widget.coupleName, "component");
                  },
                ),
                new ComponentCheckbox(
                  text: "Partnering",
                  value: "partnering",
                  groupValue: widget.ki_artistic_components,
                  onChange: (val){
                    checkboxChanged(val, "partnering", widget.ki_artistic_components);
                    saveState(widget.feedbackP, widget.coupleName, "component");
                  },
                ),
                new ComponentCheckbox(
                  text: "Showmanship",
                  value: "showmanship",
                  groupValue: widget.ki_artistic_components,
                  onChange: (val){
                    checkboxChanged(val, "showmanship", widget.ki_artistic_components);
                    saveState(widget.feedbackP, widget.coupleName, "component");
                  },
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
                          height: 30.0,
                        ),
                        new Expanded(
                            child: Container(
                              child: Painter(widget.feedbackP, onChanged: (){
                                // save technique painter
                                saveState(widget.feedbackP, widget.coupleName, "feedback");
                              }),
                            )
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
                            Navigator.pushNamed(context, "/changeDeviceMode");
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
}