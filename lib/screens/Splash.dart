import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.white, new Color(0xADC0BE)],
            focal: Alignment.center,
            radius: 1.0
          )
        ),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Center(
              child: new Text("Dance Frame ET", style: new TextStyle(fontSize: 45.0, color: Colors.redAccent)),
            )
          ],
        ),
      )
    );
  }
}