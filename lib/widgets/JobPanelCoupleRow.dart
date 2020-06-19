import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'JobPanelPlusBtn.dart';
import 'JobPanelOnFloorDeck.dart';
import 'package:danceframe_et/util/ScreenUtil.dart';
import 'package:danceframe_et/dao/JobPanelDataDao.dart';
import 'package:danceframe_et/model/HeatCouple.dart';
import 'package:danceframe_et/widgets/LoadingIndicator.dart';
import 'package:danceframe_et/widgets/JobPanel.dart' as job_panel;
import 'package:danceframe_et/util/HttpUtil.dart';
import 'package:danceframe_et/util/Preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:danceframe_et/websocket/DanceFrameCommunication.dart';
import 'package:danceframe_et/model/config/DeviceConfig.dart';

class JobPanelCoupleRow extends StatefulWidget {

  bool isEven;
  String col1;
  String col2;
  String col3;
  String subHeatAge;
  var coupleData;
  Map<String, bool> coupleRowToggle;
  bool isScratched;

  JobPanelCoupleRow(this.col1, this.col2, this.col3, this.subHeatAge, this.isEven, this.coupleRowToggle, this.isScratched, this.coupleData);

  @override
  _JobPanelCoupleRowState createState() => new _JobPanelCoupleRowState();
}

class _JobPanelCoupleRowState extends State<JobPanelCoupleRow> {
  String baseUri = "";
  String protocol = "https://";

  Widget generateCoupleContent() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(bottom: 3.0),
                            decoration: BoxDecoration(
                                color: Color(0xff47616b),
                                border: Border.all()
                            ),
                            constraints: BoxConstraints(maxWidth: 120.0),
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: Text("${widget.coupleData.participant1.level.toString().replaceAll("ParticipantLevel.", "")}", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                        ),
                        Container(
                           margin: EdgeInsets.only(bottom: 3.0),
                            decoration: BoxDecoration(
                                color: Color(0xffedf7f9),
                                border: Border.all()
                            ),
                            constraints: BoxConstraints(maxWidth: 180.0),
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              "${widget.coupleData.participant1.first_name} ${widget.coupleData.participant1.last_name}", 
                              style: TextStyle(
                                fontSize: 14.0, 
                                color: Colors.black, 
                                fontWeight: FontWeight.w500
                              ),
                               maxLines:1,
                               textAlign: TextAlign.center
                            )
                        ),
                        
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                         Container(
                           margin: EdgeInsets.only(bottom: 3.0),
                              decoration: BoxDecoration(
                                  color: Color(0xff47616b),
                                  border: Border.all()
                              ),
                              constraints: BoxConstraints(minWidth: 120.0),
                              padding: EdgeInsets.all(5.0),
                              alignment: Alignment.center,
                              child: Text("${widget.coupleData.participant2.level.toString().replaceAll("ParticipantLevel.", "")}", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                          ),
                       
                        Container(
                          margin: EdgeInsets.only(bottom: 3.0),
                            decoration: BoxDecoration(
                                color: Color(0xffedf7f9),
                                border: Border.all()
                            ),
                            constraints: BoxConstraints(maxWidth: 180.0),
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: AutoSizeText("${widget.coupleData.participant2.first_name} ${widget.coupleData.participant2.last_name}", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500),
                             maxLines:1,
                               textAlign: TextAlign.center)
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        FittedBox(
                               child: Container(
                                 margin: EdgeInsets.only(bottom: 3.0),
                              decoration: BoxDecoration(
                                  color: Color(0xff47616b),
                                  border: Border.all()
                              ),
                              constraints: BoxConstraints(maxWidth: 120.0),
                              padding: EdgeInsets.all(5.0),
                              alignment: Alignment.center,
                              child: Text("Booked Heats ", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 3.0),
                            decoration: BoxDecoration(
                                color: Color(0xffedf7f9),
                                border: Border.all()
                            ),
                             constraints: BoxConstraints(maxWidth: 180.0),
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: AutoSizeText("${widget.coupleData?.booked}", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500),  maxLines:1,
                               textAlign: TextAlign.center)
                        ),
                      ],
                    ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 3.0),
                          decoration: BoxDecoration(
                              color: Color(0xff47616b),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(maxWidth: 120.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("Level", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 3.0),
                          decoration: BoxDecoration(
                              color: Color(0xffedf7f9),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(maxWidth: 180.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: AutoSizeText("${widget.coupleData.couple_level} test", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500) , maxLines:1,
                               textAlign: TextAlign.center)
                      ),
                    ],
                  ),
                     Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 3.0),
                          decoration: BoxDecoration(
                              color: Color(0xff47616b),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(maxWidth: 120.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("Studio", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 3.0),
                          decoration: BoxDecoration(
                              color: Color(0xffedf7f9),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(maxWidth: 180.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: AutoSizeText("${widget.coupleData.studio}", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500),  maxLines:1,
                               textAlign: TextAlign.center)
                      ),
                    ],
                  ),
                  ],
                ),
              ),
              //Padding(padding: EdgeInsets.only(left: 10.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 3.0),
                            decoration: BoxDecoration(
                                color: Color(0xff47616b),
                                border: Border.all()
                            ),
                            constraints: BoxConstraints(maxWidth: 120.0),
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: Text("Age", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 3.0),
                            decoration: BoxDecoration(
                                color: Color(0xffedf7f9),
                                border: Border.all()
                            ),
                            constraints: BoxConstraints(maxWidth: 180.0),
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: AutoSizeText("${widget.coupleData.age_category}", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500),  maxLines:1,
                                textAlign: TextAlign.center)
                        ),
                      ],
                    ),
                  
                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 3.0),
                          decoration: BoxDecoration(
                              color: Color(0xff47616b),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(maxWidth: 120.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("Danced Heats", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 3.0),
                          decoration: BoxDecoration(
                              color: Color(0xffedf7f9),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(maxWidth: 180.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: AutoSizeText("${widget.coupleData?.danced}", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500),  maxLines:1,
                               textAlign: TextAlign.center)
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 3.0),
                          decoration: BoxDecoration(
                              color: Color(0xff47616b),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(maxWidth: 120.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("Future Heats", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 3.0),
                          decoration: BoxDecoration(
                              color: Color(0xffedf7f9),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(maxWidth: 180.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: AutoSizeText("${widget.coupleData?.future}", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500),  maxLines:1,
                               textAlign: TextAlign.center)
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 3.0),
                          decoration: BoxDecoration(
                              color: Color(0xff47616b),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(maxWidth: 120.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("Scratched", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 3.0),
                          decoration: BoxDecoration(
                              color: Color(0xffedf7f9),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(maxWidth: 180.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: AutoSizeText("${widget.coupleData?.scratched}", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500),  maxLines:1,
                               textAlign: TextAlign.center)
                      ),
                    ],
                  ),
                ],
              ),

              
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  constraints: BoxConstraints(minWidth: 150.0),
                  child: new DanceFrameButton(
                    height: 60.0,
                    width: 125.0,
                    letterSpacingBottom: 10.0,
                    textSpanText: 'CHANGE TO\n',
                    text: (!widget.isScratched) ? "ACTIVE" : "SCRATCHED",
                    onPressed: scratchBtnClicked,
                  )
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*Preferences.getSharedValue("rpi1").then((val){
      String confValue = val;
      confValue = confValue.replaceAll("http://", "");
      confValue = confValue.replaceAll("https://", "");
      if(confValue != null) {
        baseUri = confValue;
      }
    });*/
  }

  void sendRequest(entryId, coupleKey, heatId, sessionId, status, operation) {
    game.send(
        {
          "deviceId":DeviceConfig.deviceNum,
          "operation":operation,
          "broadcast":"all",
          "onDeckFloor":null,
          "scratch":{
            "entryId":int.parse(entryId),
            "coupleKey":coupleKey,
            "heatId":heatId,
            "session":sessionId,
            "status":status
          }
        }
    );
  }

  void scratchBtnClicked() {
    //print("isScratched: ${widget.isScratched}");
    if(!widget.isScratched) {
      //MainFrameLoadingIndicator.showLoading(context);
      ScreenUtil.showScratchDialog(context, (val) {
        print("val: $val");
        HeatCouple hc = widget.coupleData;
        setState(() {
          widget.isScratched = true;
        });
        if(val == "this_heat") {
          sendRequest(hc.entry_id, hc.couple_tag, 0, 0, 2, "scratch-byentry");
        }
        else if(val == "today_heats") {
          sendRequest("0", hc.couple_tag, 1, 1, 2, "scratch-bysession");
        }
        else if(val == "all_heats") {
          sendRequest("0", hc.couple_tag, 1, 1, 2, "scratch-allsession");
        }

        /*setState(() {
          if (val != null) {
            widget.isScratched = true;
          }
          HeatCouple hc = widget.coupleData;
          hc.is_scratched = true;
          print("HEATCOUPLE: ${hc.saveMap()}");
          //MainFrameLoadingIndicator.hideLoading(context);
          JobPanelDataDao.updateHeatCouple_pi(hc).then((id){
            // reload JobPanelData
            /*JobPanelDataDao.getAllJobPanelData().then((jp){
              print("JobPanel: ${jp?.length}");
              setState(() {
                if(jp != null) {
                  job_panel.jobPanels = jp;
                }
              });
            });*/
          });
          print("HeatCouple =: ${hc.entry_id}");
          HttpUtil.postRequest(context, protocol + baseUri + "/uberPlatform/heat/entry/id/${hc.entry_id}/status/2", {});
        });*/
      },
      isScratch: true,
      
      );
    } else {
      ScreenUtil.showScratchDialog(context, (val) {
        print("val: $val");
//        setState(() {
//          if (val != null) {
//            widget.isScratched = false;
//          }
        HeatCouple hc = widget.coupleData;
        setState(() {
          widget.isScratched = false;
        });
        if(val == "this_heat") {
          sendRequest(hc.entry_id, hc.couple_tag, 0, 0, 1, "scratch-byentry");
        }
        else if(val == "today_heats") {
          sendRequest("0", hc.couple_tag, 1, 1, 1, "scratch-bysession");
        }
        else if(val == "all_heats") {
          sendRequest("0", hc.couple_tag, 1, 1, 1, "scratch-allsession");
        }

          /*HeatCouple hc = widget.coupleData;
          hc.is_scratched = false;
          print("HEATCOUPLE: ${hc.saveMap()}");
          MainFrameLoadingIndicator.showLoading(context);
          JobPanelDataDao.updateHeatCouple_pi(hc).then((id){
            print("successfully updated!");
            print("HeatCouple =: ${hc.entry_id}");
            HttpUtil.postRequest(context, protocol + baseUri + "/uberPlatform/heat/entry/id/${hc.entry_id}/status/1", {});
            MainFrameLoadingIndicator.hideLoading(context);
          });
          */
//        });
      },
      isScratch: false,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 15.0, left: 25.0, top: 5.0, bottom: 5.0),
        color: (!widget.isEven) ? Color(0xffedf7f9) : Color(0xffa3d5e4),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("${(widget.isScratched) ? "X " : ""}| ${widget.col2} | ${widget.subHeatAge} | ${widget.col3}", style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w500)),
                  ),
                ),
//                JobPanelOnFloorDeck(j_onDeck: widget.coupleData.onDeck, j_onFloor: widget.coupleData.onFloor, entryId: widget.coupleData.entry_id, coupleKey: widget.coupleData.couple_tag),
                JobPanelOnFloorDeck(
                  onTap: (toggleOnDeck, toggleOnFloor) {
                    if(toggleOnDeck && toggleOnFloor) {
                      widget.coupleData.onDeck = toggleOnDeck;
                      widget.coupleData.onFloor = toggleOnFloor;
                    }else if(toggleOnDeck) {
                      widget.coupleData.onDeck = toggleOnDeck;
                      widget.coupleData.onFloor = false;
                    }else if(toggleOnFloor) {
                      widget.coupleData.onDeck = false;
                      widget.coupleData.onFloor = toggleOnFloor;
                    }else{
                      widget.coupleData.onDeck = false;
                      widget.coupleData.onFloor = false;
                    }
                  },
                  onDeck: widget.coupleData.onDeck,
                  onFloor: widget.coupleData.onFloor,
                  entryId: widget.coupleData.entry_id,
                  coupleKey: widget.coupleData.couple_tag
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: JobPanelPlusBtn(btnState: widget.coupleRowToggle[widget.col1] ,onTap: (){
                    setState(() {
                      if(!widget.coupleRowToggle[widget.col1]) {
                        widget.coupleRowToggle[widget.col1] = true;
                      } else {
                        widget.coupleRowToggle[widget.col1] = false;
                      }
                    });
                  })
                )
              ],
            ),
            // COUPLE CONTENT CONTAINER
            (widget.coupleRowToggle[widget.col1]) ? generateCoupleContent() : Container()
          ],
        )
    );
  }
}