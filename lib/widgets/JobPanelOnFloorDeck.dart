import 'package:flutter/material.dart';
import 'package:danceframe_et/dao/JobPanelDataDao.dart';
import 'package:danceframe_et/websocket/DanceFrameCommunication.dart';

class JobPanelOnFloorDeck extends StatefulWidget {
  bool j_onDeck;
  bool j_onFloor;
  String entryId;
  String coupleKey;

  JobPanelOnFloorDeck({this.j_onDeck, this.j_onFloor, this.entryId, this.coupleKey});

  @override
  _JobPanelOnFloorDeckState createState() => new _JobPanelOnFloorDeckState();
}

class _JobPanelOnFloorDeckState extends State<JobPanelOnFloorDeck> {
  //bool toggleDeck = false;
  //bool toggleFloor = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*setState(() {
      if(widget.j_onDeck != null) {
        toggleDeck = widget.j_onDeck;
      }
      if(widget.j_onFloor != null) {
        toggleFloor = widget.j_onFloor;
      }
    });*/
  }

  void _sendMessage() {
    //game.send({"entryId": widget.entryId, "onDeck": widget.j_onDeck, "onFloor": widget.j_onFloor});
//    game.send({
//      "deviceId":1,
//      "operation":"update-deckfloor",
//      "broadcast":"all",
//      "onDeckFloor":{
//        "entryId":int.parse(widget.entryId),
//        "onDeck":"${widget.j_onDeck}",
//        "onFloor":"${widget.j_onFloor}"
//      },
//      "scratch":null
//    });
    game.send(
      {
        "deviceId":1,
        "operation":"update-deckfloor",
        "broadcast":"all",
        "onDeckFloor":{
          "entryId":int.parse(widget.entryId),
          "coupleKey": "${widget.coupleKey}",
          "onDeck":"${widget.j_onDeck}",
          "onFloor":"${widget.j_onFloor}"
        },
        "scratch":null
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    /*if(widget.j_onDeck != null) {
      toggleDeck = widget.j_onDeck;
    }
    if(widget.j_onFloor != null) {
      toggleFloor = widget.j_onFloor;
    }*/

    return Row(
      children: <Widget>[
        InkWell(
          onTap: (){
            setState(() {
              if(!widget.j_onDeck) {
                widget.j_onDeck = true;
              } else {
                widget.j_onDeck = false;
                if(widget.j_onFloor) {
                  widget.j_onFloor = false;
                }
              }

              //JobPanelDataDao.saveOnDeckFloor("couple_on_deck", widget.entryId, (widget.j_onDeck ? 1 : 0));
              _sendMessage();
            });
          },
          child: Container(
            margin: EdgeInsets.only(left: 5.0),
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
            decoration: BoxDecoration(
              //color: Color(0xff2871be),
              color: (!widget.j_onDeck) ? Color(0xffb3cbd7) : Color(0xff77902b),
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.black),
            ),
            alignment: Alignment.center,
            child: Text("ON DECK", style: TextStyle(fontSize: 13.0, color: (!widget.j_onDeck) ? Color(0xff2f4c5d) : Colors.white, fontWeight: FontWeight.w800)),
          )
        ),
        InkWell(
          onTap: (){
            setState(() {
              if(!widget.j_onFloor) {
                widget.j_onFloor = true;
                if(!widget.j_onDeck) {
                  widget.j_onDeck = true;
                }
              } else {
                widget.j_onFloor = false;
              }

              //JobPanelDataDao.saveOnDeckFloor("couple_on_floor", widget.entryId, (widget.j_onFloor ? 1 : 0));
              _sendMessage();
            });
          },
          child: Container(
            margin: EdgeInsets.only(left: 5.0),
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
            decoration: BoxDecoration(
              //color: Color(0xff77902b),
              color: (!widget.j_onFloor) ? Color(0xffb3cbd7) : Color(0xff77902b),
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.black),
            ),
            alignment: Alignment.center,
            child: Text("ON FLOOR", style: TextStyle(fontSize: 13.0, color: (!widget.j_onFloor) ? Color(0xff2f4c5d) : Colors.white, fontWeight: FontWeight.w800)),
          ),
        )
      ],
    );
  }
}