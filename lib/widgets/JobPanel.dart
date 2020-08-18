import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'JobPanelHeaderBtn.dart';
import 'JobPanelTime.dart';
import 'JobPanelHeatRow.dart';
import 'JobPanelPlusBtn.dart';
import 'JobPanelsAndHeats.dart';
import 'package:danceframe_et/dao/JobPanelDataDao.dart';
import 'package:danceframe_et/dao/JobPanelDao.dart';
import 'package:danceframe_et/model/JobPanelData.dart';
import 'package:danceframe_et/model/HeatData.dart';
import 'package:danceframe_et/widgets/LoadingIndicator.dart';
import 'package:intl/intl.dart';
import 'package:danceframe_et/util/Preferences.dart';
import 'package:danceframe_et/model/Person.dart';
import 'package:danceframe_et/enums/AcessPermissions.dart';
import 'package:danceframe_et/enums/UserProfiles.dart';
//import 'package:danceframe_et/model/ws/EntryData.dart';
import 'package:danceframe_et/screens/device_mode.dart' as mode;
import 'package:danceframe_et/util/ScreenUtil.dart';
import 'package:danceframe_et/model/config/DeviceConfig.dart';
import 'package:danceframe_et/model/config/Global4Config.dart';

List<JobPanelData> jobPanels;
class JobPanel extends StatefulWidget {
  @override
  _JobPanelState createState() => new _JobPanelState();
}

class _JobPanelState extends State<JobPanel> {
  Person p;

  Map<String, bool> jobPanelToggle = {};
  Map<String, bool> heatRowToggle = {};
  Map<String, bool> coupleRowToggle = {};

  Stopwatch watch = Stopwatch();
  Timer _t;
  List<JobPanelData> _lazyJobPanels;

  /*void _onMessageRecieved(message) {
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
  }*/

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
    /*Preferences.getSharedValue("deviceNumber").then((val){
      game.playerId = val;
      game.addListener(_onMessageRecieved);
    });*/

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

    watch.reset();
    watch.start();
    _lazyJobPanels = [];
    JobPanelDao.loadAllPanels((jp, isLast){
      watch.stop();
      var timeSoFar = watch.elapsedMilliseconds;
      print("islast{$isLast}  Elapsed time{${timeSoFar}ms} Load JobPanels: ${jp.saveMap()}");
      if(!isLast) {
        watch.reset();
        watch.start();
      }
      //setState(() {
        if (jp != null) {
          //jobPanels.add(jp);
          _lazyJobPanels.add(jp);
//          JobPanelData d = new JobPanelData(
//            time_start: jp.time_start,
//            time_end: jp.time_end,
//            panel_persons: jp.panel_persons,
//            panel_order: jp.panel_order,
//            heat_end: jp.heat_end,
//            heat_start: jp.heat_start,
//          );
//          d.id = jp.id;
//          int cnt = 0;
//          int cnt2 = 0;
//          d.heats = [];
//          List<HeatData> timerHeats = [];
//          for(var hData in jp.heats) {
//            if(cnt < 14) {
//              d.heats.add(hData);
//            }
//            else if(cnt2 < 14) {
//              cnt2++;
//              timerHeats.add(hData);
//            }
//            cnt++;
//          }
//          print("TimerHeats length: ${timerHeats.length}");
//          jobPanels.add(d);
        }
        jobPanelsLazyLoad(isLast);
      //});
    });
    //JobPanelDataDao.getAllJobPanelData().then((jp){
    /*JobPanelDataDao.getAllJobPanelData_pi().then((jp){
      watch.stop();
      var timeSoFar = watch.elapsedMilliseconds;
      print("Load JobPanels: ${jp?.length} Elapsed time: ${timeSoFar}ms");
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
    });*/
  }

  void setToggles() {
    for (JobPanelData _j in jobPanels) {
      jobPanelToggle[_j.id] = false;
      if (_j.heats != null && _j.heats.isNotEmpty) {
        for (var _h in _j.heats) {
          heatRowToggle[_h.id] = false;
          if (_h.sub_heats != null && _h.sub_heats.isNotEmpty) {
            for (var _sh in _h.sub_heats) {
              //print("---------------subHeat: ${_sh.toMap()}");
              for (var _c in _sh?.couples) {
                coupleRowToggle[_c.id] = false;
              }
            }
          }
        }
      }
    }
  }

  void jobPanelsLazyLoad(bool isLast) {
    //print("lazyJobPanels length: ${_lazyJobPanels.length}");
    if(jobPanels.isEmpty && _lazyJobPanels.isNotEmpty) {
      // initial load
      setState(() {
        JobPanelData d = new JobPanelData();
        for(JobPanelData jp in _lazyJobPanels) {
          d = new JobPanelData(
            time_start: jp.time_start,
            time_end: jp.time_end,
            panel_persons: jp.panel_persons,
            panel_order: jp.panel_order,
            heat_end: jp.heat_end,
            heat_start: jp.heat_start,
          );
          d.id = jp.id;
          d.heats = [];
          if(jp.heats.length > 14) {
            int cnt = 0;
            for (HeatData heatData in jp.heats) {
              if(cnt < 14) {
                d.heats.add(heatData);
              } else {
                break;
              }
              cnt++;
            }
          } else {
            d.heats = jp.heats;
          }
        }
        jobPanels.add(d);
        setToggles();
      });
    } else {
      // lazy load
      if(_t == null && isLast) {
        _t = new Timer(Duration(milliseconds: 500), () {
          print("EXECUTING LAZY LOAD....");
          setState(() {
            jobPanels = [];
            jobPanels.addAll(_lazyJobPanels);
            setToggles();
          });
        });
      }
    }
  }

  void sleepTimer(milisec, function) {
    Future.delayed(Duration(milliseconds: milisec), function);
  }

  bool hasAccess(AccessPermissions access) {
    //List<UserProfiles> userProf = List.of(p.user_roles);
    List<UserProfiles> accessProf = List.of(Global4Config.rolePermissions[access]);
    //for(UserProfiles p in userProf) {
      if(accessProf.contains(mode.role)) {
        // has access to scratch competitors
        print("HAS ACCESS: ${mode.role}, GLOBAL: ${accessProf}");
        return true;
      }
    //}
    print("NO ACCESS: ${mode.role}, GLOBAL: ${accessProf}");
    ScreenUtil.showMainFrameDialog(context, "No Access", "You dont have permission to Scratch/Unscratch Competitors");
    return false;
  }

  @override
  Widget build(BuildContext context) {

    String headerTxt = "";
    String pname = "";
    if(p != null) {
      if(p.user_roles.isNotEmpty) {
        for(var _urole in p.user_roles) {
          //print("UROLE: $_urole || mode_role: ${mode.role}");
          headerTxt = _urole.toString()
              .replaceAll("UserProfiles.", "")
              .replaceAll("_", " ");
          if(_urole == mode.role) {
            break;
          }
        }
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
    //print("jobPanels LENGTH: ${jobPanels.length}");
    Widget jpnh = JobPanelsAndHeats(jobPanelToggle: jobPanelToggle, coupleRowToggle: coupleRowToggle, heatRowToggle: heatRowToggle, jobPanels: jobPanels);
    //Widget jpnh = new Container();

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
                child: JobPanelHeaderBtn("Job Panel", onTap: (){
                  if(hasAccess(AccessPermissions.SCHEDULE_JUDGING_PANEL)) {
                    print("ADD JOB PANEL");
                  }
                }),
              ),
              Expanded(
                child: JobPanelHeaderBtn("Next Heat"),
              ),
              Expanded(
                child: JobPanelHeaderBtn("Manage Couple", fontSize: 18.0, onTap: (){
                  if(hasAccess(AccessPermissions.MANAGE_COUPLE)) {
                    // Manage Couple Screen
                    Navigator.pushNamed(context, "/manageCouple");
                  }
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
                (jobPanels == null || jobPanels.length <= 0) ?
                    Container(
                      padding: EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(),
                            Container(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text("LOADING...")
                            )
                          ]
                        )
                      )
                    ) : jpnh
              ],
            ),
          ),
        )
      ],
    );
  }
}