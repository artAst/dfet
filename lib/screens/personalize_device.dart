import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';

class personalize_device extends StatefulWidget {
  @override
  _personalize_deviceState createState() => new _personalize_deviceState();
}

class _personalize_deviceState extends State<personalize_device> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new DanceframeAppBar(
          height: 150.0,
          mode: "TITLE",
          headerText: "Personalize Device For Judge",
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
                child: new Container(
                  margin: const EdgeInsets.only(top: 30.0, bottom: 40.0),
//                  color: Colors.amber,
                  child: new Center(
                    child: new Column(
                      children: <Widget>[
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              width: 240.0,
                              height: 220.0,
                              child: new Stack(
                                children: <Widget>[
                                  new Align(
                                    alignment: Alignment.bottomCenter,
                                    child: new Container(
                                      decoration: new BoxDecoration(
                                        color: new Color(0xff2e4c5e),
                                        borderRadius: BorderRadius.circular(8.0)
                                      ),
                                      width: 240.0,
                                      height: 160.0,
                                      alignment: Alignment.bottomCenter,
                                      child: new Padding(
                                        padding: const EdgeInsets.only(bottom: 20.0),
                                        child: new Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            new Text("JANE DOE", style: new TextStyle(
                                                fontSize: 28.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white
                                            )),
                                            new Padding(padding: EdgeInsets.only(top: 5.0)),
                                            new Container(
                                              padding: EdgeInsets.all(2.0),
                                              color: Colors.white,
                                              child: new Text("X", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Color(0xff2e4c5e))),
                                            )
                                          ],
                                        )
                                      )
                                    ),
                                  ),
                                  new Align(
                                    alignment: Alignment.topCenter,
                                    child: new Container(
                                      decoration: new BoxDecoration(
                                        image: new DecorationImage(
                                          image: ExactAssetImage("assets/images/Asset_1_4x.png"),
                                          fit: BoxFit.contain
                                        )
                                      ),
                                      height: 120.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Padding(padding: const EdgeInsets.only(left: 50.0)),
                            new Container(
                              width: 240.0,
                              height: 220.0,
                              child: new Stack(
                                children: <Widget>[
                                  new Align(
                                    alignment: Alignment.bottomCenter,
                                    child: new Container(
                                        decoration: new BoxDecoration(
                                            color: new Color(0xff2e4c5e),
                                            borderRadius: BorderRadius.circular(8.0)
                                        ),
                                        width: 240.0,
                                        height: 160.0,
                                        alignment: Alignment.bottomCenter,
                                        child: new Padding(
                                            padding: const EdgeInsets.only(bottom: 20.0),
                                            child: new Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                new Text("JOHN DOE", style: new TextStyle(
                                                    fontSize: 28.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white
                                                )),
                                                new Padding(padding: EdgeInsets.only(top: 5.0)),
                                                new Container(
                                                  padding: EdgeInsets.all(2.0),
                                                  color: Colors.white,
                                                  child: new Text("X", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Color(0xff2e4c5e))),
                                                )
                                              ],
                                            )
                                        )
                                    ),
                                  ),
                                  new Align(
                                    alignment: Alignment.topCenter,
                                    child: new Container(
                                      decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                              image: ExactAssetImage("assets/images/Asset_2_4x.png"),
                                              fit: BoxFit.contain
                                          )
                                      ),
                                      height: 120.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        // PADDING
                        new Padding(padding: const EdgeInsets.only(top: 10.0)),
                        // new ROW
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              width: 240.0,
                              height: 220.0,
                              child: new Stack(
                                children: <Widget>[
                                  new Align(
                                    alignment: Alignment.bottomCenter,
                                    child: new Container(
                                        decoration: new BoxDecoration(
                                            color: new Color(0xff2e4c5e),
                                            borderRadius: BorderRadius.circular(8.0)
                                        ),
                                        width: 240.0,
                                        height: 160.0,
                                        alignment: Alignment.bottomCenter,
                                        child: new Padding(
                                            padding: const EdgeInsets.only(bottom: 20.0),
                                            child: new Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                new Text("MARIA FOLSON", style: new TextStyle(
                                                    fontSize: 28.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white
                                                )),
                                                new Padding(padding: EdgeInsets.only(top: 5.0)),
                                                new Container(
                                                  padding: EdgeInsets.all(2.0),
                                                  color: Colors.white,
                                                  child: new Text("D2", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Color(0xff2e4c5e))),
                                                )
                                              ],
                                            )
                                        )
                                    ),
                                  ),
                                  new Align(
                                    alignment: Alignment.topCenter,
                                    child: new Container(
                                      decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                              image: ExactAssetImage("assets/images/Asset_1_4x.png"),
                                              fit: BoxFit.contain
                                          )
                                      ),
                                      height: 120.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Padding(padding: const EdgeInsets.only(left: 50.0)),
                            new Container(
                              width: 240.0,
                              height: 220.0,
                              child: new Stack(
                                children: <Widget>[
                                  new Align(
                                    alignment: Alignment.bottomCenter,
                                    child: new Container(
                                        decoration: new BoxDecoration(
                                            color: new Color(0xff2e4c5e),
                                            borderRadius: BorderRadius.circular(8.0)
                                        ),
                                        width: 240.0,
                                        height: 160.0,
                                        alignment: Alignment.bottomCenter,
                                        child: new Padding(
                                            padding: const EdgeInsets.only(bottom: 20.0),
                                            child: new Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                new Text("KEN OLSON", style: new TextStyle(
                                                    fontSize: 28.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white
                                                )),
                                                new Padding(padding: EdgeInsets.only(top: 5.0)),
                                                new Container(
                                                  padding: EdgeInsets.all(2.0),
                                                  color: Colors.white,
                                                  child: new Text("D7", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Color(0xff2e4c5e))),
                                                )
                                              ],
                                            )
                                        )
                                    ),
                                  ),
                                  new Align(
                                    alignment: Alignment.topCenter,
                                    child: new Container(
                                      decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                              image: ExactAssetImage("assets/images/Asset_2_4x.png"),
                                              fit: BoxFit.contain
                                          )
                                      ),
                                      height: 120.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        // PADDING
                        new Padding(padding: const EdgeInsets.only(top: 10.0)),
                        // new ROW
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              width: 240.0,
                              height: 220.0,
                              child: new Stack(
                                children: <Widget>[
                                  new Align(
                                    alignment: Alignment.bottomCenter,
                                    child: new Container(
                                        decoration: new BoxDecoration(
                                            color: new Color(0xff2e4c5e),
                                            borderRadius: BorderRadius.circular(8.0)
                                        ),
                                        width: 240.0,
                                        height: 160.0,
                                        alignment: Alignment.bottomCenter,
                                        child: new Padding(
                                            padding: const EdgeInsets.only(bottom: 20.0),
                                            child: new Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                new Text("JOHN SMITH", style: new TextStyle(
                                                    fontSize: 28.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white
                                                )),
                                                new Padding(padding: EdgeInsets.only(top: 5.0)),
                                                new Container(
                                                  padding: EdgeInsets.all(2.0),
                                                  color: Colors.white,
                                                  child: new Text("D1", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Color(0xff2e4c5e))),
                                                )
                                              ],
                                            )
                                        )
                                    ),
                                  ),
                                  new Align(
                                    alignment: Alignment.topCenter,
                                    child: new Container(
                                      decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                              image: ExactAssetImage("assets/images/Asset_2_4x.png"),
                                              fit: BoxFit.contain
                                          )
                                      ),
                                      height: 120.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Padding(padding: const EdgeInsets.only(left: 50.0)),
                            new Container(
                              width: 240.0,
                              height: 220.0,
                              child: new Stack(
                                children: <Widget>[
                                  new Align(
                                    alignment: Alignment.bottomCenter,
                                    child: new Container(
                                        decoration: new BoxDecoration(
                                            color: new Color(0xff2e4c5e),
                                            borderRadius: BorderRadius.circular(8.0)
                                        ),
                                        width: 240.0,
                                        height: 160.0,
                                        alignment: Alignment.bottomCenter,
                                        child: new Padding(
                                            padding: const EdgeInsets.only(bottom: 60.0),
                                            child: new Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                new Text("ADD JUDGE", style: new TextStyle(
                                                    fontSize: 28.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white
                                                )),
                                              ],
                                            )
                                        )
                                    ),
                                  ),
                                  new Align(
                                    alignment: Alignment.topCenter,
                                    /*child: new Container(
                                      decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                              image: ExactAssetImage("assets/images/Asset_2_4x.png"),
                                              fit: BoxFit.contain
                                          )
                                      ),
                                      height: 120.0,
                                    ),*/
                                    child: new Container(
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.black)
                                      ),
                                      height: 115.0,
                                      child: new Icon(Icons.add, size: 90.0, color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
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