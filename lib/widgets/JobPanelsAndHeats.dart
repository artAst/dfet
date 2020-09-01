import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:danceframe_et/model/JobPanelData.dart';
import 'JobPanelPlusBtn.dart';
import 'JobPanelHeatRow.dart';
import 'package:danceframe_et/dao/JobPanelDao.dart';
import 'package:danceframe_et/screens/device_mode.dart' as mode;
import 'package:danceframe_et/util/ScreenUtil.dart';
import 'package:danceframe_et/enums/AcessPermissions.dart';
import 'package:danceframe_et/enums/UserProfiles.dart';
import 'package:danceframe_et/model/config/Global4Config.dart';

class JobPanelsAndHeats extends StatefulWidget {

  Map<String, bool> jobPanelToggle;
  List<JobPanelData> jobPanels;
  Map<String, bool> heatRowToggle;
  Map<String, bool> coupleRowToggle;

  JobPanelsAndHeats({this.jobPanelToggle, this.jobPanels, this.heatRowToggle, this.coupleRowToggle});

  @override
  _JobPanelsAndHeatsState createState() => new _JobPanelsAndHeatsState();
}

class _JobPanelsAndHeatsState extends State<JobPanelsAndHeats> {
  DateFormat _hrFormat = new DateFormat("h:mm");
  DateFormat _amFormat = new DateFormat("a");

  Stopwatch watch = Stopwatch();
  List _personsList = [];

  List<JobPanelData> data_jpanels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data_jpanels = [];
    setState(() {
      //print("widget.jobPanels: ${widget.jobPanels.length}");
      for(JobPanelData j in widget.jobPanels) {
        /*JobPanelData d = new JobPanelData(
            heat_start: j.heat_start,
            heat_end: j.heat_end,
            panel_order: j.panel_order,
            panel_persons: j.panel_persons,
            time_start: j.time_start,
            time_end: j.time_end
        );*/
        JobPanelData d = j;
        int cnt = 0;
        /*d.heats = [];
        for(var heatData in j.heats) {
          if(cnt == 14) {
            break;
          }
          d.heats.add(heatData);
          cnt++;
        }*/
        //print("d.heats: ${d.heats.length}");
        data_jpanels.add(d);
      }
      //print("data_jpanels: ${data_jpanels.length}");
    });
  }

  bool judgingPanelAccess() {
    List<UserProfiles> accessProf = List.of(Global4Config.rolePermissions[AccessPermissions.SCHEDULE_JUDGING_PANEL]);
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 200.0,
                  // color: Colors.red,
                  child: Text("Job Panel ${jobPanelId}", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700)),
                ),

                Container(
                  width: 200.0,
                  // color: Colors.red,
                  child: Text("Heats ${heatRange}", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700)),
                ),

                Container(
                  child: Row(
                    children: <Widget>[
                      RichText(
                          text: new TextSpan(
                              text: "${_hrFormat.format(start)}",
                              style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w800),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: "${_amFormat.format(start)}",
                                    style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w800)
                                ),
                                new TextSpan(
                                    text: " to ${_hrFormat.format(end)}",
                                    style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w800)
                                ),
                                new TextSpan(
                                    text: "${_amFormat.format(end)}",
                                    style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w800)
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
                        child: JobPanelPlusBtn(btnState: widget.jobPanelToggle[jobPanelId] ,onTap: (){
                          if(judgingPanelAccess()) {
                            setState(() {
                              if(!widget.jobPanelToggle[jobPanelId]) {
                                widget.jobPanelToggle[jobPanelId] = true;
                                JobPanelDao.getPersonDataByPanelId(jobPanelId).then((persons) {
                                  print("PERSONS LENGTH: ${persons.length}");
                                  setState(() {
                                    _personsList = [];
                                    _personsList.addAll(persons);
                                  });
                                });
                              } else {
                                widget.jobPanelToggle[jobPanelId] = false;
                              }
                            });
                          }
                        }),
                      ),
                    ],
                  ),
                ),

              ],
            )
        ),
        // if toggle is true
        (widget.jobPanelToggle[jobPanelId]) ? generateJobPanelContent(jobPanelId) : Container()
        //(widget.jobPanelToggle[jobPanelId]) ? Container(child: Text("TEST")) : Container()
      ],
    );
  }

  Widget loadingIndicator() => Center(
    child: Container(
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
    ),
  );

  Widget generateJobPanelContent(jobPanelId) {
    List<Widget> _children = [];

    if(_personsList != null && _personsList.isNotEmpty) {
      for (var p in _personsList) {
        String role = p.user_roles[0].toString()
            .replaceAll("UserProfiles.", "")
            .replaceAll("_", " ");
        _children.add(
            generateJobPersonRow("${p.first_name} ${p.last_name}", role, p.id));
      }
    } else {
      _children.add(Container());
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
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

  void sleepTimer(milisec, function) {
    Future.delayed(Duration(milliseconds: milisec), function);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [];
    //print("data_jpanels length: ${data_jpanels.length}");
    for(JobPanelData j in widget.jobPanels) {
      //print("ID[${j.id}] PANEL TIME START-END: ${j.time_start} - ${j.time_end}");
      //print("HEAT START: ${j.heat_start} - HEAT END: ${j.heat_end}");
      _children.add(generateJobPanel(j.id, "${j.heat_start}-${j.heat_end}", j.time_start, j.time_end, j.panel_persons));
      bool _isColr = false;
      int cnt = 0;
      //for(var heatData in j.heats) {
      for(int x=0; x < j.heats.length; x++) {
        var heatData = j.heats[x];
        String heatNextId = "-1";
        String nextHeatIdPlus = "-1";
        if((x+1) < j.heats.length) {
          heatNextId = j.heats[x+1].id;
        }
        if((x+2) < j.heats.length) {
          nextHeatIdPlus = j.heats[x+2].id;
        }
        //if(cnt < 14) {
          _children.add(JobPanelHeatRow("${_hrFormat.format(heatData.time_start)}", "${_amFormat.format(heatData.time_start)}", heatData.id, heatNextId, nextHeatIdPlus, heatData.heat_title, _isColr, widget.coupleRowToggle, widget.heatRowToggle, heatData.sub_heats, heatData.isStarted));
        //}
        //print("[${heatData.id}] ${heatData.time_start} TIMESLOT: ${_hrFormat.format(heatData.time_start)} ${_amFormat.format(heatData.time_start)}");
        //print("HEAT ID[${heatData.id}] started = ${heatData.isStarted}");
        _isColr = (_isColr) ? false : true;
        cnt++;
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
}