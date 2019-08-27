import 'package:flutter/material.dart';
import 'package:danceframe_et/screens/linear_percent_indicator.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new InkWell(
        onTap: () => Navigator.pushNamed(context, '/contactUs'),
        child: new Container(
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
              ),
              new Center(
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2500,
                  percent: 1,
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.green,

                ),
              )
            ],
          ),
        ),
      )
    );
  }
}