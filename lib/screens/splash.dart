import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/linear_percent_indicator.dart';
import 'package:danceframe_et/model/Judge.dart';
import 'package:danceframe_et/dao/JudgeDao.dart';
import 'package:danceframe_et/dao/HeatInfoDao.dart';
import 'package:danceframe_et/util/Preferences.dart';
//import 'package:danceframe_et/util/DatabaseHelper.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  //DatabaseHelper helper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //helper = DatabaseHelper.instance;
    Future.delayed(const Duration(seconds: 3), () {
      Preferences.getSharedValue("currentScreen").then((val){
        if(val != null) {
          print("current screen == ${val}");
          Preferences.getSharedValue("currentScreen").then((val1){
            Navigator.pushNamed(context, "/${val1}");
          });
        }
        else {
          //Preferences.setSharedValue("currentScreen", "deviceMode");
          Navigator.pushNamed(context, '/deviceMode');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new InkWell(
        onTap: () {
          //JudgeDao.saveJudge(new Judge(first_name: "Art", last_name: "Astillero", gender: "MALE", initials: ["test1", "test2"]));
          //JudgeDao.getJudgesList();
          /*JudgeDao.getJudgeById("1").then((judge){
            print("Judge: ${judge.first_name} ${judge.last_name}");
          });*/
          //HeaInfoDao.getHeatInfoList();
          //helper.checkDB();
          //helper.insert(new Judge(first_name: "Art", last_name: "Astillero", gender: "MALE", initials: ["test1", "test2"]));
          //helper.queryAll("judge");
          //Navigator.pushNamed(context, '/deviceMode');
        },
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