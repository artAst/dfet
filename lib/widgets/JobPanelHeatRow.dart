import 'package:flutter/material.dart';
import 'JobPanelCoupleRow.dart';
import 'JobPanelPlusBtn.dart';
import 'JobPanelStartedBtn.dart';
import 'package:danceframe_et/dao/JobPanelDataDao.dart';
import 'package:danceframe_et/websocket/DanceFrameCommunication.dart';
import 'package:danceframe_et/model/config/DeviceConfig.dart';

class JobPanelHeatRow extends StatefulWidget {

  bool isColor;
  String timeSlot;
  String timePeriod;
  String heatRowId;
  String heatTitle;
  bool isStarted;
  var subHeats;
  Map<String, bool> coupleRowToggle;
  Map<String, bool> heatRowToggle;

  JobPanelHeatRow(this.timeSlot, this.timePeriod, this.heatRowId, this.heatTitle, this.isColor, this.coupleRowToggle, this.heatRowToggle, this.subHeats, this.isStarted);

  @override
  _JobPanelHeatRowState createState() => new _JobPanelHeatRowState();
}

class _JobPanelHeatRowState extends State<JobPanelHeatRow> {

  Widget generateHeatContent() {
    List<Widget> _subheats = [];

    for(var sub in widget.subHeats) {
      List<Widget> _couples = [];
      _couples.add(Container(
          padding: EdgeInsets.only(right: 15.0, left: 25.0),
          color: Color(0xff64a3b1),
          alignment: Alignment.centerLeft,
          constraints: BoxConstraints(minHeight: 40.0),
          child: Row(
            children: <Widget>[
              Text("${sub.sub_title}", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700)),
            ],
          )
      ));
      bool _isColr = false;
      for(var _c in sub.couples) {
        String fullname1 = "${_c.participant1.first_name} ${_c.participant1.last_name}";
        String fullname2 = "${_c.participant2.first_name} ${_c.participant2.last_name}";
        String _coupleTag = _c.couple_tag.substring(0, _c.couple_tag.indexOf("-"));
        //print("entryid[${_c.entry_id}] COUPLE TAG ${_c.couple_tag}");
        //print("total: ${_c.total}");
        //print("sub_heat_age: ${sub.sub_heat_age}");
        _couples.add(JobPanelCoupleRow(_c.id, _coupleTag, "$fullname1 - $fullname2", sub.sub_heat_age, _isColr, widget.coupleRowToggle, _c.is_scratched, _c));
        _isColr = (_isColr) ? false : true;
      }
      _subheats.add(Container(
        //padding: EdgeInsets.only(right: 15.0, left: 25.0),
          margin: EdgeInsets.only(top: 2.0),
          constraints: BoxConstraints(minHeight: 60.0),
          //color: Color(0xfffd9126),
          //color: Colors.amber,
          child: Column(
            children: _couples,
          )
      ));
    }

    return Column(
      /*children: <Widget>[
        Container(
          //padding: EdgeInsets.only(right: 15.0, left: 25.0),
            margin: EdgeInsets.only(top: 2.0),
            constraints: BoxConstraints(minHeight: 60.0),
            //color: Color(0xfffd9126),
            //color: Colors.amber,
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(right: 15.0, left: 25.0),
                    color: Color(0xff64a3b1),
                    alignment: Alignment.centerLeft,
                    constraints: BoxConstraints(minHeight: 40.0),
                    child: Row(
                      children: <Widget>[
                        Text("Newcomer", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700)),
                      ],
                    )
                ),
                JobPanelCoupleRow("153", "L-B1", "Cindy Brown - Mitchel Kibel", false, widget.coupleRowToggle, false),
                JobPanelCoupleRow("169", "L-B1", "Sue Smith - Ryan Wells", true, widget.coupleRowToggle, false),
                JobPanelCoupleRow("116", "G-A1", "David Borrow - Mila Stern", false, widget.coupleRowToggle, false),
                JobPanelCoupleRow("208", "G-C3", "Jack Osmend - Dianne Kelly", true, widget.coupleRowToggle, false),
              ],
            )
        )
      ],*/
      children: _subheats,
    );
  }

  void sendRequest(started) {
    game.send(
//        {
//          "deviceId":DeviceConfig.deviceNum,
//          "operation":operation,
//          "broadcast":"all",
//          "onDeckFloor":null,
//          "scratch":{
//            "entryId":int.parse(entryId),
//            "coupleKey":coupleKey,
//            "heatId":heatId,
//            "session":sessionId,
//            "status":status
//          }
//        }
        {
          "deviceId":DeviceConfig.deviceNum,
          "operation":"update-started",
          "broadcast":"all",
          "onDeckFloor":null,
          "scratch":null,
          "started":{
            "heatId":int.parse(widget.heatRowId),
            "started":started
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    //print("[${widget.heatRowId}] WIDGET TIMESLOT: ${widget.timeSlot} ${widget.timePeriod}");

    return Column(
      children: <Widget>[
        //
        // Third row
        Container(
            padding: EdgeInsets.only(right: 15.0, left: 25.0),
            margin: EdgeInsets.only(top: 2.0),
            constraints: BoxConstraints(minHeight: 60.0),
            decoration: BoxDecoration(
              color: (widget.isColor) ? Color(0xffa3d5e4) : Color(0xff),
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
                          child: Container(
                            //child: Text("${widget.timeSlot} Heat ${widget.heatRowId}", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w500)),
                            child: RichText(
                                text: new TextSpan(
                                    text: "${widget.timeSlot}",
                                    style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w500),
                                    children: <TextSpan>[
                                      new TextSpan(
                                          text: "${widget.timePeriod}",
                                          style: TextStyle(fontSize: 19.0, color: Colors.black, fontWeight: FontWeight.w500)
                                      ),
                                      new TextSpan(
                                          text: " Heat ${widget.heatRowId}",
                                          style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w500)
                                      ),
                                    ]
                                )
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text("${widget.heatTitle}", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ],
                    )
                ),
                Container(
                    alignment: Alignment.centerRight,
                    //color: Colors.amber,
                    constraints: BoxConstraints(minWidth: 252.0),
                    child: Row(
                      children: <Widget>[
                        JobPanelStartedBtn(
                          onTap: (toggle) {
                            // save heat start
                            print("Save heat start: $toggle");
                            widget.isStarted = toggle;
                            sendRequest(toggle);
                            //JobPanelDataDao.saveHeatStarted("heat_started", widget.heatRowId, (toggle ? 1 : 0));
                          },
                          startToggle: widget.isStarted,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: JobPanelPlusBtn(btnState: widget.heatRowToggle[widget.heatRowId] ,onTap: (){
                            setState(() {
                              if(!widget.heatRowToggle[widget.heatRowId]) {
                                widget.heatRowToggle[widget.heatRowId] = true;
                              } else {
                                widget.heatRowToggle[widget.heatRowId] = false;
                              }
                            });
                          })
                        )
                      ],
                    )
                ),
              ],
            )
        ),
        (widget.heatRowToggle[widget.heatRowId]) ? generateHeatContent() : Container()
      ],
    );
  }
}