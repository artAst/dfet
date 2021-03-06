import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/util/Preferences.dart';
import 'package:danceframe_et/model/Judge.dart';
import 'package:danceframe_et/model/Person.dart';
import 'package:danceframe_et/dao/PersonDao.dart';
import 'package:danceframe_et/dao/JudgeDao.dart';
import 'package:danceframe_et/dao/HeatDao.dart';
import 'package:danceframe_et/util/ScreenUtil.dart';
import 'package:danceframe_et/widgets/DanceFrameFooter.dart';
import 'new_judge.dart' as new_judge;
import 'critique_sheet_1.dart' as crit1;
import 'critique_sheet_2.dart' as crit2;
import 'device_mode.dart' as deviceMode;

class personalize_device extends StatefulWidget {
  @override
  _personalize_deviceState createState() => new _personalize_deviceState();
}

class _personalize_deviceState extends State<personalize_device> {
  List<Person> persons;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Preferences.setSharedValue("currentScreen", "personaliseDevice");
    persons = [];
    PersonDao.getAllPersons_pi().then((val){
      setState(() {
        persons = [];
        persons.addAll(val);
        print("persons length: ${val.length}");
      });
    });
  }

  Widget generatePersonCard(Person person, String code, String gender) {
    return new InkWell(
      onTap: (){
        // get judge critique sheets via heat_local
        /*JudgeDao.getJudgeByName("Art", "Astillero").then((judge){
          print("Judge: ${judge.toMap()}");
          HeatDao.getHeatsByJudge(judge.id).then((heats){
            print("heat length: ${heats.length}");
            for(var heat in heats) {
              print(heat.toMap());
            }
            if(heats != null) {
              var _heat = heats[0];
              if(_heat.critiqueSheetType != 1) {
                crit2.judge = judge;
                crit2.heats = heats;
                Navigator.popAndPushNamed(context, "/critique2");
              } else {
                crit1.judge = judge;
                crit1.heats = heats;
                Navigator.popAndPushNamed(context, "/critique1");
              }
            }
            else {
              // DONE screen
              ScreenUtil.showMainFrameDialog(context, "No Critique Sheets", "No Critique Sheets assigned for this Judge. Please inform event coordinator. Thanks");
            }
          });
        });*/
        print(person.toString());
        Preferences.setSharedValue("person_device", person.toString());
        deviceMode.p = person;
        //Navigator.pushNamed(context, "/sign-in"); 
        //direct to device mode route
        Navigator.pushNamed(context, "/deviceMode");
      },
      child: new Container(
        width: 240.0,
        height: 220.0,
        margin: EdgeInsets.only(bottom: 15.0, top: 35.0),
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
                  height: 210.0,
                  alignment: Alignment.center,
                  child: new Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, left: 10.0, right: 10.5, top: 50.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text("${person.first_name} ${person.last_name}".toUpperCase(), style: new TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                            textAlign: TextAlign.center,
                            textScaleFactor: 0.9,
                          ),
                          new Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0)),
                        ],
                      )
                  )
              ),
            ),
            new Align(
              alignment: Alignment(0.0, 0.8),
              child: new Container(
                padding: EdgeInsets.all(2.0),
                color: Colors.white,
                child: new Text(code.toUpperCase(), style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Color(0xff2e4c5e))),
              ),
            ),
            new Align(
              alignment: Alignment(0.0,  -1.8),
              child: new Container(
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: (gender.toLowerCase() == "female") ? ExactAssetImage("assets/images/Asset_1_4x.png") : ExactAssetImage("assets/images/Asset_2_4x.png"),
                        fit: BoxFit.contain
                    )
                ),
                height: 110.0,
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

  List<Widget> generatePersonCardList() {
    List<Widget> _judgeWidgets = [];
    int x = 0;
    while(x < persons.length) {
      List<Widget> _rowItems = [];
      int y = 0;
      while(y < 2 && x < persons.length) {
        if(y != 0){
          _rowItems.add(new Padding(padding: const EdgeInsets.only(left: 50.0)));
        }
        _rowItems.add(
            generatePersonCard(persons[x], "x", persons[x].gender)
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

      if(x >= persons.length) {
        if(y > 0 && y < 2) {
          _rowItems.add(new Padding(padding: const EdgeInsets.only(left: 50.0)));
          //_rowItems.add(generateAddJudgeCard());
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
              //generateAddJudgeCard(),
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
      //_judgeWidgets.add(generateAddJudgeCard());
    }

    return _judgeWidgets;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _personWidgets = generatePersonCardList();


    return new Scaffold(
        appBar: new DanceframeAppBar(
          height: 150.0,
          mode: "TITLE",
          headerText: "Personalize Device",
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
                      children: _personWidgets,
                    ),
                  ),
                )
              ),
              new DanceFrameFooter()
            ],
          ),
        )
    );
  }
}