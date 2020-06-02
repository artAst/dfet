import 'package:flutter/material.dart';

class JobPanelStartedBtn extends StatefulWidget {
  bool startToggle = false;
  Function onTap;

  JobPanelStartedBtn({
    Key key,
    this.onTap,
    this.startToggle = false
  }) : super(key: key);

  @override
  _JobPanelStartedBtnState createState() => new _JobPanelStartedBtnState();
}

class _JobPanelStartedBtnState extends State<JobPanelStartedBtn> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          if(!widget.startToggle) {
            widget.startToggle = true;
          } else {
            widget.startToggle = false;
          }

          if(widget.onTap != null) {
            widget.onTap(widget.startToggle);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
        decoration: BoxDecoration(
          //color: Color(0xffde3236),
            color: (!widget.startToggle)   ? Color(0xffb3cbd7) : Color(0xff77902b),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.black)
        ),
        alignment: Alignment.center,
        child: Text("STARTED", style: TextStyle(fontSize: 15.0, color: (!widget.startToggle) ? Color(0xff2f4c5d) : Colors.white, fontWeight: FontWeight.w800)),
      )
    );
  }
}