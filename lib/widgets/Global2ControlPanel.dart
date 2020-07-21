import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:danceframe_et/widgets/CPCheckbox.dart';
import 'package:danceframe_et/widgets/MFTextFormField.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'package:danceframe_et/formatter/TimeTextInputFormatter.dart';
import 'package:danceframe_et/screens/change_device_mode.dart';
import 'package:danceframe_et/widgets/LoadingIndicator.dart';
import 'package:danceframe_et/model/config/EventConfig.dart';
import 'package:danceframe_et/util/ScreenUtil.dart';
import 'package:danceframe_et/util/LoadContent.dart';

class Global2ControlPanel extends StatefulWidget {
  @override
  _Global2ControlPanelState createState() => new _Global2ControlPanelState();
}

class _Global2ControlPanelState extends State<Global2ControlPanel> {

  TextEditingController eventName = new TextEditingController();
  TextEditingController eventDate = new TextEditingController();
  TextEditingController eventTime = new TextEditingController();

  List<String> screenTimeouts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      eventName.text = EventConfig.eventName != null ? EventConfig.eventName : "";
      eventDate.text = EventConfig.eventDate != null ? EventConfig.eventDate : "";

      if(EventConfig.screenTimeout) {
        screenTimeouts = [];
        screenTimeouts.add("sc_timeout");
      }
      else {
        screenTimeouts = [];
      }
      eventTime.text = EventConfig.eventTime != null ? EventConfig.eventTime.toUpperCase() : "";
      print("Event Date: ${eventDate.text}");
      print("Event Time: ${eventTime.text} ${EventConfig.eventTime}");
    });
  }

  void saveGlobal2() {
    bool saveFlag = true;
    if(eventName.text.isEmpty) {
      ScreenUtil.showMainFrameDialog(context, "Invalid", "Please Fill in Event Name");
      saveFlag = false;
    }
    else {
      EventConfig.eventName = eventName.text;
    }

    if(screenTimeouts.isEmpty) {
      EventConfig.screenTimeout = false;
    }
    else {
      EventConfig.screenTimeout = true;
    }

    if(eventDate.text.isEmpty) {
      ScreenUtil.showMainFrameDialog(context, "Invalid", "Please Fill in Event Date");
      saveFlag = false;
    }
    else {
      EventConfig.eventDate = eventDate.text;
    }

    if(eventTime.text.isEmpty) {
      ScreenUtil.showMainFrameDialog(context, "Invalid", "Please Fill in Event Time");
      saveFlag = false;
    }
    else {
      print("EVT TIME: ${eventTime.text}");
      EventConfig.eventTime = eventTime.text;
    }

    // Save
    if(saveFlag) {
      MainFrameLoadingIndicator.showLoading(context);
      LoadContent.saveEventConfig(context).then((val) {
        MainFrameLoadingIndicator.hideLoading(context);
        ScreenUtil.showMainFrameDialog(
            context, "Save Success", "Event info saved. Press OK.").then((val) {
          setState(() {
            EventConfig.eventName = eventName.text;
          });
//          Navigator.maybePop(context);
        });
      });
    }
  }

  _discardGlobal2() async {
    MainFrameLoadingIndicator.showLoading(context);
    setState(() {
      eventName.text = EventConfig.eventName != null ? EventConfig.eventName : "";
      if (EventConfig.screenTimeout && screenTimeouts.isEmpty) {
        screenTimeouts.add("sc_timeout");
      }
      else {
        if (!EventConfig.screenTimeout && screenTimeouts.contains("sc_timeout")) {
          screenTimeouts.remove("sc_timeout");
        }
      }
      if(EventConfig.eventDate.isNotEmpty) {
        eventDate.text = EventConfig.eventDate;
      } else {
        eventDate.text = DateTime.now().toString();
        eventDate.clear();
      }
      eventTime.clear();
    });
    ScreenUtil.showMainFrameDialog(context, "Changes Discarded", "").then((value) {
      MainFrameLoadingIndicator.hideLoading(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: FractionColumnWidth(0.25),
                  1: FractionColumnWidth(0.75),
                },
                children: [
                  TableRow(
                    children: [
                      Container(
                          padding: EdgeInsets.only(right: 10.0),
                          alignment: Alignment.centerRight,
                          child: Text("Event Name: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700))
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 360.0,
                            child: TextFormField(
                              decoration: new InputDecoration(
                                labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                                border: OutlineInputBorder(),
                              ),
                              style: TextStyle(fontSize: 24.0),
                              controller: eventName,
                            )
                          )
                        ],
                      )
                    ]
                  ),
                  TableRow(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 25.0)),
                        SizedBox()
                      ]
                  ),
                  TableRow(
                      children: [
                        Container(
                            padding: EdgeInsets.only(right: 10.0),
                            alignment: Alignment.centerRight,
                            child: Text("Screen timeouts: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700))
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Enabled ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w500)),
                            CPCheckbox(
                                value: "sc_timeout",
                                onChange: (val){
                                  if(val && !screenTimeouts.contains("sc_timeout")){
                                    screenTimeouts.add("sc_timeout");
                                  } else {
                                    screenTimeouts.remove("sc_timeout");
                                  }
                                  print("VAL $val GRP ${screenTimeouts}");
                                },
                                groupValue: screenTimeouts
                            )
                          ],
                        )
                      ]
                  ),
                  TableRow(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 12.0)),
                        SizedBox()
                      ]
                  ),
                  TableRow(
                      children: [
                        Container(
                            padding: EdgeInsets.only(right: 10.0, top: 15.0),
                            alignment: Alignment.bottomRight,
                            child: Text("Date: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700))
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 260.0,
                              child: new MFTextFormField(
                                icon: const Icon(Icons.access_time),
                                labelText: ' ',
                                keyboardType: TextInputType.text,
                                onSaved: (String val) {
                                  if(val != null && !val.isEmpty) {
                                    // _user.birthday =
                                    //    new DateFormat("MM/dd/yyyy").parse(val);
                                    eventDate.text = val;
                                  }
                                },
                                controller: eventDate,
                                //validator: _validateBirthday,
                                isDatePicker: true,
                              ),
                            )
                          ],
                        )
                      ]
                  ),
                  TableRow(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 25.0)),
                        SizedBox()
                      ]
                  ),
                  TableRow(
                      children: [
                        Container(
                            padding: EdgeInsets.only(right: 10.0),
                            alignment: Alignment.centerRight,
                            child: Text("Time: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700))
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 160.0,
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: "24:00",
                                  labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                                  border: OutlineInputBorder(),
                                ),
                                style: TextStyle(fontSize: 24.0),
                                inputFormatters: <TextInputFormatter>[
                                  new TimeTextInputFormatter()
                                ],
                                controller: eventTime,
                                keyboardType: TextInputType.number,
                              )
                            )
                          ],
                        )
                      ]
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  change_device_mode.isEditMode == true
                      ? Row(
                    children: <Widget>[
                      new DanceFrameButton(
                        text: "EXIT",
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                      Padding(padding: EdgeInsets.only(left: 10.0)),
                    ],
                  )
                      : Container(),
                  new DanceFrameButton(
                    text: "DISCARD",
                    onPressed: (){
                      _discardGlobal2();
                    },
                  ),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  new DanceFrameButton(
                    text: "SAVE",
                    onPressed: saveGlobal2,
                  ),
                ],
              )
            ],
            /*children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Event Name: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700)),
                  Container(
                      width: 360.0,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(fontSize: 24.0),
                        controller: eventName,
                      )
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Row(
                children: <Widget>[
                  Text("Screen timeouts enabled: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700)),
                  CPCheckbox(
                      value: "sc_timeout",
                      onChange: (val){
                        if(val && !screenTimeouts.contains("sc_timeout")){
                          screenTimeouts.add("sc_timeout");
                        } else {
                          screenTimeouts.remove("sc_timeout");
                        }
                        print("VAL $val GRP ${screenTimeouts}");
                      },
                      groupValue: screenTimeouts
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Row(
                children: <Widget>[
                  Text("Date: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700)),
                  Container(
                    width: 260.0,
                    child: new MFTextFormField(
                      icon: const Icon(Icons.access_time),
                      labelText: ' ',
                      keyboardType: TextInputType.text,
                      onSaved: (String val) {
                        if(val != null && !val.isEmpty) {
                          // _user.birthday =
                          //    new DateFormat("MM/dd/yyyy").parse(val);
                          eventDate.text = val;
                        }
                      },
                      controller: eventDate,
                      //validator: _validateBirthday,
                      isDatePicker: true,
                    ),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Row(
                children: <Widget>[
                  Text("Time: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700)),
                  Container(
                      width: 160.0,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          hintText: "24:00",
                          labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(fontSize: 24.0),
                        inputFormatters: <TextInputFormatter>[
                          new TimeTextInputFormatter()
                        ],
                        controller: eventTime,
                        keyboardType: TextInputType.number,
                      )
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  change_device_mode.isEditMode == true
                      ? Row(
                    children: <Widget>[
                      new DanceFrameButton(
                        text: "EXIT",
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                      Padding(padding: EdgeInsets.only(left: 10.0)),
                    ],
                  )
                      : Container(),
                  new DanceFrameButton(
                    text: "DISCARD",
                    onPressed: (){
                      _discardGlobal2();
                    },
                  ),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  new DanceFrameButton(
                    text: "SAVE",
                    onPressed: saveGlobal2,
                  ),
                ],
              )
            ]*/
        )
    );
  }
}