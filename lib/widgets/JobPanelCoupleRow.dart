import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'JobPanelPlusBtn.dart';
import 'JobPanelOnFloorDeck.dart';
import 'package:danceframe_et/util/ScreenUtil.dart';

class JobPanelCoupleRow extends StatefulWidget {

  bool isEven;
  String col1;
  String col2;
  String col3;
  Map<String, bool> coupleRowToggle;
  bool isScratched;

  JobPanelCoupleRow(this.col1, this.col2, this.col3, this.isEven, this.coupleRowToggle, this.isScratched);

  @override
  _JobPanelCoupleRowState createState() => new _JobPanelCoupleRowState();
}

class _JobPanelCoupleRowState extends State<JobPanelCoupleRow> {

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
                            constraints: BoxConstraints(minWidth: 70.0),
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: Text("Am", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Color(0xffedf7f9),
                                border: Border.all()
                            ),
                            constraints: BoxConstraints(minWidth: 155.0),
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: Text("Jack Osmend", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500))
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
                            constraints: BoxConstraints(minWidth: 70.0),
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: Text("Pro", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Color(0xffedf7f9),
                                border: Border.all()
                            ),
                            constraints: BoxConstraints(minWidth: 155.0),
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: Text("Dianne Kelly", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500))
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
                            constraints: BoxConstraints(minWidth: 85.0),
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: Text("Booked Heats", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Color(0xffedf7f9),
                                border: Border.all()
                            ),
                            constraints: BoxConstraints(minWidth: 119.0),
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
                          constraints: BoxConstraints(minWidth: 85.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("Level", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xffedf7f9),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(minWidth: 100.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("Newcomer", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500))
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
                          constraints: BoxConstraints(minWidth: 85.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("Studio", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xffedf7f9),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(minWidth: 100.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("Dance Vitality", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500))
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
                          constraints: BoxConstraints(minWidth: 85.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("Danced Heats", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xffedf7f9),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(minWidth: 50.0),
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
                          constraints: BoxConstraints(minWidth: 85.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("Future Heats", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xffedf7f9),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(minWidth: 50.0),
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
                          constraints: BoxConstraints(minWidth: 85.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("Total Heats", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xffedf7f9),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(minWidth: 50.0),
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
                          constraints: BoxConstraints(minWidth: 85.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("Age", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500))
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xffedf7f9),
                              border: Border.all()
                          ),
                          constraints: BoxConstraints(minWidth: 100.0),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text("C3", style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500))
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
                    text: (!widget.isScratched) ? "SCRATCH" : "SCRATCHED",
                    onPressed: (){
                      if(!widget.isScratched) {
                        ScreenUtil.showScratchDialog(context, (val) {
                          print("val: $val");
                          setState(() {
                            if (val != null) {
                              widget.isScratched = true;
                            }
                          });
                        });
                      }
                    },
                  )
              )
            ],
          )
        ],
      ),
    );
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
                    child: Text("${(widget.isScratched) ? "x " : ""}| ${widget.col1} | ${widget.col2} | ${widget.col3}", style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w500)),
                  ),
                ),
                JobPanelOnFloorDeck(),
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