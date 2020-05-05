import 'package:flutter/material.dart';

class JobPanelStartedBtn extends StatefulWidget {

  final Function onTap;
  bool isToggle;

  JobPanelStartedBtn({
    Key key,
    this.onTap,
    this.isToggle
  }) : super(key: key);

  @override
  _JobPanelStartedBtnState createState() => new _JobPanelStartedBtnState();
}

class _JobPanelStartedBtnState extends State<JobPanelStartedBtn> {

  bool startToggle = false;

  @override
  void initState(){ 
    if(widget.isToggle == null ) 
      widget.isToggle = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) { 
    return InkWell(
      onTap: (){
        if(widget.onTap != null) {
         
        }  
        widget.onTap(); 
        
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
        decoration: BoxDecoration(
          //color: Color(0xffde3236),
            color: (!widget.isToggle) ? Color(0xffb3cbd7) : Color(0xffde3236),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.black)
        ),
        alignment: Alignment.center,
        child: Text(
          "STARTED", 
          style: TextStyle(
            fontSize: 15.0, 
            color: (!widget.isToggle) ? Color(0xff2f4c5d) : Colors.white, 
            fontWeight: FontWeight.w800
            )
          ),
      )
    );
  }
}