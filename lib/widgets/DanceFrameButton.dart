import 'package:flutter/material.dart';

class DanceFrameButton extends StatefulWidget {

  final double height;
  final double width;
  final String text;
  final VoidCallback onPressed;
  final String textSpanText;
  final TextStyle textStyle; 

  const DanceFrameButton({
    Key key,
    this.onPressed,
    this.height = 40.0,
    this.width = 120.0,
    this.text = "",
    this.textSpanText = "",
    this.textStyle,
  }) : super(key: key);

  @override
  _DanceFrameButtonState createState() => new _DanceFrameButtonState();
}

class _DanceFrameButtonState extends State<DanceFrameButton> {

   LinearGradient gradientColor(){
    if(widget.text == 'ACTIVE'){
      return new LinearGradient(
                colors: [new Color(0xff1212313), new Color(0xff189920), new Color(0xff0016800), new Color(0xff189920)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0,0.3,0.3,1.0]
            );
     
    }else{
         return new LinearGradient(
                colors: [new Color(0xff5a6564), new Color(0xff202423), new Color(0xff202423), new Color(0xff5a6564)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0,0.3,0.7,1.0]
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: widget.onPressed,
      child: new Container(
        decoration: new BoxDecoration(
            gradient: gradientColor(),
            borderRadius: new BorderRadius.all(new Radius.circular(8.0))
        ),
        width: widget.width,
        height: widget.height,
        alignment: Alignment.center,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: widget.textSpanText,
                style: TextStyle(
                  fontSize: 16.0,
                  letterSpacing: 1.1
                )
              ),
              TextSpan(
                    text: widget.text, 
                  style: new TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  )
              ),
            ]
          )
        ),
      )
    );
  }
}