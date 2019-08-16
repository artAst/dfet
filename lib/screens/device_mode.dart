import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';

class device_mode extends StatefulWidget {
  @override
  _device_modeState createState() => new _device_modeState();
}

class _device_modeState extends State<device_mode> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new DanceframeAppBar(
          height: 150.0,
          mode: "TITLE",
          bg: true,
        ),
        body: new Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [new Color(0xFFD6DFDE), Colors.white],
                  //colors: [Colors.red, Colors.blue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.01, 0.5]
              )
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Expanded(
                child: new SizedBox(
                  child: new Container(
                    //color: Colors.amber,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Padding(padding: const EdgeInsets.only(top: 20.0)),
                        Image.asset("assets/images/Asset_10_4x.png", height: 90.0),
                        new Padding(padding: const EdgeInsets.only(top: 5.0)),
                        Image.asset("assets/images/Asset_9_4x.png", height: 90.0),
                        new Padding(padding: const EdgeInsets.only(top: 5.0)),
                        Image.asset("assets/images/Asset_8_4x.png", height: 90.0),
                        new Padding(padding: const EdgeInsets.only(top: 5.0)),
                        Image.asset("assets/images/Asset_7_4x.png", height: 90.0),
                        new Padding(padding: const EdgeInsets.only(top: 5.0)),
                        Image.asset("assets/images/Asset_6_4x.png", height: 90.0),
                        new Padding(padding: const EdgeInsets.only(top: 5.0)),
                        Image.asset("assets/images/Asset_5_4x.png", height: 90.0),
                        new Padding(padding: const EdgeInsets.only(top: 5.0)),
                        Image.asset("assets/images/Asset_4_4x.png", height: 90.0),
                        new Padding(padding: const EdgeInsets.only(top: 5.0)),
                                  Image.asset("assets/images/Asset_3_4x.png", height: 90.0),
                      ],
                    ),
                  ),
                ),
                //child: new Container(),
              ),
              new Container(
                decoration: new BoxDecoration(
                  border: new Border(
                    top: BorderSide(color: Colors.black)
                  )
                ),
                height: 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text("Powered By: ", style: new TextStyle(fontSize: 16.0)),
                    new Padding(padding: const EdgeInsets.only(top: 5.0)),
                    new Image.asset("assets/images/Asset_43_4x.png", height: 25.0)
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}