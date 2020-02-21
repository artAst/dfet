import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/widgets/DanceFrameFooter.dart';
import 'package:danceframe_et/widgets/SwipeToUnlock.dart';
import 'package:danceframe_et/util/Preferences.dart';
import 'package:danceframe_et/model/Person.dart';
import 'package:danceframe_et/screens/device_mode.dart' as deviceMode;
import 'package:danceframe_et/util/HttpUtil.dart';

class sign_in extends StatefulWidget {
  @override
  _sign_inState createState() => new _sign_inState();
}

class _sign_inState extends State<sign_in> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  Person p;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    textController1.text = "LOCKED";
    
    // load person setup for the device
    Preferences.getSharedValue("person_device").then((val){
      setState(() {
        if(val != null) {
          // person was setup on the device
          print("val = $val");
          p = new Person.fromMap(json.decode(val));
        }
        else {
          // NO person was setup on the device
          p = null;
        }
      });
    });

    /*JobPanelDataDao.getJobPanelDataById("1").then((data){
      print("jobPanel = ${data.toMap()}");
      print("persons = ");
      for(var p in data.panel_persons) {
        print(p.toMap());
      }
      print("heats = ");
      for(var h in data.heats) {
        print(h.toMap());
      }
    });*/
  }

  void actionOpen() {
    setState(() {
      textController1.text = "UNLOCKED";
    });

    if(p == null) {
      Navigator.pushNamed(context, "/personaliseDevice");
    }
    else {
      deviceMode.p = p;
      Navigator.pushNamed(context, "/deviceMode");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    String headerTxt = "";
    String pname = "";
    if(p != null) {
      if(p.user_roles.isNotEmpty) {
        headerTxt = p.user_roles[0].toString().replaceAll("UserProfiles.", "").replaceAll("_", " ");
      } else {
        headerTxt = "SETUP";
      }
      if(p.first_name != null && p.last_name != null) {
        pname = "${p.first_name} ${p.last_name}";
      }
    } else {
      headerTxt = "SETUP";
    }

    return new Scaffold(
        appBar: new DanceframeAppBar(
          height: 150.0,
          mode: "TITLE",
          headerText: headerTxt,
          bg: true,
        ),
        body: new Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [new Color(0xFFD6DFDE), Colors.white],
                  //colors: [Colors.red, Colors.blue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.01, 0.5]
              )
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Expanded(
                child: new SizedBox(
                  child: new Container(
                    //color: Colors.amber,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: height/6),
                                child: Text(pname, style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.w600)),
                              )
                            ],
                          ),
                        ),
                        Text(textController1.text, style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 40.0),
                          child: SwipeToUnlock(
                            width: width / 1.4,
                            height: 64,
                            backgroundChild: Center(
                              child: Text("SWIPE TO UNLOCK", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
                            ),
                            backgroundColor: Color(0xFFD6DFDE),
                            slidingBarColor: Color(0xFF577587),
                            slideDirection: SlideDirection.RIGHT,
                            onButtonOpened: actionOpen,
                            onButtonClosed: () {
                              /*setState(() {
                                textController1.text = "LOCKED";
                              });*/
                            },
                            onButtonSlide: (value) {
                              textController2.text = value.toString();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //child: new Container(),
              ),
              new DanceFrameFooter()
            ],
          ),
        )
    );
  }
}