import 'package:flutter/material.dart';
import 'JobPanelHeaderBtn.dart';
import 'JobPanelTime.dart';
import 'JobPanelHeatRow.dart';
import 'JobPanelPlusBtn.dart';

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
                        //Text("9:00 AM to 10:15 AM", style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w800)),
                        RichText(
                          text: new TextSpan(
                            text: "9:00",
                            style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w800),
                            children: <TextSpan>[
                              new TextSpan(
                                text: "AM",
                                style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w800)
                              ),
                              new TextSpan(
                                  text: " to 10:15",
                                  style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w800)
                              ),
                              new TextSpan(
                                  text: "AM",
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
        (jobPanelToggle[jobPanelId]) ? generateJobPanelContent() : Container()
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
              ],
            ),
          ),
        )
      ],
    );
  }
}