import 'dart:convert';
import 'package:flutter/material.dart';
import 'JobPanelHeaderBtn.dart';
import 'JobPanelTime.dart';
import 'JobPanelHeatRow.dart';
import 'JobPanelPlusBtn.dart';
import 'package:danceframe_et/dao/JobPanelDataDao.dart';
import 'package:danceframe_et/model/JobPanelData.dart';
import 'package:danceframe_et/widgets/LoadingIndicator.dart';
import 'package:intl/intl.dart';
import 'package:danceframe_et/util/Preferences.dart';
import 'package:danceframe_et/model/Person.dart';
import 'package:danceframe_et/websocket/DanceFrameCommunication.dart';
import 'package:danceframe_et/model/ws/EntryData.dart';

List<JobPanelData> jobPanels;

class JobPanel extends StatefulWidget {
  @override
  _JobPanelState createState() => new _JobPanelState();
}

class _JobPanelState extends State<JobPanel> {
  DateFormat _hrFormat = new DateFormat("h:mm");
  DateFormat _amFormat = new DateFormat("a");
  Person p;
  bool _isLoading = false;

  Map<String, bool> jobPanelToggle = {};
  Map<String, bool> heatRowToggle = {};
  Map<String, bool> coupleRowToggle = {};

  void _onMessageRecieved(message) {
    print("message from widget: $message");
    // convert message to object
    EntryData e = EntryData.fromMap(jsonDecode(message));
    print("entrydata: ${e.toMap()}");

    if(e.onDeckFloor != null) {
      // on deck floor operation
      _updateEntryFromJobPanels(e.onDeckFloor.entryId, e.onDeckFloor, e.summary, "onDeckFloor");
      // update local DB via entry ID
      JobPanelDataDao.saveOnDeckFloor("couple_on_deck", e.onDeckFloor.entryId, (e.onDeckFloor.onDeck ? 1 : 0));
      JobPanelDataDao.saveOnDeckFloor("couple_on_floor", e.onDeckFloor.entryId, (e.onDeckFloor.onFloor ? 1 : 0));
    }
    else if(e.scratch != null) {
      // scratch operation
      if(e.scratch.entries != null) {
        for (var s in e.scratch?.entries) {
          String operation = "scratch";
          if (e.scratch.status == 1) {
            operation = "unscratch";
          }
          _updateEntryFromJobPanels(s.toString(), s, e.summary, operation);
        }
      }
    }
    else if(e.started != null) {
      _updateEntryFromJobPanels(e.started.heatId.toString(), e.started, e.summary, "started");
      JobPanelDataDao.saveHeatStarted("heat_started", e.started.heatId, (e.started.started ? 1 : 0));
    }
    /*for(var itm in entryArray) {
      //print("entryID [${e.entryId}]");
      // update jobpanel entries based on entry id
      EntryData e = EntryData.fromMap(jsonDecode(message));
      _updateEntryFromJobPanels(e);
      // update local DB via entry ID
      JobPanelDataDao.saveOnDeckFloor("couple_on_deck", e.entryId, (e.onDeck ? 1 : 0));
      JobPanelDataDao.saveOnDeckFloor("couple_on_floor", e.entryId, (e.onFloor ? 1 : 0));
    }*/
  }

  void _updateEntryFromJobPanels(id, entry, summary, operation) {
    print("Updating entry from panels...");
    bool hasUpdate = false;
    var _coupl;
    var _heat;
    Map<String, dynamic> _sc = {};
    if(jobPanels != null && jobPanels.length > 0) {
      // traverse panel
      for(JobPanelData _j in jobPanels) {
        // traverse heats
        for(var _h in _j.heats) {
          // traverse subheats
          if(operation == "started" && _h.id == id) {
            _heat = _h;
            hasUpdate = true;
            //break;
          }
          //else {
            for (var _sh in _h.sub_heats) {
              // traverse couples
              for (var _c in _sh?.couples) {
                if (summary != null && summary.length > 0) {
                  for(var _s in summary) {
                    //print("heatid[${_h.id}] entryId[${_c.entry_id}] coupletag[${_c.couple_tag}] summarykey[${_s.entryKey}]");
                    if(_c.couple_tag == _s.entryKey) {
                      // couple key matched. update summary
                      //print("entryId[${_c.entry_id}] found summary! [${_s.entryKey}]");
                      setState(() {
                        _c.total = _s.total;
                        _c.future = _s.future;
                        _c.danced = _s.danced;
                        _c.scratched = _s.scratched;
                        _c.booked = _s.booked;
                      });
                    }
                  }
                }

                if (operation != "started" && _c.entry_id == id) {
                  // entry matched. update entry
                  hasUpdate = true;
                  _coupl = _c;
                  break;
                }
              }
            }
          //}
        }
      }
    }

    print("update found == $hasUpdate");
    if(hasUpdate) {
      setState(() {
        if(operation == "onDeckFloor") {
          _coupl.onDeck = entry.onDeck;
          _coupl.onFloor = entry.onFloor;
          print("entryid[${_coupl.entry_id}] ondeckfloor total: ${_coupl.total}");
        }
        else if(operation == "scratch") {
          print("isScracthed: ${_coupl.is_scratched}");
          _coupl.is_scratched = true;
          JobPanelDataDao.updateHeatCouple_pi(_coupl);
        }
        else if(operation == "unscratch") {
          print("isScracthed: ${_coupl.is_scratched}");
          _coupl.is_scratched = false;
          JobPanelDataDao.updateHeatCouple_pi(_coupl);
        }
        else if(operation == "started") {
          setState(() {
            print("isStarted: ${_heat.isStarted}");
            _heat.isStarted = entry.started;
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Preferences.getSharedValue("deviceNumber").then((val){
      game.playerId = val;
      game.addListener(_onMessageRecieved);
    });


    jobPanels = [];

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

    //JobPanelDataDao.getAllJobPanelData().then((jp){
    JobPanelDataDao.getAllJobPanelData_pi().then((jp){
      print("JobPanel: ${jp?.length}");
      setState(() {
        if(jp != null) {
          jobPanels = jp;
          // initialize toggles
          for(JobPanelData _j in jp) {
            jobPanelToggle[_j.id] = false;
            for(var _h in _j.heats) {
              heatRowToggle[_h.id] = false;
              for(var _sh in _h.sub_heats) {
                //print("---------------subHeat: ${_sh.toMap()}");
                for(var _c in _sh?.couples) {
                  coupleRowToggle[_c.id] = false;
                }
              }
            }
          }
        }
      });
    });
  }

  Widget generateJobPersonRow(String personName, String roleSelected, String num) {
    return Container(
        padding: EdgeInsets.only(right: 15.0, left: 25.0, top: 10.0, bottom: 15.0),
        constraints: BoxConstraints(minHeight: 60.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text("$num. ${personName}", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w500)),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                color: (roleSelected.toLowerCase() == "judge") ? Color(0xff1a9b93) : Color(0xff475156),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              alignment: Alignment.center,
                              child: Text("JUDGE", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                color: (roleSelected.toLowerCase() == "invigilator") ? Color(0xff1a9b93) : Color(0xff475156),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              alignment: Alignment.center,
                              child: Text("INVIGILATOR", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                color: (roleSelected.toLowerCase() == "emcee") ? Color(0xff1a9b93) : Color(0xff475156),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              alignment: Alignment.center,
                              child: Text("EMCEE", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                color: (roleSelected.toLowerCase() == "free time") ? Color(0xff1a9b93) : Color(0xff475156),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              alignment: Alignment.center,
                              child: Text("FREE TIME", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: (roleSelected.toLowerCase() == "chairman of judges") ? Color(0xff1a9b93) : Color(0xff475156),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              alignment: Alignment.center,
                              child: Text("CHAIRMAN OF JUDGES", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: (roleSelected.toLowerCase() == "scrutineer") ? Color(0xff1a9b93) : Color(0xff475156),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              alignment: Alignment.center,
                              child: Text("SCRUTINEER", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: (roleSelected.toLowerCase() == "deck captain") ? Color(0xff1a9b93) : Color(0xff475156),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              alignment: Alignment.center,
                              child: Text("DECK CAPTAIN", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                      ],
                    )
                  ],
                )
            ),
          ],
        )
    );
  }

  Widget generateJobPanelContent(persons) {
    List<Widget> _children = [];
    for(var p in persons) {
      String role = p.user_roles[0].toString().replaceAll("UserProfiles.", "").replaceAll("_", " ");
      _children.add(generateJobPersonRow("${p.first_name} ${p.last_name}", role, p.id));
    }

    return Container(
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black, width: 1.5),
            left: BorderSide(color: Colors.black, width: 1.5),
            right: BorderSide(color: Colors.black, width: 1.5),
          )
      ),
      child: Column(
        /*children: <Widget>[
          //
          // Seventh row
          generateJobPersonRow("John Smith", "Judge", 11),
          //
          // Eighth row
          generateJobPersonRow("James Jones", "Invigilator", 12),
          //
          // Eighth row
          generateJobPersonRow("Sue Smith", "Emcee", 13)
        ],*/
        children: _children,
      )
    );
  }

  Widget generateJobPanel(String jobPanelId, String heatRange, DateTime start, DateTime end, persons) {
    return Column(
      children: <Widget>[
        //
        // Second row
        Container(
            padding: EdgeInsets.only(right: 15.0, left: 25.0),
            margin: EdgeInsets.only(top: 2.0),
            constraints: BoxConstraints(minHeight: 50.0),
            decoration: BoxDecoration(
              color: Color(0xfffd9126),
              border: Border(
                bottom: BorderSide(color: Colors.black, width: 1.0)
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 0,
                          child: Container(
                            width: 245.0,
                            child: Text("Job Panel ${jobPanelId}", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text("Heats ${heatRange}", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ],
                    )
                ),
                Container(
                  //color: Colors.amber,
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        //Text("9:00 AM to 10:15 AM", style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w800)),
                        RichText(
                          text: new TextSpan(
                            text: "${_hrFormat.format(start)}",
                            style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w800),
                            children: <TextSpan>[
                              new TextSpan(
                                text: "${_amFormat.format(start)}",
                                style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w800)
                              ),
                              new TextSpan(
                                  text: " to ${_hrFormat.format(end)}",
                                  style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w800)
                              ),
                              new TextSpan(
                                  text: "${_amFormat.format(end)}",
                                  style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w800)
                              ),
                            ]
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          /*child: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: Color(0xff40a334),
                            child: Container(
                              //padding: const EdgeInsets.symmetric(
                              //    horizontal: 2.0, vertical: 2.0),
                              child: new Icon(Icons.add, size: 22.0),
                              //child: Text("+", style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w800)),
                            ),
                          )*/
                          child: JobPanelPlusBtn(btnState: jobPanelToggle[jobPanelId] ,onTap: (){
                            setState(() {
                              if(!jobPanelToggle[jobPanelId]) {
                                jobPanelToggle[jobPanelId] = true;
                              } else {
                                jobPanelToggle[jobPanelId] = false;
                              }
                            });
                          }),
                        )
                      ],
                    )
                ),
              ],
            )
        ),
        // if toggle is true
        (jobPanelToggle[jobPanelId]) ? generateJobPanelContent(persons) : Container()
      ],
    );
  }

  Widget jobPanelAndHeats() {
    List<Widget> _children = [];
    for(JobPanelData j in jobPanels) {
      //print("ID[${j.id}] PANEL TIME START-END: ${j.time_start} - ${j.time_end}");
      //print("HEAT START: ${j.heat_start} - HEAT END: ${j.heat_end}");
      _children.add(generateJobPanel(j.id, "${j.heat_start}-${j.heat_end}", j.time_start, j.time_end, j.panel_persons));
      bool _isColr = false;
      for(var heatData in j.heats) {
        //print("[${heatData.id}] ${heatData.time_start} TIMESLOT: ${_hrFormat.format(heatData.time_start)} ${_amFormat.format(heatData.time_start)}");
        //print("HEAT ID[${heatData.id}] started = ${heatData.isStarted}");
        _children.add(JobPanelHeatRow("${_hrFormat.format(heatData.time_start)}", "${_amFormat.format(heatData.time_start)}", heatData.id, heatData.heat_title, _isColr, coupleRowToggle, heatRowToggle, heatData.sub_heats, heatData.isStarted));
        _isColr = (_isColr) ? false : true;
      }
    }

    return Column(
      /*children: <Widget>[
        generateJobPanel("1", "1-15"),
        JobPanelHeatRow("9:00", "AM", "1", false, coupleRowToggle, heatRowToggle),
        //
        // Fourth row
        JobPanelHeatRow("9:00", "AM", "2", true, coupleRowToggle, heatRowToggle),
        //
        // Fifth row
        JobPanelHeatRow("11:53", "AM", "3", false, coupleRowToggle, heatRowToggle),
        //
        // Sixth row
        generateJobPanel("2", "16-45"),
      ],*/
      children: _children,
    );
  }

  void sleepTimer(milisec, function) {
    Future.delayed(Duration(milliseconds: milisec), function);
  }

  @override
  Widget build(BuildContext context) {

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

    /*if(!_isLoading && (jobPanels == null || jobPanels.length <= 0)) {
      _isLoading = true;
      sleepTimer(200, () => MainFrameLoadingIndicator.showLoading(context));
    }

    if(jobPanels.length > 0) {
      _isLoading = false;
      sleepTimer(500, () => MainFrameLoadingIndicator.hideLoading(context));
    }*/

    return Column(
      children: <Widget>[
        Container(
            color: Colors.black,
            height: 60.0,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text("${headerTxt}: ${pname.toUpperCase()}", style: TextStyle(fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.w700)),
                ),
                Expanded(
                  child: JobPanelTime()
                )
              ],
            )
        ),
        Container(
          padding: EdgeInsets.only(left: 2.0, right: 12.0, top: 12.0, bottom: 12.0),
          //padding: EdgeInsets.all(12.0),
          //color: Colors.amber,
          height: 70.0,
          child: Row(
            children: <Widget>[
              //Expanded(child: Container(color: Colors.white))
              Expanded(
                //child: JobPanelHeaderBtn("Job Panel", btnColor: Color(0xff2f4c5d), txtColor: Colors.white),
                child: JobPanelHeaderBtn("Job Panel"),
              ),
              Expanded(
                child: JobPanelHeaderBtn("Next Heat"),
              ),
              Expanded(
                child: JobPanelHeaderBtn("Manage Couple", fontSize: 18.0, onTap: (){
                  // Manage Couple Screen
                  Navigator.pushNamed(context, "/manageCouple");
                }),
              ),
              Expanded(
                child: JobPanelHeaderBtn("Mode Change", fontSize: 18.0, onTap: (){
                  Navigator.popUntil(context, ModalRoute.withName("/deviceMode"));
                }),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            //padding: EdgeInsets.symmetric(horizontal: 4.0),
            //color: Colors.blue,
            child: ListView(
              children: <Widget>[
                //
                // First row
                Container(
                    padding: EdgeInsets.only(right: 25.0, left: 25.0),
                    color: Color(0xffE0D37D),
                    constraints: BoxConstraints(minHeight: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Text("Saturday December 15, 2019", style: TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.w700)),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text("Session 1", style: TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.w700)),
                        ),
                      ],
                    )
                ),
                //
                // Second row
            (jobPanels == null || jobPanels.length <= 0) ? Container(padding: EdgeInsets.only(left: 10.0, top: 10.0), child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[CircularProgressIndicator(), Container(padding: EdgeInsets.only(left: 10.0), child: Text("LOADING..."))]))) : jobPanelAndHeats()
              ],
            ),
          ),
        )
      ],
    );
  }
}