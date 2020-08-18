import 'package:flutter/material.dart';
import 'package:danceframe_et/dao/JobPanelDataDao.dart';
import 'package:danceframe_et/websocket/DanceFrameCommunication.dart';
import 'package:danceframe_et/model/config/DeviceConfig.dart';

class JobPanelOnFloorDeck extends StatefulWidget {
  String entryId;
  String coupleKey;

  bool onDeck = false;
  bool onFloor = false;
  Function onTap;

//  JobPanelOnFloorDeck({this.j_onDeck, this.j_onFloor, this.entryId, this.coupleKey});
  JobPanelOnFloorDeck({
    Key key,
    this.onTap,
    this.onDeck = false,
    this.onFloor = false,
    this.entryId,
    this.coupleKey
  }) : super(key: key);

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
        "deviceId":DeviceConfig.deviceNum,
        "operation":"update-deckfloor",
        "broadcast":"all",
        "onDeckFloor":{
          "entryId":int.parse(widget.entryId),
          "coupleKey": "${widget.coupleKey}",
          "onDeck":"${widget.onDeck}",
          "onFloor":"${widget.onFloor}"
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
              if(!widget.onDeck) {
                widget.onDeck = true;
              } else {
                if(widget.onFloor) {
                  widget.onFloor = false;
                }
                widget.onDeck = false;
              }
              if(widget.onTap != null) {
                widget.onTap(widget.onDeck, widget.onFloor);
              }
//              if(!widget.j_onDeck) {
//                widget.j_onDeck = true;
//              } else {
//                widget.j_onDeck = false;
//                if(widget.j_onFloor) {
//                  widget.j_onFloor = false;
//                }
//              }
              //JobPanelDataDao.saveOnDeckFloor("couple_on_deck", widget.entryId, (widget.j_onDeck ? 1 : 0));
            });
            _sendMessage();
          },
          child: Container(
            margin: EdgeInsets.only(left: 5.0),
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
            decoration: BoxDecoration(
              //color: Color(0xff2871be),
              color: (!widget.onDeck) ? Color(0xffb3cbd7) : Color(0xff77902b),
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.black),
            ),
            alignment: Alignment.center,
            child: Text("ON DECK", style: TextStyle(fontSize: 13.0, color: (!widget.onDeck) ? Color(0xff2f4c5d) : Colors.white, fontWeight: FontWeight.w800)),
          )
        ),
        InkWell(
          onTap: (){
            setState(() {
              if(!widget.onFloor) {
                widget.onFloor = true;
                if(!widget.onDeck) {
                  widget.onDeck = true;
                }
              } else {
                widget.onFloor = false;
              }
              if(widget.onTap != null) {
                widget.onTap(widget.onDeck, widget.onFloor);
              }
//              if(!widget.j_onFloor) {
//                widget.j_onFloor = true;
//                if(!widget.j_onDeck) {
//                  widget.j_onDeck = true;
//                }
//              } else {
//                widget.j_onFloor = false;
//              }

              //JobPanelDataDao.saveOnDeckFloor("couple_on_floor", widget.entryId, (widget.j_onFloor ? 1 : 0));
            });
            _sendMessage();
          },
          child: Container(
            margin: EdgeInsets.only(left: 5.0),
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
            decoration: BoxDecoration(
              //color: Color(0xff77902b),
              color: (!widget.onFloor) ? Color(0xffb3cbd7) : Color(0xff77902b),
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.black),
            ),
            alignment: Alignment.center,
            child: Text("ON FLOOR", style: TextStyle(fontSize: 13.0, color: (!widget.onFloor) ? Color(0xff2f4c5d) : Colors.white, fontWeight: FontWeight.w800)),
          ),
        )
      ],
    );
  }
}