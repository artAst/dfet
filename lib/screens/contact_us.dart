import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';

class contact_us extends StatefulWidget {
  @override
  _contact_usState createState() => new _contact_usState();
}

class _contact_usState extends State<contact_us> {
final _formKey = new GlobalKey<FormState>();
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
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.01, 0.5]
              )
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Expanded(
                // PUT YOUR CONTENTS HERE in Child property
                child:   new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
 SizedBox(height: 15.0),
           new Container(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: new RichText(
               textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(context).textTheme.body1.copyWith(fontSize: 14.0),
          children: [
                TextSpan(
                    text: 'Competition system at the ',
                    style: TextStyle(
                    // fontWeight: FontWeight.w700,
                  )
                ),
                TextSpan(
                  text: 'Royal Ontario Ball\n',
                  style: TextStyle(
                    fontWeight: FontWeight.w700
                  )
                ),
                TextSpan(
                  text: 'provided by '
                ),
                TextSpan(
                  text: 'DanceFrame.\n\n',
                  style: TextStyle(
                    fontWeight: FontWeight.w700
                  )
                ),
                TextSpan(
                  text: 'To find how we can help you work your next event, please provide your contact information and we can discuss how to make your event even awesomer.'
                )
              ]
            )
          ),
            width: 300.0
          ),
            new Form(
            key: _formKey,
            child: new Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: new Column(
                children: <Widget>[
                  new Container(
                    width: 200.0,
                    height: 40.0,
                    child: new TextFormField(
                      decoration: new InputDecoration(
                        labelText: "First Name & Last Name",
                          border: OutlineInputBorder()
                      ),
                      style: new TextStyle(
                        fontSize: 12.0
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  new Container(
                    width: 200.0,
                    height: 40.0,
                    child: new TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Telephone",
                          border: OutlineInputBorder(),
                      ),
                      style: new TextStyle(
                        fontSize: 12.0
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  new Container(
                    width: 200.0,
                    height: 40.0,
                    child: new TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Best Email",
                          border: OutlineInputBorder()
                      ),
                      style: new TextStyle(
                        fontSize: 12.0
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  new Container(
                    width: 200.0,
                    height: 40.0,
                    child: new TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Event Website",
                          border: OutlineInputBorder()
                      ),
                      style: new TextStyle(
                        fontSize: 12.0
                      ),
                    ),
                  ),
                  SizedBox(height: 50.0),
                  new Container(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new DanceFrameButton(
                          text: "Do Nothing",
                          onPressed : () {
                            Navigator.pushNamed(context, "/");
                          },
                        ),
                        new DanceFrameButton(
                          text: "Send Now",
                          onPressed : () {
                            Navigator.pushNamed(context, "/contactUsEnd");
                          },
                        )
                      ],
                    ),
                  )

                ]
              )
            ),

          )
        ],
      ),
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