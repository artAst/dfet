import 'package:flutter/material.dart';

class DanceFrameFooter extends StatefulWidget {
  @override
  _DanceFrameFooterState createState() => new _DanceFrameFooterState();
}

class _DanceFrameFooterState extends State<DanceFrameFooter> {

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
          border: new Border(
              top: BorderSide(color: Colors.black)
          )
      ),
      height: 40.0,
      child: new Stack(
        children: <Widget>[
          new Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text("Powered By: ", style: new TextStyle(fontSize: 16.0)),
                new Padding(padding: const EdgeInsets.only(top: 5.0)),
                new Image.asset("assets/images/Asset_43_4x.png", height: 25.0)
              ],
            ),
          ),
          new Align(
            alignment: Alignment.centerRight,
            child: new InkWell(
              onTap: (){
                Navigator.pushNamed(context, "/contactUs");
              },
              child: new Container(
                padding: const EdgeInsets.only(right: 20.0, top: 1.0),
                child: new Column(
                  children: <Widget>[
                    new Container(
                      //margin: const EdgeInsets.only(top: 10.0, bottom: 0.0, left: 10.0, right: 10.0),
                      child: new Icon(Icons.feedback, size: 20.0),
                    ),
                    new Text("Contact Us", style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            )
          )
        ],
      )
    );
  }
}