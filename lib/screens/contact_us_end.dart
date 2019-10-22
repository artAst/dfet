import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'package:danceframe_et/widgets/DanceFrameFooter.dart';

class contact_us_end extends StatefulWidget {
  @override
  _contact_us_endState createState() => new _contact_us_endState();
}

class _contact_us_endState extends State<contact_us_end> {

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double _width = mediaQuery.size.width;
    double widthPadding = _width / 3.5;

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
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.01, 0.5]
              )
          ),
          child:   new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Expanded(
                // PUT YOUR CONTENTS HERE in Child property
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    SizedBox(height: 30.0),
                    new Container(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: new RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body1
                                  .copyWith(fontSize: 28.0),
                              children: [
                                TextSpan(
                                    text: 'You have taken the first step into \n a large world! \n\n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    )
                                ),
                                TextSpan(
                                    text: '- Obiwan Ben Kenobi, Star Wars, A New Hope - \n\n',
                                    style: TextStyle(
                                        fontSize: 20.0
                                    )
                                ),
                                TextSpan(
                                    text: 'We will be in contact with you very soon!\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700
                                    )
                                ),
                                TextSpan(
                                    text: 'Please watch your email for initial details \nand together we will set a new standard. Enjoy!',
                                    style: TextStyle(
                                        fontSize: 24.0
                                    )
                                ),

                              ]
                          )
                      ),

                    ),
                    SizedBox(height: 30.0),
                    new Container(
                        child: new Image.asset(
                          'assets/images/robert.png',
                          width: widthPadding,
                        )
                    ),
                    SizedBox(height: 150.0),
                    new DanceFrameButton(
                      text: "Done",
                      onPressed: () {
                        //Navigator.pushNamed(context, "/");
                        Navigator.maybePop(context);
                      },
                    )
                  ],
                ),
              ),
              new DanceFrameFooter()
            ],
          ),
        )
    );
  }
}