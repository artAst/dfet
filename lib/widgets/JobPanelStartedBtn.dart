import 'package:flutter/material.dart';

class JobPanelStartedBtn extends StatefulWidget {

  final Function onTap;

  const JobPanelStartedBtn({
    Key key,
    this.onTap,
  }) : super(key: key);

  @override
  _JobPanelStartedBtnState createState() => new _JobPanelStartedBtnState();
}

class _JobPanelStartedBtnState extends State<JobPanelStartedBtn> {

  bool startToggle = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(widget.onTap != null) {
          widget.onTap();
        }

        setState(() {
          if(!startToggle) {
            startToggle = true;
          } else {
            startToggle = false;
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
        decoration: BoxDecoration(
          //color: Color(0xffde3236),
            color: (!startToggle)   ? Color(0xffb3cbd7) : Color(0xff77902b),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.black)
        ),
        alignment: Alignment.center,
        child: Text("STARTED", style: TextStyle(fontSize: 15.0, color: (!startToggle) ? Color(0xff2f4c5d) : Colors.white, fontWeight: FontWeight.w800)),
      )
    );
  }
}