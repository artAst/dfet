import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:danceframe_et/widgets/linear_percent_indicator.dart';
import 'package:danceframe_et/dao/HeatDao.dart';
import 'package:danceframe_et/util/Preferences.dart';
import 'package:danceframe_et/dao/PersonDao.dart';
import 'package:danceframe_et/util/InitializationUtil.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  //DatabaseHelper helper;

  handleAppLifecycleState() {
    AppLifecycleState _lastLifecyleState;
    SystemChannels.lifecycle.setMessageHandler((msg) {

      print('SystemChannels> $msg');

      switch (msg) {
        case "AppLifecycleState.paused":
          _lastLifecyleState = AppLifecycleState.paused;
          break;
        case "AppLifecycleState.inactive":
          Navigator.pushNamed(context, "/sign-in");
          _lastLifecyleState = AppLifecycleState.inactive;
          break;
        case "AppLifecycleState.resumed":
          _lastLifecyleState = AppLifecycleState.resumed;
          break;
        case "AppLifecycleState.suspending":
          _lastLifecyleState = AppLifecycleState.suspending;
          break;
        default:
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleAppLifecycleState();

    //helper = DatabaseHelper.instance;
    HeatDao.getAllHeat().then((heatList){
      if(heatList != null && heatList.length > 0) {
        // clean local heat first
        HeatDao.removeHeatLocal();
        // insert heats
        HeatDao.saveAllHeats(heatList);
      }
    });

    PersonDao.getAllPersons();

    Future.delayed(const Duration(seconds: 3), () {
      /*Preferences.getSharedValue("currentScreen").then((val){
        if(val != null) {
          print("current screen == ${val}");
          Preferences.getSharedValue("currentScreen").then((val1){
            Navigator.pushNamed(context, "/${val1}");
          });
        }
        else {
          Preferences.setSharedValue("currentScreen", "deviceMode");
          Navigator.pushNamed(context, '/deviceMode');
        }
      });*/
    });

    InitializationUtil.initData().then((dt){
      Navigator.pushNamed(context, '/sign-in');
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