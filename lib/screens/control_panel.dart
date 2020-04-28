import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/widgets/DanceframeFormContainer.dart';
import 'package:danceframe_et/widgets/MFTabComponent.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'package:danceframe_et/util/ScreenUtil.dart';
import 'package:danceframe_et/util/DatabaseHelper.dart';
import 'package:danceframe_et/util/Preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:danceframe_et/widgets/CPCheckbox.dart';
import 'package:danceframe_et/widgets/CPRadio.dart';
import 'package:danceframe_et/model/config/EventConfig.dart';
import 'package:danceframe_et/widgets/MFTextFormField.dart';
import 'package:danceframe_et/formatter/TimeTextInputFormatter.dart';
import 'package:danceframe_et/util/LoadContent.dart';

class control_panel extends StatefulWidget {
  @override
  _control_panelState createState() => new _control_panelState();
}

class _control_panelState extends State<control_panel> {
  TextEditingController deviceNum = new TextEditingController();
  TextEditingController eventName = new TextEditingController();
  TextEditingController eventDate = new TextEditingController();
  TextEditingController eventTime = new TextEditingController();
  TextEditingController rpi1 = new TextEditingController();
  TextEditingController rpi2 = new TextEditingController();
  TextEditingController deviceIp = new TextEditingController();
  TextEditingController mask = new TextEditingController();
  bool isNew = false;
  List<String> _enabled = [];
  String _primary = "";
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

    Preferences.getSharedValue("deviceNumber").then((val){
      deviceNum.text = val;
      // check if init setup
      if(val == null) {
        isNew = true;
      }
    });
    Preferences.getSharedValue("rpi1").then((val){
      rpi1.text = val;
    });
    Preferences.getSharedValue("rpi2").then((val){
      rpi2.text = val;
    });
    Preferences.getSharedValue("deviceIp").then((val){
      deviceIp.text = val;
    });
    Preferences.getSharedValue("mask").then((val){
      mask.text = val;
    });
    Preferences.getSharedValue("primaryRPI").then((val){
      setState(() {
        _primary = val;
      });
    });
    Preferences.getSharedValue("enabledRPI").then((val){
      setState(() {
        if(val != null && val.isNotEmpty) {
          if(val.contains(",")) {
            _enabled = val.split(",");
          }
          else {
            _enabled.add(val);
          }
          print("enabled length: ${_enabled?.length} items: ${_enabled?.toString()}");
        }
      });
    });
  }

  void _saveDevice() {
    if(deviceNum.text.isNotEmpty) {
      print("saving device #${deviceNum.text}");
      Preferences.setSharedValue("deviceNumber", deviceNum.text);
      if(deviceIp.text.isNotEmpty) {
        Preferences.setSharedValue("deviceIp", deviceIp.text);
      }
      if(mask.text.isNotEmpty) {
        Preferences.setSharedValue("mask", mask.text);
      }
      if(_enabled != null && _enabled.isNotEmpty) {
        print("saving enabled: ${_enabled.toString().replaceAll("[", "").replaceAll("]", "").replaceAll(" ", "")}");
        Preferences.setSharedValue("enabledRPI", _enabled.toString().replaceAll("[", "").replaceAll("]", "").replaceAll(" ", ""));
      }
      if(_primary != null && _primary.isNotEmpty) {
        print("saving primary: ${_primary}");
        Preferences.setSharedValue("primaryRPI", _primary);
      }
      if(rpi1.text.isNotEmpty) {
        print("saving rpi1 #${rpi1.text}");
        Preferences.setSharedValue("rpi1", rpi1.text);
        if(rpi2.text.isNotEmpty) {
          print("saving rpi2 #${rpi2.text}");
          Preferences.setSharedValue("rpi2", rpi2.text);
          ScreenUtil.showMainFrameDialog(context, "Saved", "Details saved.").then((val){
            if(isNew) {
              Navigator.pushNamed(context, "/");
            } else {
              //Navigator.maybePop(context, true);
              Navigator.pop(context);
            }
          });
        }
        else {
          ScreenUtil.showMainFrameDialog(context, "Invalid", "Please Fill in Raspbery Pi #2");
        }
      }
      else {
        ScreenUtil.showMainFrameDialog(context, "Invalid", "Please Fill in Raspbery Pi #1");
      }
    } else {
      ScreenUtil.showMainFrameDialog(context, "Invalid", "Please Fill in Device Number");
    }
  }

  void saveGlobal2() {
    if(eventName.text.isEmpty) {
      ScreenUtil.showMainFrameDialog(context, "Invalid", "Please Fill in Event Name");
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
    }
    else {
      EventConfig.eventDate = eventDate.text;
    }

    if(eventTime.text.isEmpty) {
      ScreenUtil.showMainFrameDialog(context, "Invalid", "Please Fill in Event Time");
    }
    else {
      print("EVT TIME: ${eventTime.text}");
      EventConfig.eventTime = eventTime.text;
    }

    // Save
    LoadContent.saveEventConfig(context).then((val){
      ScreenUtil.showMainFrameDialog(context, "Save Success", "Event Info Saved. press OK.").then((val){
        Navigator.maybePop(context);
      });
    });
  }

  Widget _buildGlobal3() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(child: Text("PROFILE TYPES", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700))),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(right: 15.0), child: Text("Enabled", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600))),
              Padding(padding: EdgeInsets.only(left: 15.0), child: Text("Screen Timeout", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600))),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child: Text("Emcee", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600))
                ),
                Container(width: 120.0, child: Icon(Icons.check_box, size: 28.0)),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Container(
                    //color: Colors.blue,
                    width: 200.0,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 70.0,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(
                              labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                              border: OutlineInputBorder(),
                            ),
                            style: TextStyle(fontSize: 26.0),
                          )
                        ),
                        Padding(padding: EdgeInsets.only(left: 5.0), child: Text("min", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)))
                      ],
                    )
                  )
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child: Text("Chairman of Judges", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600))
                ),
                Container(width: 120.0, child: Icon(Icons.check_box, size: 28.0)),
                Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Container(
                      //color: Colors.blue,
                        width: 200.0,
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 70.0,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                    labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                                    border: OutlineInputBorder(),
                                  ),
                                  style: TextStyle(fontSize: 26.0),
                                )
                            ),
                            Padding(padding: EdgeInsets.only(left: 5.0), child: Text("min", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)))
                          ],
                        )
                    )
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child: Text("Deck Captain", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600))
                ),
                Container(width: 120.0, child: Icon(Icons.check_box, size: 28.0)),
                Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Container(
                      //color: Colors.blue,
                        width: 200.0,
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 70.0,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                    labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                                    border: OutlineInputBorder(),
                                  ),
                                  style: TextStyle(fontSize: 26.0),
                                )
                            ),
                            Padding(padding: EdgeInsets.only(left: 5.0), child: Text("min", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)))
                          ],
                        )
                    )
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child: Text("Judge", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600))
                ),
                Container(width: 120.0, child: Icon(Icons.check_box, size: 28.0)),
                Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Container(
                      //color: Colors.blue,
                        width: 200.0,
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 70.0,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                    labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                                    border: OutlineInputBorder(),
                                  ),
                                  style: TextStyle(fontSize: 26.0),
                                )
                            ),
                            Padding(padding: EdgeInsets.only(left: 5.0), child: Text("min", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)))
                          ],
                        )
                    )
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child: Text("Registrar", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600))
                ),
                Container(width: 120.0, child: Icon(Icons.check_box, size: 28.0)),
                Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Container(
                      //color: Colors.blue,
                        width: 200.0,
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 70.0,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                    labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                                    border: OutlineInputBorder(),
                                  ),
                                  style: TextStyle(fontSize: 26.0),
                                )
                            ),
                            Padding(padding: EdgeInsets.only(left: 5.0), child: Text("min", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)))
                          ],
                        )
                    )
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child: Text("Scrutineer", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600))
                ),
                Container(width: 120.0, child: Icon(Icons.check_box, size: 28.0)),
                Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Container(
                      //color: Colors.blue,
                        width: 200.0,
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 70.0,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                    labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                                    border: OutlineInputBorder(),
                                  ),
                                  style: TextStyle(fontSize: 26.0),
                                )
                            ),
                            Padding(padding: EdgeInsets.only(left: 5.0), child: Text("min", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)))
                          ],
                        )
                    )
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child: Text("Photos/Videos", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600))
                ),
                Container(width: 120.0, child: Icon(Icons.check_box, size: 28.0)),
                Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Container(
                      //color: Colors.blue,
                        width: 200.0,
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 70.0,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                    labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                                    border: OutlineInputBorder(),
                                  ),
                                  style: TextStyle(fontSize: 26.0),
                                )
                            ),
                            Padding(padding: EdgeInsets.only(left: 5.0), child: Text("min", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)))
                          ],
                        )
                    )
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child: Text("Hair/Make Up", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600))
                ),
                Container(width: 120.0, child: Icon(Icons.check_box, size: 28.0)),
                Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Container(
                      //color: Colors.blue,
                        width: 200.0,
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 70.0,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                    labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                                    border: OutlineInputBorder(),
                                  ),
                                  style: TextStyle(fontSize: 26.0),
                                )
                            ),
                            Padding(padding: EdgeInsets.only(left: 5.0), child: Text("min", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)))
                          ],
                        )
                    )
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child: Text("Administrator", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600))
                ),
                Container(width: 120.0, child: Icon(Icons.check_box, size: 28.0)),
                Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Container(
                      //color: Colors.blue,
                        width: 200.0,
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 70.0,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                    labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                                    border: OutlineInputBorder(),
                                  ),
                                  style: TextStyle(fontSize: 26.0),
                                )
                            ),
                            Padding(padding: EdgeInsets.only(left: 5.0), child: Text("min", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)))
                          ],
                        )
                    )
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new DanceFrameButton(
                text: "DISCARD",
                onPressed: (){
                  Navigator.maybePop(context);
                },
              ),
              Padding(padding: EdgeInsets.only(left: 10.0)),
              new DanceFrameButton(
                text: "SAVE",
                onPressed: (){},
              ),
            ],
          )
        ]
      )
    );
  }

  Widget _buildGlobal2() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
          /*Row(
            children: <Widget>[
              Text("Event Code: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700)),
              Container(
                  width: 160.0,
                  child: TextFormField(
                    decoration: new InputDecoration(
                      labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(fontSize: 24.0),
                  )
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),*/
          Row(
            children: <Widget>[
              Text("Date: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700)),
              Container(
                  width: 260.0,
                  /*child: TextFormField(
                    decoration: new InputDecoration(
                      labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(fontSize: 24.0),
                    controller: eventDate,
                  )*/
                  child: new MFTextFormField(
                    icon: const Icon(Icons.access_time),
                    labelText: ' ',
                    keyboardType: TextInputType.text,
                    onSaved: (String val) {
                      if(val != null && !val.isEmpty) {
                        //_user.birthday =
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
              new DanceFrameButton(
                text: "DISCARD",
                onPressed: (){
                  Navigator.maybePop(context);
                },
              ),
              Padding(padding: EdgeInsets.only(left: 10.0)),
              new DanceFrameButton(
                text: "SAVE",
                onPressed: saveGlobal2,
              ),
            ],
          )
        ]
      )
    );
  }

  Widget _buildDevice1() {
    return Container(
      //color: Colors.amber,
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("Device number: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700)),
              Container(
                width: 260.0,
                child: TextFormField(
                  decoration: new InputDecoration(
                    labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(fontSize: 24.0),
                  controller: deviceNum,
                )
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          Row(
            children: <Widget>[
              Text("Device IP: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700)),
              Container(
                  width: 260.0,
                  child: TextFormField(
                    decoration: new InputDecoration(
                      labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(fontSize: 24.0),
                    controller: deviceIp,
                  )
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          Row(
            children: <Widget>[
              Text("Mask: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700)),
              Container(
                  width: 260.0,
                  child: TextFormField(
                    decoration: new InputDecoration(
                      labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(fontSize: 24.0),
                    controller: mask,
                  )
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          Row(
            children: <Widget>[
              Text("RPI #1 IP: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700)),
              Container(
                  width: 260.0,
                  child: TextFormField(
                    decoration: new InputDecoration(
                      labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(fontSize: 24.0),
                    controller: rpi1,
                  )
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Wrap(
                  children: <Widget>[
                    Text("Enabled", style: TextStyle(fontSize: 26.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w600)),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 20.0),
                      child: CPCheckbox(
                        value: "rpi1",
                        onChange: (val){
                          if(val && !_enabled.contains("rpi1")){
                            _enabled.add("rpi1");
                          } else {
                            _enabled.remove("rpi1");
                          }
                          print("VAL $val GRP ${_enabled}");
                        },
                        groupValue: _enabled
                      )
                    ),
                    Text("Primary", style: TextStyle(fontSize: 26.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w600)),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: CPRadio(
                        value: "rpi1",
                        onChange: (val){
                          setState(() {
                            if(val && _primary != "rpi1"){
                              _primary = "rpi1";
                            }
                            print("VAL $val GRP ${_primary}");
                          });
                        },
                        groupValue: _primary)
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          Row(
            children: <Widget>[
              Text("RPI #2 IP: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700)),
              Container(
                  width: 260.0,
                  child: TextFormField(
                    decoration: new InputDecoration(
                      labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(fontSize: 24.0),
                    controller: rpi2,
                  )
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Wrap(
                  children: <Widget>[
                    Text("Enabled", style: TextStyle(fontSize: 26.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w600)),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 20.0),
                      child: CPCheckbox(
                        value: "rpi2",
                        onChange: (val){
                          if(val && !_enabled.contains("rpi2")){
                            _enabled.add("rpi2");
                          } else {
                            _enabled.remove("rpi2");
                          }
                          print("VAL $val GRP ${_enabled}");
                        },
                        groupValue: _enabled
                      )
                    ),
                    Text("Primary", style: TextStyle(fontSize: 26.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w600)),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: CPRadio(
                        value: "rpi2",
                        onChange: (val){
                          setState(() {
                            if(val && _primary != "rpi2"){
                              _primary = "rpi2";
                            }
                            print("VAL $val GRP ${_primary}");
                          });
                        },
                        groupValue: _primary
                      )
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    new DanceFrameButton(
                      text: "RESET DEVICE",
                      width: 200.0,
                      onPressed: (){
                        ScreenUtil.showMainFrameDialogWithCancel(context, "Wipe Device Data", "Are you sure you want to wipe all the Data on this device?").then((val){
                          print("VALUE: $val");
                          if(val.toLowerCase() == "ok") {
                            ScreenUtil.showMainFrameDialog(context, "Wipe Device Data", "You pressed OK");
                            DatabaseHelper.instance.removeDB();
                            Preferences.clearPreferences().then((val){
                              ScreenUtil.showMainFrameDialog(context, "Wipe Success", "Application will restart. press ok to Exit").then((val){
                                exit(0);
                              });
                            });
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              new DanceFrameButton(
                text: "DISCARD",
                onPressed: (){
                  Navigator.maybePop(context);
                },
              ),
              Padding(padding: EdgeInsets.only(left: 10.0)),
              new DanceFrameButton(
                text: "SAVE",
                onPressed: _saveDevice,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildGlobal1() {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 380.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("GLOBAL RESET", style: TextStyle(fontSize: 30.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700)),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text("Only use this when setting up a new event. All data on all tablets and all data on RPI will be deleted.", textAlign: TextAlign.center, style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w600)),
            Padding(padding: EdgeInsets.only(top: 50.0)),
            new DanceFrameButton(
              text: "RESET",
              onPressed: (){
                ScreenUtil.showWipeDialogWithCancel(context, "Wipe Global Data", "Are you absolutely sure you want to wipe/reset everything for a new competition?").then((val){
                  print("VALUE: $val");
                  if(val.toLowerCase() == "ok") {
                    ScreenUtil.showMainFrameDialog(context, "Wipe Success", "Application will restart. press ok to Exit").then((val){
                      exit(0);
                    });
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new DanceframeAppBar(
          height: 150.0,
          mode: "TITLE",
          headerText: "CONFIGURATION SETUP",
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
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 2.0),
                      right: BorderSide(width: 2.0),
                      left: BorderSide(width: 2.0)
                    )
                  ),
                  child: new MFTabbedComponentDemoScaffold(
                      demos: <MFComponentDemoTabData>[
                        new MFComponentDemoTabData(
                          tabName: 'Device',
                          description: '',
                          demoWidget: _buildDevice1(),
                        ),
                        new MFComponentDemoTabData(
                          tabName: 'Global 1',
                          description: '',
                          demoWidget: _buildGlobal1(),
                        ),
                        new MFComponentDemoTabData(
                          tabName: 'Global 2',
                          description: '',
                          demoWidget: _buildGlobal2(),
                        ),
                        new MFComponentDemoTabData(
                          tabName: 'Global 3',
                          description: '',
                          demoWidget: _buildGlobal3(),
                        ),
                      ]
                  ),
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