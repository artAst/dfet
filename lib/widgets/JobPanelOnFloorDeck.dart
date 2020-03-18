import 'package:flutter/material.dart';
import 'package:danceframe_et/dao/JobPanelDataDao.dart';

class JobPanelOnFloorDeck extends StatefulWidget {
  bool j_onDeck;
  bool j_onFloor;
  String entryId;

  JobPanelOnFloorDeck({this.j_onDeck, this.j_onFloor, this.entryId});

  @override
  _JobPanelOnFloorDeckState createState() => new _JobPanelOnFloorDeckState();
}

class _JobPanelOnFloorDeckState extends State<JobPanelOnFloorDeck> {
  bool toggleDeck = false;
  bool toggleFloor = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if(widget.j_onDeck != null) {
        toggleDeck = widget.j_onDeck;
      }
      if(widget.j_onFloor != null) {
        toggleFloor = widget.j_onFloor;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        InkWell(
          onTap: (){
            setState(() {
              if(!toggleDeck) {
                toggleDeck = true;
              } else {
                toggleDeck = false;
                if(toggleFloor) {
                  toggleFloor = false;
                }
              }

              JobPanelDataDao.saveOnDeckFloor("couple_on_deck", widget.entryId, (toggleDeck ? 1 : 0));
            });
          },
          child: Container(
            margin: EdgeInsets.only(left: 5.0),
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
            decoration: BoxDecoration(
              //color: Color(0xff2871be),
              color: (!toggleDeck) ? Color(0xffb3cbd7) : Color(0xff77902b),
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.black),
            ),
            alignment: Alignment.center,
            child: Text("ON DECK", style: TextStyle(fontSize: 13.0, color: (!toggleDeck) ? Color(0xff2f4c5d) : Colors.white, fontWeight: FontWeight.w800)),
          )
        ),
        InkWell(
          onTap: (){
            setState(() {
              if(!toggleFloor) {
                toggleFloor = true;
                if(!toggleDeck) {
                  toggleDeck = true;
                }
              } else {
                toggleFloor = false;
              }

              JobPanelDataDao.saveOnDeckFloor("couple_on_floor", widget.entryId, (toggleFloor ? 1 : 0));
            });
          },
          child: Container(
            margin: EdgeInsets.only(left: 5.0),
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
            decoration: BoxDecoration(
              //color: Color(0xff77902b),
              color: (!toggleFloor) ? Color(0xffb3cbd7) : Color(0xff77902b),
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.black),
            ),
            alignment: Alignment.center,
            child: Text("ON FLOOR", style: TextStyle(fontSize: 13.0, color: (!toggleFloor) ? Color(0xff2f4c5d) : Colors.white, fontWeight: FontWeight.w800)),
          ),
        )
      ],
    );
  }
}