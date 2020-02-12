import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/widgets/DanceframeFormContainer.dart';
import 'package:danceframe_et/enums/FormContainerType.dart';

class manage_couple extends StatefulWidget {
  @override
  _manage_coupleState createState() => new _manage_coupleState();
}

class _manage_coupleState extends State<manage_couple> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new DanceframeAppBar(
          height: 150.0,
          mode: "TITLE",
          headerText: "MANAGE COUPLE",
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
                child: new DanceframeFormContainer(
                  alignment: Alignment.topLeft,
                  containerType: FormContainerType.BOXED,
                  flex: 3.0,
                  background: Colors.transparent,
                  headingText: "Judge: MARIA FOLSON",
                  child: Container(
                    //color: Colors.amber,
                    margin: EdgeInsets.only(top: 15.0),
                    child: ListView(
                      children: <Widget>[
                        Container(
                          color: Color(0xffa3d5e4),
                          constraints: BoxConstraints(minHeight: 60.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                constraints: BoxConstraints(minWidth: 145.0),
                                child: Text("Competitor #", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700)),
                              ),
                              Container(
                                constraints: BoxConstraints(minWidth: 75.0),
                                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                                color: Colors.white,
                                child: Text("126", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700)),
                              ),
                              Container(
                                constraints: BoxConstraints(minWidth: 185.0),
                                child: Text("John Smith", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700)),
                              ),
                              Container(
                                constraints: BoxConstraints(minWidth: 185.0),
                                child: Text("(Pro-Gentleman)", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700)),
                              )
                            ],
                          )
                        ),
                        Container(
                            color: Color(0xffedf7f9),
                            constraints: BoxConstraints(minHeight: 60.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(width: 145.0),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Color(0xffabd8e6))
                                  ),
                                  constraints: BoxConstraints(minWidth: 70.0),
                                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                  child: Text("Select", style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w600)),
                                ),
                                Container(
                                  constraints: BoxConstraints(minWidth: 185.0),
                                  child: Text("Jane Smith", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700)),
                                ),
                                Container(
                                  constraints: BoxConstraints(minWidth: 185.0),
                                  child: Text("(Am-Lady)", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700)),
                                )
                              ],
                            )
                        ),
                        Container(
                            color: Color(0xffa3d5e4),
                            constraints: BoxConstraints(minHeight: 60.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(width: 145.0),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Color(0xffabd8e6))
                                  ),
                                  constraints: BoxConstraints(minWidth: 70.0),
                                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                  child: Text("Select", style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w600)),
                                ),
                                Container(
                                  constraints: BoxConstraints(minWidth: 185.0),
                                  child: Text("Sue Allen", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700)),
                                ),
                                Container(
                                  constraints: BoxConstraints(minWidth: 185.0),
                                  child: Text("(Am-Lady)", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700)),
                                )
                              ],
                            )
                        ),
                        Container(
                            color: Color(0xffedf7f9),
                            constraints: BoxConstraints(minHeight: 60.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(width: 145.0),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Color(0xffabd8e6))
                                  ),
                                  constraints: BoxConstraints(minWidth: 70.0),
                                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                  child: Text("Select", style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w600)),
                                ),
                                Container(
                                  constraints: BoxConstraints(minWidth: 185.0),
                                  child: Text("Milas Jovoreh", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700)),
                                ),
                                Container(
                                  constraints: BoxConstraints(minWidth: 185.0),
                                  child: Text("(Am-Lady)", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700)),
                                )
                              ],
                            )
                        ),
                        Container(
                            color: Color(0xffbfecdc),
                            constraints: BoxConstraints(minHeight: 60.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(width: 145.0),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Color(0xffabd8e6))
                                  ),
                                  constraints: BoxConstraints(minWidth: 70.0),
                                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                  child: Text("Select", style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w600)),
                                ),
                                Container(
                                  constraints: BoxConstraints(minWidth: 185.0),
                                  child: Text("Eva Lopshitz", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700)),
                                ),
                                Container(
                                  constraints: BoxConstraints(minWidth: 185.0),
                                  child: Text("(Pro-Lady)", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700)),
                                )
                              ],
                            )
                        ),
                        Container(
                            color: Color(0xffedf7f9),
                            constraints: BoxConstraints(minHeight: 60.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(width: 145.0),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Color(0xffabd8e6))
                                  ),
                                  constraints: BoxConstraints(minWidth: 70.0),
                                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                  child: Text("Select", style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w600)),
                                ),
                                Container(
                                  constraints: BoxConstraints(minWidth: 185.0),
                                  child: Text("Select from list", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700)),
                                ),
                                Container(
                                  constraints: BoxConstraints(minWidth: 185.0),
                                  //child: Text("(Am-Lady)", style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700)),
                                )
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
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