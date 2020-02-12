import 'package:flutter/material.dart';
import 'JobPanelCoupleRow.dart';
import 'JobPanelPlusBtn.dart';
import 'JobPanelStartedBtn.dart';

class JobPanelHeatRow extends StatefulWidget {

  bool isColor;
  String timeSlot;
  String timePeriod;
  String heatRowId;
  Map<String, bool> coupleRowToggle;
  Map<String, bool> heatRowToggle;

  JobPanelHeatRow(this.timeSlot, this.timePeriod, this.heatRowId, this.isColor, this.coupleRowToggle, this.heatRowToggle);

  @override
  _JobPanelHeatRowState createState() => new _JobPanelHeatRowState();
}

class _JobPanelHeatRowState extends State<JobPanelHeatRow> {

  Widget generateHeatContent() {
    return Column(
      children: <Widget>[
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
                            child: Text("American Rumba", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w500)),
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
                        JobPanelStartedBtn(),
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