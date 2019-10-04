import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/util/Preferences.dart';
import 'package:danceframe_et/model/Judge.dart';
import 'package:danceframe_et/dao/JudgeDao.dart';
import 'new_judge.dart' as new_judge;
import 'critique_sheet_1.dart' as critique1;

class personalize_device extends StatefulWidget {
  @override
  _personalize_deviceState createState() => new _personalize_deviceState();
}

class _personalize_deviceState extends State<personalize_device> {
  List<Judge> judges;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Preferences.setSharedValue("currentScreen", "personaliseDevice");
    judges = [];
    JudgeDao.getJudgesList().then((val){
      setState(() {
        judges = [];
        judges.addAll(val);
        print("judges length: ${val.length}");
      });
    });
  }

  Widget generateJudgeCard(Judge judge, String code, String gender) {
    return new InkWell(
      onTap: (){
        critique1.judge = judge;
        Navigator.pushNamed(context, "/critique1");
      },
      child: new Container(
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
                          new Text("${judge.first_name} ${judge.last_name}".toUpperCase(), style: new TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          )),
                          new Padding(padding: EdgeInsets.only(top: 5.0)),
                          new Container(
                            padding: EdgeInsets.all(2.0),
                            color: Colors.white,
                            child: new Text(code.toUpperCase(), style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Color(0xff2e4c5e))),
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
                        image: (gender.toLowerCase() == "female") ? ExactAssetImage("assets/images/Asset_1_4x.png") : ExactAssetImage("assets/images/Asset_2_4x.png"),
                        fit: BoxFit.contain
                    )
                ),
                height: 120.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget generateAddJudgeCard() {
    return new InkWell(
      onTap: (){
        new_judge.nJudge = new Judge();
        Navigator.pushNamed(context, "/newJudge");
      },
      child: new Container(
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
      )
    );
  }

  List<Widget> generateJudgeCardList() {
    List<Widget> _judgeWidgets = [];
    int x = 0;
    while(x < judges.length) {
      List<Widget> _rowItems = [];
      int y = 0;
      while(y < 2 && x < judges.length) {
        if(y != 0){
          _rowItems.add(new Padding(padding: const EdgeInsets.only(left: 50.0)));
        }
        _rowItems.add(
            generateJudgeCard(judges[x], "x", judges[x].gender)
        );
        y++;
        x++;
      }

      if(_judgeWidgets.length > 0) {
        _judgeWidgets.add(
          // PADDING
            new Padding(padding: const EdgeInsets.only(top: 10.0))
        );
      }

      if(x >= judges.length) {
        if(y > 0 && y < 2) {
          _rowItems.add(new Padding(padding: const EdgeInsets.only(left: 50.0)));
          _rowItems.add(generateAddJudgeCard());
          _judgeWidgets.add(new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _rowItems,
          ));
        }
        else {
          _judgeWidgets.add(new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _rowItems,
          ));
          _judgeWidgets.add(
            // PADDING
              new Padding(padding: const EdgeInsets.only(top: 10.0))
          );
          _judgeWidgets.add(new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              generateAddJudgeCard(),
              new Padding(padding: const EdgeInsets.only(left: 50.0)),
              new Container(width: 240.0, height: 220.0)
            ],
          ));
        }
      } else {
        _judgeWidgets.add(new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _rowItems,
        ));
      }
    }

    if(_judgeWidgets.isEmpty) {
      _judgeWidgets.add(generateAddJudgeCard());
    }

    return _judgeWidgets;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _judgeWidgets = generateJudgeCardList();


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
                    child: new ListView(
                      /*children: <Widget>[
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            generateJudgeCard("jane doe", "x", "female"),
                            new Padding(padding: const EdgeInsets.only(left: 50.0)),
                            generateJudgeCard("john doe", "x", "male")
                          ],
                        ),
                        // PADDING
                        new Padding(padding: const EdgeInsets.only(top: 10.0)),
                        // new ROW
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            generateJudgeCard("maria folson", "d2", "female"),
                            new Padding(padding: const EdgeInsets.only(left: 50.0)),
                            generateJudgeCard("ken olson", "d7", "male")
                          ],
                        ),
                        // PADDING
                        new Padding(padding: const EdgeInsets.only(top: 10.0)),
                        // new ROW
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            generateJudgeCard("john smith", "d1", "male"),
                            new Padding(padding: const EdgeInsets.only(left: 50.0)),
                            generateAddJudgeCard()
                          ],
                        ),
                      ],*/
                      children: _judgeWidgets,
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