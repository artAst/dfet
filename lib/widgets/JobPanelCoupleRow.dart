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

class JobPanelCoupleRow extends StatefulWidget {

  bool isEven;
  String col1;
  String col2;
  String col3;
  var coupleData;
  Map<String, bool> coupleRowToggle;
  bool isScratched;

  JobPanelCoupleRow(this.col1, this.col2, this.col3, this.isEven, this.coupleRowToggle, this.isScratched, this.coupleData);

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
                            decoration: BoxDecoration(
                                color: Color(0xff47616b),
                                border: Border.all()
                            ),
                            constraints: BoxConstraints(minWidth: 120.0),
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: Text("${widget.coupleData.participant1.level.toString().replaceAll("ParticipantLevel.", "")}", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Color(0xffedf7f9),
                                border: Border.all()
                            ),
                            constraints: BoxConstraints(minWidth: 140.0),
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: Text("${widget.coupleData.participant1.first_name} ${widget.coupleData.participant1.last_name}", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500))
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
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
                            decoration: BoxDecoration(
                                color: Color(0xffedf7f9),
                                border: Border.all()
                            ),
                            constraints: BoxConstraints(minWidth: 140.0),
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: Text("${widget.coupleData.participant2.first_name} ${widget.coupleData.participant2.last_name}", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500))
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                                color: Color(0xff47616b),
                                border: Border.all()
                            ),
                            constraints: BoxConstraints(minWidth: 120.0),
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: Text("Booked Heats", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Color(0xffedf7f9),
                                border: Border.all()
                            ),
                             constraints: BoxConstraints(minWidth: 140.0),
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: Text("120", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500))
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
                          decoration: BoxDecoration(
                              color: Color(0xff47616b),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(minWidth: 120.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("Level", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xffedf7f9),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(minWidth: 140.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("${widget.coupleData.couple_level}", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500))
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xff47616b),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(minWidth: 120.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("Studio", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xffedf7f9),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(minWidth: 140.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("${widget.coupleData.studio}", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500))
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xff47616b),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(minWidth: 120.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("Danced Heats", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xffedf7f9),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(minWidth: 140.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("14", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500))
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xff47616b),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(minWidth: 120.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("Future Heats", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xffedf7f9),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(minWidth: 140.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("03", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500))
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xff47616b),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(minWidth: 120.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("Total Heats", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xffedf7f9),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(minWidth: 140.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("17", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500))
                      ),
                    ],
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xff47616b),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(minWidth: 120.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("Age", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xffedf7f9),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(minWidth: 140.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("${widget.coupleData.age_category}", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500))
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  constraints: BoxConstraints(minWidth: 150.0),
                  child: new DanceFrameButton(
                    text: (!widget.isScratched) ? "SCRATCH" : "UNSCRATCH",
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
    Preferences.getSharedValue("rpi1").then((val){
      String confValue = val;
      confValue = confValue.replaceAll("http://", "");
      confValue = confValue.replaceAll("https://", "");
      if(confValue != null) {
        baseUri = confValue;
      }
    });
  }

  void scratchBtnClicked() {
    //print("isScratched: ${widget.isScratched}");
    if(!widget.isScratched) {
      MainFrameLoadingIndicator.showLoading(context);
      ScreenUtil.showScratchDialog(context, (val) {
        print("val: $val");
        setState(() {
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
          print("HeatCouple entryId: ${hc.entry_id}");
          HttpUtil.postRequest(context, protocol + baseUri + "/uberPlatform/heat/entry/id/${hc.entry_id}/status/2", {});
        });
      });
    } else {
      // unscratch functionality not yet implemented
      ScreenUtil.showMainFrameDialog(context, "Work in progress", "Unscratch funtionality work in progress. Thanks");
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
                    child: Text("${(widget.isScratched) ? "X " : ""}| ${widget.col1} | ${widget.col2} | ${widget.col3}", style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w500)),
                  ),
                ),
                JobPanelOnFloorDeck(j_onDeck: widget.coupleData.onDeck, j_onFloor: widget.coupleData.onFloor, entryId: widget.coupleData.entry_id),
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