import 'package:flutter/material.dart';
import 'JobPanelHeaderBtn.dart';
import 'JobPanelTime.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';

class JobPanel extends StatefulWidget {
  @override
  _JobPanelState createState() => new _JobPanelState();
}

class _JobPanelState extends State<JobPanel> {
  Map<String, bool> jobPanelToggle = {};
  Map<String, bool> heatRowToggle = {};
  Map<String, bool> coupleRowToggle = {};

  @override
  void initState() {
    super.initState();
    jobPanelToggle["1"] = false;
    jobPanelToggle["2"] = false;

    heatRowToggle["1"] = false;
    heatRowToggle["2"] = false;
    heatRowToggle["3"] = false;

    coupleRowToggle["153"] = false;
    coupleRowToggle["169"] = false;
    coupleRowToggle["116"] = false;
    coupleRowToggle["208"] = false;
  }

  Widget generateJobPanelContent() {
    return Column(
      children: <Widget>[
        //
        // Seventh row
        Container(
            padding: EdgeInsets.only(right: 15.0, left: 25.0, top: 2.0),
            constraints: BoxConstraints(minHeight: 60.0),
            decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black, width: 1.5),
                  left: BorderSide(color: Colors.black, width: 1.5),
                  right: BorderSide(color: Colors.black, width: 1.5),
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
                            child: Text("11. John Smith", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                          decoration: BoxDecoration(
                            color: Color(0xff1a9b93),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          alignment: Alignment.center,
                          child: Text("JUDGE", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0),
                          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                          decoration: BoxDecoration(
                            color: Color(0xff475156),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          alignment: Alignment.center,
                          child: Text("INVIGILATOR", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0),
                          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                          decoration: BoxDecoration(
                            color: Color(0xff475156),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          alignment: Alignment.center,
                          child: Text("EMCEE", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0),
                          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                          decoration: BoxDecoration(
                            color: Color(0xff475156),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          alignment: Alignment.center,
                          child: Text("FREE TIME", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                        ),
                      ],
                    )
                ),
              ],
            )
        ),
        //
        // Eighth row
        Container(
            padding: EdgeInsets.only(right: 15.0, left: 25.0, top: 2.0),
            constraints: BoxConstraints(minHeight: 60.0),
            decoration: BoxDecoration(
                color: Color(0xffa3d5e4),
                border: Border(
                  left: BorderSide(color: Colors.black, width: 1.5),
                  right: BorderSide(color: Colors.black, width: 1.5),
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
                            child: Text("12. James Jones", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                          decoration: BoxDecoration(
                            color: Color(0xff475156),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          alignment: Alignment.center,
                          child: Text("JUDGE", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0),
                          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                          decoration: BoxDecoration(
                            color: Color(0xff1a9b93),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          alignment: Alignment.center,
                          child: Text("INVIGILATOR", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0),
                          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                          decoration: BoxDecoration(
                            color: Color(0xff475156),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          alignment: Alignment.center,
                          child: Text("EMCEE", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0),
                          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                          decoration: BoxDecoration(
                            color: Color(0xff475156),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          alignment: Alignment.center,
                          child: Text("FREE TIME", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                        ),
                      ],
                    )
                ),
              ],
            )
        ),
        //
        // Eighth row
        Container(
          padding: EdgeInsets.only(right: 15.0, left: 25.0, top: 2.0),
          constraints: BoxConstraints(minHeight: 60.0),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.black, width: 1.5),
              right: BorderSide(color: Colors.black, width: 1.5),
              bottom: BorderSide(color: Colors.black, width: 1.5),
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
                        child: Text("13. Sue Smith", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w500)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xff475156),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      alignment: Alignment.center,
                      child: Text("JUDGE", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5.0),
                      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xff475156),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      alignment: Alignment.center,
                      child: Text("INVIGILATOR", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5.0),
                      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xff1a9b93),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      alignment: Alignment.center,
                      child: Text("EMCEE", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5.0),
                      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xff475156),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      alignment: Alignment.center,
                      child: Text("FREE TIME", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                    ),
                  ],
                )
              ),
            ],
          )
        )
      ],
    );
  }

  Widget generateJobPanel(String jobPanelId, String heatRange) {
    return Column(
      children: <Widget>[
        //
        // Second row
        Container(
            padding: EdgeInsets.only(right: 15.0, left: 25.0),
            margin: EdgeInsets.only(top: 2.0),
            constraints: BoxConstraints(minHeight: 50.0),
            color: Color(0xfffd9126),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
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
                        Text("9:00 AM to 10:15 AM", style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w800)),
                        InkWell(
                          onTap: (){
                            setState(() {
                              if(!jobPanelToggle[jobPanelId]) {
                                jobPanelToggle[jobPanelId] = true;
                              } else {
                                jobPanelToggle[jobPanelId] = false;
                              }
                            });
                          },
                          child: Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: CircleAvatar(
                                radius: 15.0,
                                backgroundColor: Color(0xff40a334),
                                child: Container(
                                  //padding: const EdgeInsets.symmetric(
                                  //    horizontal: 2.0, vertical: 2.0),
                                  child: new Icon(Icons.add, size: 22.0),
                                  //child: Text("+", style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w800)),
                                ),
                              )
                          )
                        )
                      ],
                    )
                ),
              ],
            )
        ),
        // if toggle is true
        (jobPanelToggle[jobPanelId]) ? generateJobPanelContent() : Container()
      ],
    );
  }

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
                  text: "SCRATCH",
                  onPressed: (){},
                )
              )
            ],
          )
        ],
      ),
    );
  }

  Widget generateCoupleRow(String col1, String col2, String col3, bool isEven) {
    return Container(
      padding: EdgeInsets.only(right: 15.0, left: 25.0, top: 5.0, bottom: 5.0),
      color: (!isEven) ? Color(0xffedf7f9) : Color(0xffa3d5e4),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text("| $col1 | $col2 | $col3", style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w500)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5.0),
                padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Color(0xff2871be),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                alignment: Alignment.center,
                child: Text("ON DECK", style: TextStyle(fontSize: 13.0, color: Colors.white, fontWeight: FontWeight.w800)),
              ),
              Container(
                margin: EdgeInsets.only(left: 5.0),
                padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Color(0xff77902b),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                alignment: Alignment.center,
                child: Text("ON FLOOR", style: TextStyle(fontSize: 13.0, color: Colors.white, fontWeight: FontWeight.w800)),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    if(!coupleRowToggle[col1]) {
                      coupleRowToggle[col1] = true;
                    } else {
                      coupleRowToggle[col1] = false;
                    }
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: CircleAvatar(
                    radius: 15.0,
                    backgroundColor: Color(0xff40a334),
                    child: Container(
                      child: new Icon(Icons.add, size: 22.0),
                    ),
                  ),
                )
              )
            ],
          ),
          // COUPLE CONTENT CONTAINER
          (coupleRowToggle[col1]) ? generateCoupleContent() : Container()
        ],
      )
    );
  }

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
                generateCoupleRow("153", "L-B1", "Cindy Brown - Mitchel Kibel", false),
                generateCoupleRow("169", "L-B1", "Sue Smith - Ryan Wells", true),
                generateCoupleRow("116", "G-A1", "David Borrow - Mila Stern", false),
                generateCoupleRow("208", "G-C3", "Jack Osmend - Dianne Kelly", true),
              ],
            )
        )
      ],
    );
  }

  Widget generateHeatRow(String timeSlot, String heatRowId, bool isColor) {
    return Column(
      children: <Widget>[
        //
        // Third row
        Container(
            padding: EdgeInsets.only(right: 15.0, left: 25.0),
            margin: EdgeInsets.only(top: 2.0),
            constraints: BoxConstraints(minHeight: 60.0),
            color: (isColor) ? Color(0xffa3d5e4) : Color(0xff),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Text("$timeSlot Heat ${heatRowId}", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w500)),
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
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                          decoration: BoxDecoration(
                            color: Color(0xffde3236),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          alignment: Alignment.center,
                          child: Text("STARTED", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if(!heatRowToggle[heatRowId]) {
                                heatRowToggle[heatRowId] = true;
                              } else {
                                heatRowToggle[heatRowId] = false;
                              }
                            });
                          },
                          child: Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: CircleAvatar(
                                radius: 15.0,
                                backgroundColor: Color(0xff40a334),
                                child: Container(
                                  child: new Icon(Icons.add, size: 22.0),
                                  //child: Text("+", style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w800)),
                                ),
                              )
                          )
                        )
                      ],
                    )
                ),
              ],
            )
        ),
        (heatRowToggle[heatRowId]) ? generateHeatContent() : Container()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            color: Colors.black,
            height: 60.0,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text("EMCEE: JOHN SMITH", style: TextStyle(fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.w700)),
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
                child: JobPanelHeaderBtn("Job Panel", btnColor: Color(0xff2f4c5d), txtColor: Colors.white),
              ),
              Expanded(
                child: JobPanelHeaderBtn("Next Heat"),
              ),
              Expanded(
                child: JobPanelHeaderBtn("Manage Couple", fontSize: 18.0),
              ),
              Expanded(
                child: JobPanelHeaderBtn("Mode Change", fontSize: 18.0),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
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
                generateJobPanel("1", "1-15"),
                generateHeatRow("9:00 AM", "1", false),
                //
                // Fourth row
                generateHeatRow("9:00 AM", "2", true),
                //
                // Fifth row
                generateHeatRow("11:53 AM", "3", false),
                /*Container(
                    padding: EdgeInsets.only(right: 15.0, left: 25.0),
                    margin: EdgeInsets.only(top: 2.0),
                    constraints: BoxConstraints(minHeight: 60.0),
                    //color: Color(0xffa3d5e4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Text("11:53 AM Heat 3", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w500)),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Text("American Samba", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w500)),
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
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xffde3236),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("STARTED", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800)),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: CircleAvatar(
                                      radius: 15.0,
                                      backgroundColor: Color(0xff40a334),
                                      child: Container(
                                        //padding: const EdgeInsets.symmetric(
                                        //    horizontal: 2.0, vertical: 2.0),
                                        child: new Icon(Icons.add, size: 22.0),
                                        //child: Text("+", style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w800)),
                                      ),
                                    )
                                )
                              ],
                            )
                        ),
                      ],
                    )
                ),*/
                //
                // Sixth row
                generateJobPanel("2", "16-45"),
              ],
            ),
          ),
        )
      ],
    );
  }
}