import 'package:flutter/material.dart';

class JobPanelHeaderBtn extends StatefulWidget {

  final String btnText;
  final Color btnColor;
  final Color txtColor;
  final double fontSize;
  final Function onTap;

  const JobPanelHeaderBtn(this.btnText ,{
    Key key,
    this.btnColor = const Color(0xffb3cbd7),
    this.txtColor = const Color(0xff2f4c5d),
    this.fontSize = 20.0,
    this.onTap,
  }) : super(key: key);

  @override
  _JobPanelHeaderBtnState createState() => new _JobPanelHeaderBtnState();
}

class _JobPanelHeaderBtnState extends State<JobPanelHeaderBtn> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
          margin: EdgeInsets.only(left: 5.0),
          decoration: BoxDecoration(
              color: widget.btnColor,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.black, width: 1.5)
          ),
          alignment: Alignment.center,
          child: Text("${widget.btnText}", style: TextStyle(fontSize: widget.fontSize, color: widget.txtColor, fontWeight: FontWeight.w800))
      )
    );
  }
}