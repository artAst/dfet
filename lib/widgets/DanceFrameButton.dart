import 'package:flutter/material.dart';

class DanceFrameButton extends StatefulWidget {

  final double height;
  final double width;
  final String text;
  final VoidCallback onPressed;

  const DanceFrameButton({
    Key key,
    this.onPressed,
    this.height = 40.0,
    this.width = 120.0,
    this.text = ""
  }) : super(key: key);

  @override
  _DanceFrameButtonState createState() => new _DanceFrameButtonState();
}

class _DanceFrameButtonState extends State<DanceFrameButton> {

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: widget.onPressed,
      child: new Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [new Color(0xff5a6564), new Color(0xff202423), new Color(0xff202423), new Color(0xff5a6564)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0,0.3,0.7,1.0]
            ),
            borderRadius: new BorderRadius.all(new Radius.circular(8.0))
        ),
        width: widget.width,
        height: widget.height,
        alignment: Alignment.center,
        child: new Text(widget.text, style: new TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white
        )),
      )
    );
  }
}