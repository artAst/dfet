import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class JobPanelPlusBtn extends StatefulWidget {

  Function onTap;
  bool btnState;

  JobPanelPlusBtn({
    Key key,
    this.onTap,
    this.btnState,
  }) : super(key: key);

  @override
  _JobPanelPlusBtnState createState() => new _JobPanelPlusBtnState();
}

class _JobPanelPlusBtnState extends State<JobPanelPlusBtn> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: CircleAvatar(
        radius: 15.0,
        backgroundColor: Color(0xff40a334),
        child: Container(
          child: (!widget.btnState) ? new Icon(FontAwesomeIcons.plus, size: 18.0) : new Icon(FontAwesomeIcons.minus, size: 18.0),
          //child: Text("+", style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w800)),
        ),
      )
    );
  }
}