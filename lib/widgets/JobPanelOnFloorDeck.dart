import 'package:flutter/material.dart';

class JobPanelOnFloorDeck extends StatefulWidget {
  @override
  _JobPanelOnFloorDeckState createState() => new _JobPanelOnFloorDeckState();
}

class _JobPanelOnFloorDeckState extends State<JobPanelOnFloorDeck> {
  bool toggleDeck = false;
  bool toggleFloor = false;

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