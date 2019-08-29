import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/linear_percent_indicator.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new InkWell(
        onTap: () => Navigator.pushNamed(context, '/deviceMode'),
        child: new Container(
          decoration: new BoxDecoration(
              gradient: RadialGradient(
                  colors: [Colors.white, new Color(0xADC0BE)],
                  focal: Alignment.center,
                  radius: 1.0
              )
          ),
          child: new Column(
            children: <Widget>[
              new Expanded(
                child: Container(
                  alignment: Alignment.center,
                  //color: Colors.amber,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        decoration: new BoxDecoration(
                          image: DecorationImage(
                            image: new ExactAssetImage("assets/images/Asset_43_4x.png"),
                            fit: BoxFit.fitWidth
                          ),
                        ),
                        width: MediaQuery.of(context).size.width / 2,
                        height: 80.0,
                      ),
                      new LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width / 2,
                        alignment: MainAxisAlignment.center,
                        animation: true,
                        lineHeight: 15.0,
                        animationDuration: 2500,
                        percent: 1,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Color(0xff848484),
                      )
                    ],
                  )
                )
              )
            ],
          ),
        ),
      )
    );
  }
}